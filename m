Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751013AbWFFVn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751013AbWFFVn0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbWFFVn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:43:26 -0400
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:1153
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S1751013AbWFFVnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:43:25 -0400
Message-ID: <4485F6F2.4050701@microgate.com>
Date: Tue, 06 Jun 2006 16:43:14 -0500
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Randy.Dunlap" <rdunlap@xenotime.net>
CC: Krzysztof Halasa <khc@pm.waw.pl>, davej@redhat.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, zippel@linux-m68k.org
Subject: Re: [PATCH] fix missing hdlc symbols for synclink drivers
References: <20060603232004.68c4e1e3.akpm@osdl.org>	<20060605230248.GE3963@redhat.com>	<20060605184407.230bcf73.rdunlap@xenotime.net>	<1149622813.11929.3.camel@amdx2.microgate.com>	<m3u06yc9mr.fsf@defiant.localdomain>	<4485E723.4070201@microgate.com>	<m3lksac7op.fsf@defiant.localdomain> <20060606142022.b184d1c5.rdunlap@xenotime.net>
In-Reply-To: <20060606142022.b184d1c5.rdunlap@xenotime.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap wrote:
> On Tue, 06 Jun 2006 23:09:42 +0200 Krzysztof Halasa wrote:
>>I.e., I would probably change:
>>
>>#ifdef CONFIG_HDLC_MODULE
>>#define CONFIG_HDLC 1
>>#endif

These macros have already been replaced in the synclink drivers.

> So SYNCLINK has different capabilities depending on whether
> HDLC=m or HDLC=y ??

No, the current situation is generic HDLC support is
an optional configuration for the synclink drivers.
The build option of generic HDLC must match that
of the synclink driver if that option is enabled.

if synclink is 'y' with generic HDLC option enabled,
then the generic HDLC module must be 'y'

if synclink is 'm' with generic HDLC option enabled,
then generic HDLC can be 'y' or 'm'

if synclink is 'y' or 'm' without the generic HDLC option,
then it is not necessary to build/load the generic HDLC module

--

The Kconfig addition of 'select WAN if SYNCLINK_XX_HDLC'
enables the above behavior.

I thought the Makefile change was to allow generic HDLC
to build as a module. I'll need to look at that closer.

--
Paul
