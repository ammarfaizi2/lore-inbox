Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263928AbUECTqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263928AbUECTqT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 15:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263932AbUECTqB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 15:46:01 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:29603 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263928AbUECTp6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 15:45:58 -0400
Date: Mon, 3 May 2004 20:45:58 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] removal of legacy cdrom drivers (Re: [PATCH] mcdx.c insanity removal)
Message-ID: <20040503194558.GF17014@parcelfarce.linux.theplanet.co.uk>
References: <20040502024637.GV17014@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.58.0405011953140.18014@ppc970.osdl.org> <20040503011629.GY17014@parcelfarce.linux.theplanet.co.uk> <4095BAA3.3050000@keyaccess.nl> <20040503055934.GA17014@parcelfarce.linux.theplanet.co.uk> <40968A9F.6070608@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40968A9F.6070608@keyaccess.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 03, 2004 at 08:08:31PM +0200, Rene Herman wrote:
> viro@parcelfarce.linux.theplanet.co.uk wrote:
> 
> >OK...  So we have
> >	* potentially faulty mcdx (2.4, apparently either driver corrupts
> >memory in some conditions or isofs does the same for some IO failures -
> >need to take a look at that report more carefully).
> >	* cdu31a (FUBAR driver, nasty to fix, "most of the time" works on
> >2.6)
> >	* sbpcd (at least two, both untested with 2.6)
> 
> 3y25:~$ mount | grep cdrom
> /dev/sbpcd on /mnt/cdrom type iso9660 (ro,noexec,nosuid,nodev)
> 3y25:~$ ls /mnt/cdrom/
> cd.id*        install.exe*  lecdemos/     readme.doc*   resource/ 
> support/
> 
> However, any "cp" from cd-rom oopses the box.

oopses in driver, oopses by triggering BUG() or oopses in fs/*?  The last
two would be more interesting - isofs _MUST_ be able to survive any IO
errors, simply because CDs get scratched, etc. and that shouldn't crash
the box.

> I was actually planning to get around to that at some point. Somewhat 
> fond of this drive. As you say, driver is a disaster area; a few trivial 
> fixes are not what it wants and at this point, fixing it properly would 
> not be a trivial undertaking for me. Am also currently very busy 
> elsewhere. Could it be kept around a bit?

Free advice: if you want to handle that one, fork off the bits you really
need.  Keeping the drivers for all variants together simply doesn't pay,
and even the excuse of keeping the development in single codebase doesn't
apply anymore for what, 7 years?
