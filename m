Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264019AbUFFTA7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264019AbUFFTA7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jun 2004 15:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264012AbUFFTA7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jun 2004 15:00:59 -0400
Received: from fw.osdl.org ([65.172.181.6]:35981 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264019AbUFFTA6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jun 2004 15:00:58 -0400
Date: Sun, 6 Jun 2004 12:00:54 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Simon Kirby <sim@netnation.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: clone() <-> getpid() bug in 2.6?
In-Reply-To: <20040606185319.GA5022@netnation.com>
Message-ID: <Pine.LNX.4.58.0406061155290.7010@ppc970.osdl.org>
References: <Pine.LNX.4.58.0406051341340.7010@ppc970.osdl.org>
 <20040605205547.GD20716@devserv.devel.redhat.com> <20040605215346.GB29525@taniwha.stupidest.org>
 <1086475663.7940.50.camel@localhost> <Pine.LNX.4.58.0406051553130.2261@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0406051610430.7010@ppc970.osdl.org> <40C2A6E4.7020103@ThinRope.net>
 <Pine.LNX.4.58.0406052244290.7010@ppc970.osdl.org> <20040606075754.GA10642@codepoet.org>
 <Pine.LNX.4.58.0406060937330.7010@ppc970.osdl.org> <20040606185319.GA5022@netnation.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sun, 6 Jun 2004, Simon Kirby wrote:
> 
> Unrelated to this discussion -- and there is a close() missing -- but is
> there any reason for fsync() to be there?

It only matters if the lock is meaningful over an involuntary reboot (aka
crash). Usually it isn't. So yes, the fsync() is usually not necessary.

Sometimes the lock file may contain real data that is meaningful for 
recovery, though. The pid generally isn't, but it could point to a log 
that describes what the thing was about to do. Or it could just be helpful 
on next reboot when you have a stale lockfile, and you want to match that 
lockfile to any syslog messages or similar.

		Linus
