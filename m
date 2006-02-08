Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbWBHClJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbWBHClJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 21:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965176AbWBHClI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 21:41:08 -0500
Received: from adsl-70-250-156-241.dsl.austtx.swbell.net ([70.250.156.241]:2020
	"EHLO gw.microgate.com") by vger.kernel.org with ESMTP
	id S965172AbWBHClH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 21:41:07 -0500
Message-ID: <43E95A40.7010905@microgate.com>
Date: Tue, 07 Feb 2006 20:41:04 -0600
From: Paul Fulghum <paulkf@microgate.com>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new tty buffering locking fix
References: <200602032312.k13NCbWb012991@hera.kernel.org>	 <20060207123450.GA854@suse.de>	 <1139329302.3019.14.camel@amdx2.microgate.com>	 <20060207171111.GA15912@suse.de>	 <1139347644.3174.16.camel@amdx2.microgate.com> <1139361293.22595.14.camel@localhost.localdomain>
In-Reply-To: <1139361293.22595.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Thats going to hurt memory consumption in the worst cases.

I'll gather some accounting info tomorrow,
and consider the more pathological cases.

 > Might be better to document the sane behaviour and enforce it ?

That was my first thought, which prompted my
initial patch of the hvc drivers.

Requiring a call to schedule processing of tty data
after preallocating buffer space is not obvious,
and could result in scheduling work when there is no
data to process.

This semantic twist introduced by my first locking patch
is a hazard for driver writers, and would require an audit
of existing drivers (as demonstrated by Olaf's report).

--
Paul Fulghum
Microgate Systems, Ltd

