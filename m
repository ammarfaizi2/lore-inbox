Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267501AbUG2Wk3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267501AbUG2Wk3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266877AbUG2WjO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:39:14 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:39607 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S267467AbUG2Wd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:33:58 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrew Morton <akpm@osdl.org>, suparna@in.ibm.com, fastboot@osdl.org,
       ebiederm@xmission.com, mbligh@aracnet.com, jbarnes@engr.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API 
In-reply-to: Your message of Thu, 29 Jul 2004 22:20:13 BST.
             <1091136012.1455.14.camel@localhost.localdomain> 
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <19459.1091140245.1@us.ibm.com>
Date: Thu, 29 Jul 2004 15:30:45 -0700
Message-Id: <E1BqJQF-00053v-00@w-gerrit2>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Jul 2004 22:20:13 BST, Alan Cox wrote:
> 
> On Iau, 2004-07-29 at 19:17, Andrew Morton wrote:
> > Of course, there's an assumption here that the dead kernel doesn't scribble
> > on pages which were never available to its page allocator.  If DMA somehow
> > goes off and scribbles on the dump kernel we lose.
> 
> If the new kernel image starts with an SHA hash check including the
> SHA hash check code that can be pretty robust as a sanity check.
> 
> > See above.  We assume that network RX DMA won't be scribbling in the 16MB
> > which was pre-reserved.  That's reasonable.  We _have_ to assume that.
> 
> Ok

Okay, I may be confused a bit but I *thought* kexec was going to
load the thin, new kernel (e.g. read from disk operations, which is
better than write to disk operations from the sick kernel).

This concept of having it pre-loaded sounds interesting, protecting
it from being written on doesn't bother me much, but why *not* read
it from disk/filesystem and then use the SHA hash in the newly
loaded & exec'd kernel to make sure that what we loaded was sane?

That sounds simpler than changing the kernel load process around,
ensuring you have the new kexec'd kernel build and loaded, etc.
At least it sounds simpler and more in line with using kexec for
fastboot as well.

gerrit
