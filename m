Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTFBMW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTFBMWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:22:55 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:48339 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262253AbTFBMWy
	(ORCPT <rfc822;Linux-Kernel@Vger.Kernel.ORG>);
	Mon, 2 Jun 2003 08:22:54 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16091.17602.257293.364468@laputa.namesys.com>
Date: Mon, 2 Jun 2003 16:36:18 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Gianni Tedesco <gianni@scaramanga.co.uk>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Linus Torvalds <Torvalds@Transmeta.COM>, Andrew Morton <AKPM@Digeo.COM>
Subject: Re: const from include/asm-i386/byteorder.h
In-Reply-To: <20030602121457.GO8978@holomorphy.com>
References: <16088.47088.814881.791196@laputa.namesys.com>
	<1054406992.4837.0.camel@sherbert>
	<20030531185709.GK8978@holomorphy.com>
	<16091.14923.815819.792026@laputa.namesys.com>
	<20030602121457.GO8978@holomorphy.com>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta11) "cabbage" XEmacs Lucid
X-Windows: dissatisfaction guaranteed.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
 > On Mon, Jun 02, 2003 at 03:51:39PM +0400, Nikita Danilov wrote:
 > > Gcc info page:
 > > `const'
 > >      Many functions do not examine any values except their arguments,
 > >      and have no effects except the return value.  Basically this is
 > >      just slightly more strict class than the `pure' attribute above,
 > >      since function is not allowed to read global memory.
 > > So, it seems byte swapping functions should be __attribute__((const))
 > > Here is a patch:
 > 
 > I'm very skeptical, in particular, about these hunks:
 > 
 > 
 > On Mon, Jun 02, 2003 at 03:51:39PM +0400, Nikita Danilov wrote:
 > >  #include <linux/thread_info.h>
 > > -static inline struct task_struct *get_current(void) __attribute__ (( __const__ ));
 > > +static inline struct task_struct *get_current(void) __attribute_const;
 > >  static inline struct task_struct *get_current(void)
 > >  {
 > > ===== include/asm-arm/thread_info.h 1.6 vs edited =====
 > > --- 1.6/include/asm-arm/thread_info.h	Sat Dec 28 19:26:45 2002
 > > +++ edited/include/asm-arm/thread_info.h	Mon Jun  2 14:44:24 2003
 > > @@ -74,7 +74,7 @@
 > >  /*
 > >   * how to get the thread information struct from C
 > >   */
 > > -static inline struct thread_info *current_thread_info(void) __attribute__ (( __const__ ));
 > > +static inline struct thread_info *current_thread_info(void) __attribute_const;
 > >  
 > >  static inline struct thread_info *current_thread_info(void)
 > >  {
 > 
 > Someone needs to doublecheck whether this actually works. Last I heard,

I don't quite understand. __attribute_const is defined as

#define __attribute_const __attribute__ ((__const__))

so, after preprocessing prototypes of get_current() and
current_thread_info() will be the same as before patch, modulo spacing.

 > it did not, but that could have changed since. It vaguely appears some
 > assumption about it working was made recently since __const__ was there.
 > 

I am currently running ./fsstress -p 111 on patched kernel on 2*XEON
2.20GHz with hyper threading.

 > 
 > -- wli

Nikita.
