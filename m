Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267020AbUBSIwe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 03:52:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267055AbUBSIwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 03:52:34 -0500
Received: from nsmtp.pacific.net.th ([203.121.130.117]:53494 "EHLO
	nsmtp.pacific.net.th") by vger.kernel.org with ESMTP
	id S267020AbUBSIwd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 03:52:33 -0500
Date: Thu, 19 Feb 2004 17:00:05 +0800
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: Reserved page flaging of 2.4 kernel memory changed recently?
Cc: "Andrea Arcangeli" <andrea@suse.de>,
       "Nigel Cunningham" <ncunningham@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
References: <200402050941.34155.mhf@linuxmail.org> <20040208020624.GG31926@dualathlon.random> <200402100625.41288.mhf@linuxmail.org> <20040219072629.GB467@openzaurus.ucw.cz>
From: "Michael Frank" <mhf@linuxmail.org>
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <opr3l0mfdw4evsfm@smtp.pacific.net.th>
In-Reply-To: <20040219072629.GB467@openzaurus.ucw.cz>
User-Agent: Opera M2/7.50 (Linux, build 600)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Feb 2004 08:26:30 +0100, Pavel Machek <pavel@suse.cz> wrote:

> Hi!
>

mhf wrote:

>> I actually would like to rename the bit PG_nosave to PG_donttouch ;)

to make a point with regard to:

	no transfer of page contents during suspend/resume
	no netdump
	no debugger access without override

... but the name does not matter and we do not have to change it.

>
> Its used for swsusp internal data, too...

Yes of course - how else would swsusp run, but these data are also not  
"touched"
during suspend and resume wrt transfer of page content.

x86 Pages for PG_nosave:

Video/BIOS 0xA0000-0XFFFFF
Anything reserved < max_pfn
Pentium 2 broken highmem pages
Driver specific areas in DMA zone are also thinkable

.. or else you get mce's or possibly crashes on newer x86 HW and on 64Bit  
for sure.
	- we had a mce recently at 0xa0000 on a Athlon XP and I went digging...

Regards
Michael

-- 
Using M2, Opera's revolutionary e-mail client: http://www.opera.com/m2/
