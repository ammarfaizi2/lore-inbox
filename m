Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267557AbUG3AIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267557AbUG3AIL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 20:08:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267562AbUG3AHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 20:07:51 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:49084 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S267548AbUG3AFN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 20:05:13 -0400
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@osdl.org>,
       suparna@in.ibm.com, fastboot@osdl.org, mbligh@aracnet.com,
       jbarnes@engr.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] Re: Announce: dumpfs v0.01 - common RAS output API
References: <E1BqJQF-00053v-00@w-gerrit2>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 29 Jul 2004 18:04:06 -0600
In-Reply-To: <E1BqJQF-00053v-00@w-gerrit2>
Message-ID: <m1zn5i2weh.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerrit Huizenga <gh@us.ibm.com> writes:

> On Thu, 29 Jul 2004 22:20:13 BST, Alan Cox wrote:
> > 
> > On Iau, 2004-07-29 at 19:17, Andrew Morton wrote:
> > > Of course, there's an assumption here that the dead kernel doesn't scribble
> > > on pages which were never available to its page allocator.  If DMA somehow
> > > goes off and scribbles on the dump kernel we lose.
> > 
> > If the new kernel image starts with an SHA hash check including the
> > SHA hash check code that can be pretty robust as a sanity check.
> > 
> > > See above.  We assume that network RX DMA won't be scribbling in the 16MB
> > > which was pre-reserved.  That's reasonable.  We _have_ to assume that.
> > 
> > Ok
> 
> Okay, I may be confused a bit but I *thought* kexec was going to
> load the thin, new kernel (e.g. read from disk operations, which is
> better than write to disk operations from the sick kernel).

/sbin/kexec will load it with sys_kexec_load, before the kernel becomes
sick.
 
> This concept of having it pre-loaded sounds interesting, protecting
> it from being written on doesn't bother me much, but why *not* read
> it from disk/filesystem and then use the SHA hash in the newly
> loaded & exec'd kernel to make sure that what we loaded was sane?

Exactly.  That is where the SHA hash and all of the features will
go in the new ``kernel''.  What we are exec is an arbitrary
stand-alone program.  I suspect a SHA hash generator and checker
is something we can easily add as a wrapper. 

> That sounds simpler than changing the kernel load process around,
> ensuring you have the new kexec'd kernel build and loaded, etc.
> At least it sounds simpler and more in line with using kexec for
> fastboot as well.

The only process that is going to be changed around is where
we store the kernel before we transfer control to it, and when/and
how that transfer of control happens.

The beauty of kexec is all of these fun things become user 
problems from the point of the view of the sick kernel so
it does not need to worry about them.

I will be happy to see a SHA patch for /sbin/kexec.  

Eric
