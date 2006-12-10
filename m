Return-Path: <linux-kernel-owner+w=401wt.eu-S1759618AbWLJCuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759618AbWLJCuJ (ORCPT <rfc822;w@1wt.eu>);
	Sat, 9 Dec 2006 21:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759647AbWLJCuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Dec 2006 21:50:09 -0500
Received: from gateway.insightbb.com ([74.128.0.19]:14112 "EHLO
	asav03.insightbb.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759618AbWLJCuH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Dec 2006 21:50:07 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: Ao8CAGoEe0VKhQ0nVWdsb2JhbACNNAEr
From: Dmitry Torokhov <dtor@insightbb.com>
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH] ucb1400_ts depends SND_AC97_BUS
Date: Sat, 9 Dec 2006 21:50:01 -0500
User-Agent: KMail/1.9.3
Cc: lkml <linux-kernel@vger.kernel.org>, akpm <akpm@osdl.org>
References: <20061209003635.e778ff76.randy.dunlap@oracle.com>
In-Reply-To: <20061209003635.e778ff76.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612092150.02940.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 December 2006 03:36, Randy Dunlap wrote:
> From: Randy Dunlap <randy.dunlap@oracle.com>
> 
> This driver is an AC97 codec according to its help text.
> However, if SOUND is disabled, the "select SND_AC97_BUS"
> still inserts that into the .config file:
> 
> #
> # Sound
> #
> # CONFIG_SOUND is not set
> CONFIG_SND_AC97_BUS=m
> 

I consider this abug in kconfig - users of "select" should not know
full dependency chain for selected symbol.

> Even if the config software followed dependency chains on selects,
> we should try to limit usage of "select" to library-type
> code that is needed (e.g., CRC functions) instead of bus-type
> support.
>

I do not agree here - the way our directory structure is laid out
"sound" comes after "Input device support" menuconfig entry.
Your patch makes user go back and forth in menuconfig, which is
awkward. I think using select is fine when an option depends on
something down the stream. If user already had a chance to select
necessary option then using "depends on" is preferred.

-- 
Dmitry
