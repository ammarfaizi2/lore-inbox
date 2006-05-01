Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932121AbWEAOpU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932121AbWEAOpU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 10:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932123AbWEAOpU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 10:45:20 -0400
Received: from [198.99.130.12] ([198.99.130.12]:39046 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932121AbWEAOpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 10:45:19 -0400
Date: Mon, 1 May 2006 09:45:52 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Blaisorblade <blaisorblade@yahoo.it>,
       user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org,
       Heiko Carstens <heiko.carstens@de.ibm.com>,
       Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Subject: Re: [uml-devel] [RFC] PATCH 3/4 - Time virtualization : PTRACE_SYSCALL_MASK
Message-ID: <20060501134552.GA3686@ccure.user-mode-linux.org>
References: <200604131720.k3DHKqdr004720@ccure.user-mode-linux.org> <200604261747.54660.blaisorblade@yahoo.it> <20060426154607.GA8628@ccure.user-mode-linux.org> <200604282228.46681.blaisorblade@yahoo.it> <20060429014956.GB9734@ccure.user-mode-linux.org> <20060501135127.GA1276@nevyn.them.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060501135127.GA1276@nevyn.them.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 09:51:27AM -0400, Daniel Jacobowitz wrote:
> On Fri, Apr 28, 2006 at 09:49:56PM -0400, Jeff Dike wrote:
> > On Fri, Apr 28, 2006 at 10:28:46PM +0200, Blaisorblade wrote:
> > > bitmask = 0;
> > > set_bit(__NR_tee, bitmask);
> > > ptrace(PTRACE_SET_TRACEONLY, bitmask);
> > 
> > Yup, I like this.
> 
> I really recommend you not do this.  

> Suppose the kernel knows about 32 more syscalls than userspace.  It's
> going to read extra bits out of the bitmask that userspace didn't
> initialize!

The example above is a sketch, not a fully formed, compilable user.  Every
proposed interface has had the mask length passed in - in the case
above in the data argument.

> Also, if you store the mask with the child process, it risks surprising
> existing tracers: attach, set mask, detach, then the next time someone
> attaches an old version of strace some syscalls will be "hidden".

Not if the mask only survives for the duration of a PTRACE_ATTACH, and
the mask is released on PTRACE_DETACH.

				Jeff
