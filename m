Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263472AbTKQMLl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 07:11:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263475AbTKQMLl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 07:11:41 -0500
Received: from eik.ii.uib.no ([129.177.16.3]:8441 "EHLO mail.ii.uib.no")
	by vger.kernel.org with ESMTP id S263472AbTKQMLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 07:11:40 -0500
Subject: Re: Terrible interactivity with 2.6.0-t9-mm3
From: "Ronny V. Vindenes" <s864@ii.uib.no>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069071092.3238.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 17 Nov 2003 13:11:32 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.9 (+)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1ALiEC-00060z-00*FJBNwQjevqQ*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Gawain Lynch <gawain@freda.homelinux.org> wrote:
> >
> > On Mon, 2003-11-17 at 08:42, Andrew Morton wrote:
> > > Two things to try, please:
> > > 
> > > a) Is the problem from Linus's tree?  Try 2.6.0-test9 plus 
> > >
	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm3/broken-out/linus.patch
> > > 
> > > b) The only significant scheduler change in mm3 was 
> > >
	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test9/2.6.0-test9-mm3/broken-out/context-switch-accounting-fix.patch
> > > 	
> > >    So please try -mm3 with the above patch reverted with
> > > 
> > > 	patch -R -p1 < context-switch-accounting-fix.patch
> > > 
> > 
> > Hi Andrew,
> > 
> > This is also easily reproducible here with just a kernel compile.
> > 
> > I have tried both a) and b) with b) not changing anything, but a)
seems
> > to work...  Anything more to try?
> > 
> 
> Your report has totally confused me.  Are you saying that the
jerkiness is
> caused by linus.patch?  Or not?  Pleas try again ;)
> 

I've found that neither linus.patch nor
context-switch-accounting-fix.patch is causing the problem, but rather
acpi-pm-timer-fixes.patch & acpi-pm-timer.patch

With these applied my cpu (athlon64) is detected as 0.0Mhz, bogomips
drops to 50% and anything cpu intensive destroys interactivity. Revert
them and performance is back at -mm2 level.

-- 
Ronny V. Vindenes <s864@ii.uib.no>

