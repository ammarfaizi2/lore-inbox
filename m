Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266263AbUGOTIm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266263AbUGOTIm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jul 2004 15:08:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266275AbUGOTIm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jul 2004 15:08:42 -0400
Received: from aun.it.uu.se ([130.238.12.36]:19688 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266263AbUGOTIk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jul 2004 15:08:40 -0400
Date: Thu, 15 Jul 2004 21:08:27 +0200 (MEST)
Message-Id: <200407151908.i6FJ8R4w011726@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: Re: 2.6.8-rc1-mm1 "Badness in schedule" on ppc32
Cc: jhf@rivenstone.net, linux-kernel@vger.kernel.org,
       trini@kernel.crashing.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Jul 2004 02:00:01 +0200 (MEST), Mikael Pettersson wrote:
>On 2004-07-14 22:01:50, Tom Rini wrote:
>>On Fri, Jul 09, 2004 at 02:11:03PM -0700, Andrew Morton wrote:
>>
>>> 
>>> jhf@rivenstone.net (Joseph Fannin) wrote:
>>> > 
>>> > On Thu, Jul 08, 2004 at 11:50:25PM -0700, Andrew Morton wrote:
>>> > > 
>>> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
>>> > 
>>> > > +detect-too-early-schedule-attempts.patch
>>> > > 
>>> > > Catch attempts to call the scheduler before it is ready to go.
>>> > 
>>> > With this patch, my Powermac (ppc32) spews 711 (I think)
>>> > warning messages during bootup.
>>> 
>>> hm, OK.  It could be that the debug patch is a bit too aggressive, or that
>>> ppc got lucky and happens to always be in state TASK_RUNNING when these
>>> calls to schedule() occur.
>>> 
>>> Maybe this task incorrectly has _TIF_NEED_RESCHED set?
>>> 
>>> Anyway, ppc guys: please take a look at the results from
>>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/broken \
>>> -out/detect-too-early-schedule-attempts.patch and check that the kernel really \
>>> should be calling schedule() at this time and place, let us know?
>>
>>Now that kallsyms data is OK, I took a quick look.. and all of this
>>comes from generic code, at least on the machine I tried.  So if the
>>code shouldn't be calling schedule() then, it's a more generic problem..
>>
>>... or I'm not following.
>
>On my ppc32 (G3 PowerMac) 2.6.8-rc1-mm1 throws a large number of
>"Badness in schedule" during boot. Below are the ones I managed
>to capture: they contain both generic traces, and traces involving
>Mac-only drivers.
>
>Some of the traces involve the PDC202XX_NEW driver; I'll move that
>card into an x86 PC tomorrow to see if the traces reappear or not;
>if they don't then it does look like a PPC32-specific problem.

Tried that now but I've been unable to trigger any
"Badness in schedule" messages on the x86 box.
Looks like PPC32 has a problem in -mm.

/Mikael
