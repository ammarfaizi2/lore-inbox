Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262079AbVBPS21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262079AbVBPS21 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 13:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262090AbVBPS21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 13:28:27 -0500
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:931 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262079AbVBPS2Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 13:28:16 -0500
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Partial fix! - Was: Re: [BUG report] UML linux-2.6 latest BK doesn't compile
Date: Wed, 16 Feb 2005 19:27:03 +0100
User-Agent: KMail/1.7.2
Cc: Anton Altaparmakov <aia21@cam.ac.uk>, Jeff Dike <jdike@addtoit.com>,
       lkml <linux-kernel@vger.kernel.org>
References: <1107857395.15872.2.camel@imp.csi.cam.ac.uk> <200502082223.j18MMxs0013724@ccure.user-mode-linux.org> <1108380903.22656.9.camel@imp.csi.cam.ac.uk>
In-Reply-To: <1108380903.22656.9.camel@imp.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502161927.05897.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 February 2005 12:35, Anton Altaparmakov wrote:
> On Tue, 2005-02-08 at 17:22 -0500, Jeff Dike wrote:
> > blaisorblade@yahoo.it said:
> > > Why not simply disable CONFIG_GCOV for him, in this case?
> >
> > Anton presumably turned on CONFIG_GCOV because he wanted to do some
> > profiling...
>
> Yes.  I finally found a way to get it to compile.  Compiling without TT
> mode and WITHOUT static build it still fails with the same problem
> (__bb_init_func problem I already reported).  But compiling without TT
> but WITH static build the __bb_init_func problem goes away but instead I
> get a __gcov_init missing symbol in my modules.
>
> Note I have gcc-3.3.4-11 (SuSE 9.2) and it defines __gcov_init.  So I
> added this as an export symbol and lo and behold the kernel and modules
> compiled and I am now up an running with UML and NTFS as a module.  (-:

What do we do for previous GCC, which probably do not define _gcov_init (at 
least I guess, since things worked before)? We'll get a "unresolved symbol" 
in the kernel linking, I guess (unverified).

It is possible, even if ugly, to $(NM) the relevant libraries to choose what 
to do, by adding a -D__EXPORT_GCOV_INIT_ (or even, if we know well, to 
indicate the GCC version needed for this).

So, for now, I guess we must defer this to later than 2.6.11...

> Here is the patch that I used to fix this:
>
> --- ntfs-2.6-devel/arch/um/kernel/gmon_syms.c.old 2005-02-14
> 11:27:04.789474410 +0000 +++
> ntfs-2.6-devel/arch/um/kernel/gmon_syms.c 2005-02-14 11:26:49.191117739
> +0000 @@ -8,6 +8,9 @@
>  extern void __bb_init_func(void *);
>  EXPORT_SYMBOL(__bb_init_func);
>
> +extern void __gcov_init(void *);
> +EXPORT_SYMBOL(__gcov_init);
> +
>  /*
>   * Overrides for Emacs so that we follow Linus's tabbing style.
>   * Emacs will notice this stuff at the end of the file and automatically
>
> Best regards,
>
>         Anton

-- 
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

