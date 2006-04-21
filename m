Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750794AbWDUWC2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750794AbWDUWC2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Apr 2006 18:02:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751364AbWDUWC1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Apr 2006 18:02:27 -0400
Received: from ns.suse.de ([195.135.220.2]:13262 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750794AbWDUWC1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Apr 2006 18:02:27 -0400
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux 2.6.17-rc2
Date: Sat, 22 Apr 2006 00:02:16 +0200
User-Agent: KMail/1.9.1
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.64.0604182013560.3701@g5.osdl.org> <200604211121.20036.s0348365@sms.ed.ac.uk> <Pine.LNX.4.64.0604210932020.3701@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0604210932020.3701@g5.osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200604220002.16824.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 21 April 2006 18:40, Linus Torvalds wrote:
> On Fri, 21 Apr 2006, Alistair John Strachan wrote:
> > Something in here (or -rc1, I didn't test that) broke WINE. x86-64
> > kernel, 32bit WINE, works fine on 2.6.16.7. I'll check whether -rc1 had
> > the same problem and work backwards, but just in case somebody has an
> > idea..
>
> Nothing strikes me, but maybe Andi has a clue.

NX for 32bit programs is enabled by default now. Does it 
work with noexec32=off?

If it's that then it won't work with PAE kernels on i386 and NX
capable machines neither - i just changed the default to be
the same as 32bit, but unlike 32bit all x86-64 kernels use PAE
and many of the systems have NX.

If it's not that  don't know what it could be. I actually even used a simple 
wine program with a post rc2 kernel and it worked for me.

So it isn't anything fundamental. Maybe some bad interaction
with copy protection again, but I don't remember changing ptrace
at all this time.

> Alistair, if you can do a "git bisect" on this one, that would help.

If noexec32=off doesn't help please do.
If noexec32 helps then it's likely a wine bug for using the wrong
protections.

-Andi
 
