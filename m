Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316535AbSHBP6x>; Fri, 2 Aug 2002 11:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316538AbSHBP6x>; Fri, 2 Aug 2002 11:58:53 -0400
Received: from h-66-134-96-17.PHLAPAFG.covad.net ([66.134.96.17]:16497 "EHLO
	intech19.enhanced.com") by vger.kernel.org with ESMTP
	id <S316535AbSHBP6l>; Fri, 2 Aug 2002 11:58:41 -0400
To: Daniel Barlow <dan@telent.net>
Cc: debian-alpha <debian-alpha@lists.debian.org>,
       linux-kernel <linux-kernel@vger.kernel.org>, gcl-devel@gnu.org
Subject: Re: [Gcl-devel] Re: SA_SIGINFO in Linux 2.4.x
References: <E17aOg0-0002ub-00@intech19.enhanced.com> <1028281936.17352.42.camel@satan.xko.dec.com> <87k7n9l9fk.fsf@noetbook.telent.net> <547kj9p872.fsf@intech19.enhanced.com>
From: Camm Maguire <camm@enhanced.com>
Date: 02 Aug 2002 12:01:08 -0400
In-Reply-To: Camm Maguire's message of "02 Aug 2002 11:54:41 -0400"
Message-ID: <5465ytntbv.fsf@intech19.enhanced.com>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!  Please forgive the last message -- it *does* work if you
use SA_SIGINFO in sigaction.  I was used to x86 where they put the
context on the stack in any case.

Take care,

Camm Maguire <camm@enhanced.com> writes:

> Greetings, and thanks for the suggestion!  But it doesn't seem to work
> for me: (Linux alpha 2.4.17)
> 
> =============================================================================
> Program received signal SIGSEGV, Segmentation fault.
> 0x1200a1a7c in read_object (in=0x120a61758) at read.d:531
> 531		token->st.st_fillp = length;
> (gdb) 
> p/x token
> p/x token
> $3 = 0x120745f18
> (gdb) c
> c
> Continuing.
> 
> Breakpoint 1, memprotect_handler (sig=544593856, code=4831823984, 
>     scp=0x1200a0684, addr=0x11fffc810 "ÃO\177 \001") at sgbc.c:1170
> 1170	memprotect_handler(int sig, long code, struct sigcontext *scp, char *addr) {
> (gdb) p/x *(struct ucontext *)scp
> p/x *(struct ucontext *)scp
> $4 = {uc_flags = 0x23bdd86c27ba005c, uc_link = 0xb42f002847e00401, 
>   __uc_osf_sigmask = 0xa45d9d20b3ef0030, uc_stack = {
>     ss_sp = 0xa45d9d20a43d9d20, ss_flags = 0xa4620000, 
>     ss_size = 0xa43d9088b4410000}, uc_mcontext = {
>     sc_onstack = 0x9d4100008d4f0038, sc_mask = 0x894f0040a43d80c0, 
>     sc_pc = 0xa43d9a4099410000, sc_ps = 0x99410000894f0044, sc_regs = {
>       0x894f0048a43dba50, 0xa45da75099410000, 0xa45da750a43da750, 
>       0x40611522a4620000, 0xa02f0030b4410000, 0xa43dba68e420000a, 
>       0xa43db6d8b3e10000, 0xa6010000a45d9718, 0xa77da9f8a6220000, 
>       0x27ba005c6b5b72c0, 0xa42f002823bdd7d0, 0xc3e0000047e10400, 
>       0xa75e000047ef041e, 0xa5fe0010a53e0008, 0x6bfa800123de0060, 
>       0x47ff041f2ffe0000, 0x47ff041f2ffe0000, 0x27bb005c2ffe0000, 
>       0xb7fef00023bdd790, 0xb75e000023dee840, 0x47fe040fb5fe0008, 
>       0xa43d9088b60f0010, 0x9d4f00288d410000, 0x89410000a43d80c0, 
>       0xa43d9a40994f0030, 0x994f003489410000, 0x89410000a43dba50, 
>       0xa43d9f40994f0038, 0x994f003c89410000, 0xa4410000a43da750, 
>       0x8d4f002847e20403, 0x404114029d430000}, 
>     sc_ownedfp = 0xb3ef0020b4410000, sc_fpregs = {0xa04f0020a43d9f40, 
>       0x404109a2a0210000, 0xc3e00018f4400001, 0x47e20401a04f0020, 
>       0x4022052140201441, 0x41e8140340201642, 0xa45db65840620401, 
>       0x47e40403a08f0020, 0x4064052340601443, 0x4044040240601644, 
>       0x8d6200088d420000, 0x9d4100008d820010, 0x9d8100109d610008, 
>       0x40203002a02f0020, 0xc3ffffe2b04f0020, 0x89410000a43d99d0, 
> ---Type <return> to continue, or q <return> to quit---
> 
> 
>       0xd35ffd79994f17b0, 0xa4410000a43d9d20, 0xb42f17b820220138, 
>       0xa44f17b8a43d9290, 0x404103a2a4210000, 0xa77dbaa8f4400004, 
>       0x27ba005c6b5b41e4, 0xa42f17b823bdd660, 0x8d420000a45d8b38, 
>       0xa42f17b89d410110, 0x8d420000a45da748, 0xa42f17b89d410118, 
>       0x2c610120205f0002, 0x4864004320810120, 0x4443040248440162, 
>       0xa42f17b83c410120}, sc_fpcr = 0xa0620000a45daab8, 
>     sc_fp_control = 0x2c61012147e30402, sc_reserved1 = 0x4864004320810121, 
>     sc_reserved2 = 0x4443040248440162, sc_ssize = 0xa42f17b83c410121, 
>     sc_sbase = 0xb4410128a45da8e0, sc_traparg_a0 = 0xa45d8b40a42f17b8, 
>     sc_traparg_a1 = 0x9d4101308d420000, sc_traparg_a2 = 0x8d4f17b8a43d9d20, 
>     sc_fp_trap_pc = 0xa60f17b89d410000, 
>     sc_fp_trigger_sum = 0x6b5b4000a77db808, 
>     sc_fp_trigger_inst = 0x23bdd5bc27ba005c}, uc_sigmask = {__val = {
>       0xc3ffffc8c3e00001, 0xa0410000a43dba68, 0x203f0001e4400003, 
>       0xc3e0001eb02f0024, 0xa77d99c8a60f0010, 0x27ba005c6b5b416e, 
>       0x47e0040123bdd588, 0xa43da750b42f0018, 0x47e20403a4410000, 
>       0x9d4300008d4f0018, 0xb441000040411402, 0xa0410000a43d9f40, 
>       0xa60f0018ec40000c, 0x6b5b5b15a77d94b8, 0x23bdd54427ba005c, 
>       0xa47da75047e00401}}}
> (gdb) 
> 
> 
> =============================================================================
> 
> Daniel Barlow <dan@telent.net> writes:
> 
> > On Fri, 2002-08-02 at 04:14, Camm Maguire wrote:
> > > Greetings!  The 2.4.x kernels on alpha don't appear to be filling in
> > > the si_addr element of the siginfo_t structure when a signal handler
> > > is setup with SA_SIGINFO.  Is this right?  Any other way to get this
> > > address in the handler?
> > 
> > You may be able to use the third argument to the signal handler:
> > given a handler declared as (int n, siginfo_t *info,struct ucontext *context),
> > look at context->uc_mcontext.sc_traparg_a0 
> > 
> > SBCL has been doing this for a few months now and nobody has yet
> > complained that it's broken for them.  Look for arch_get_bad_addr 
> > in http://cvs.sourceforge.net/cgi-bin/viewcvs.cgi/sbcl/sbcl/src/runtime/alpha-arch.c?rev=1.14&content-type=text/vnd.viewcvs-markup
> > 
> > 
> > 
> > -dan
> > 
> > -- 
> > 
> >   http://ww.telent.net/cliki/ - Link farm for free CL-on-Unix resources 
> > 
> > 
> 
> -- 
> Camm Maguire			     			camm@enhanced.com
> ==========================================================================
> "The earth is but one country, and mankind its citizens."  --  Baha'u'llah
> 
> _______________________________________________
> Gcl-devel mailing list
> Gcl-devel@gnu.org
> http://mail.gnu.org/mailman/listinfo/gcl-devel
> 
> 

-- 
Camm Maguire			     			camm@enhanced.com
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
