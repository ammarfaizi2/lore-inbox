Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270370AbTGRUbX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 16:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270382AbTGRUal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 16:30:41 -0400
Received: from zero.aec.at ([193.170.194.10]:15633 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S270370AbTGRU3X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:29:23 -0400
To: linas@austin.ibm.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: KDB in the mainstream 2.4.x kernels?
From: Andi Kleen <ak@muc.de>
Date: Fri, 18 Jul 2003 22:43:57 +0200
In-Reply-To: <aJIn.3mj.15@gated-at.bofh.it> (linas@austin.ibm.com's message
 of "Fri, 18 Jul 2003 22:10:11 +0200")
Message-ID: <m3smp3y38y.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.090013 (Oort Gnus v0.13) Emacs/21.2 (i586-suse-linux)
References: <aJIn.3mj.15@gated-at.bofh.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


One argument i have against it: KDB is incredibly ugly code. 
Before it could be even considered for merging it would need quite a lot 
of cleanup.

I actually started on porting the KDB backtracer recently to get
reliable frame pointer based backtraces, but it turns out the code
for that is so complicated and ugly that the chances of ever merging
it would be very slim.

As for your home crash debugging I suspect you would be better of with LKCD
or Mcore (crash dump, saving an crash image on some partition, with examining
the crash dump after reboot) 

KDB is usually not useful for debugging hangs on desktop boxes (and even
many servers) because you have usually X running. When the machine crashes and
goes in KDB you cannot see the text output and debug anything. I learned
to type "go<return>" blind when I had still an KDB aware kernel, but
it's not very useful overall.

On a development machine you can avoid that by connecting a serial cable,
but that's usually not easily possible for a desktop box. Doing a post-mortem
after reboot is more practical. That is what LKCD/mcore do.

Disadvantage is that the current crash dump mechanisms (lkcd, mcore
crash, netdump) are all still not very reliable and have horrible
error handling. And you can eat a lot of disk space for the dumps and
they tend to overflow your file systems.  But still it's the only
realistic option for "desktop bugs"

BTW debugging on the X server works on linuxppc/mac with xmon because it 
has a fbcon based console and X server. The debugger can just
work on the X background while the X server is stopped. Very nifty. 
But I don't see the x86 XFree86 switching to a similar fbcon model any 
time soon, so it's unlikely to help.

-Andi
