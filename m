Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130300AbQLVUmt>; Fri, 22 Dec 2000 15:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130706AbQLVUmj>; Fri, 22 Dec 2000 15:42:39 -0500
Received: from Cantor.suse.de ([194.112.123.193]:24334 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S130300AbQLVUmY>;
	Fri, 22 Dec 2000 15:42:24 -0500
Date: Fri, 22 Dec 2000 21:11:56 +0100
From: Andi Kleen <ak@suse.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: recommended gcc compiler version
Message-ID: <20001222211156.A28354@gruyere.muc.suse.de>
In-Reply-To: <0012212320430F.02217@comptechnews> <E149NvR-0004Kz-00@the-village.bc.nu> <9209qq$7pf$1@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9209qq$7pf$1@penguin.transmeta.com>; from torvalds@transmeta.com on Fri, Dec 22, 2000 at 11:25:14AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 22, 2000 at 11:25:14AM -0800, Linus Torvalds wrote:
> In article <E149NvR-0004Kz-00@the-village.bc.nu>,
> Alan Cox  <alan@lxorguk.ukuu.org.uk> wrote:
> >
> >2.4.0test
> >	egcs-1.1.2
> >	(gcc 2.95 miscompiles some of the long long uses)
> >	Red Hat's 2.96 seems to generate valid kernels but don't expect
> >		sympathy if you report a bug in one built that way
> 
> Now, now, I'd love to se reports of expecially the new updated compiler. 
> I've not actually seen a single report of problems for the kernel even
> with the old 2.96, it's just that I've seen too many user-space problems
> that I would be hesitant to use it for the kernel. 

I'm working with a 2.97 based compiler for x86-64. There are a few
miscompilations, but they're probably more attributable to the immature state
of the x86-64 port than the generic compiler. The first thing 
that is noticeable are lots of warnings now spewed out by the compiler.
Appended patch fixes the __setup related at least.
Other common ones are token after #endif (mostly #ifdef X .. #endif X) 
and semicolon/label at the end of switch.


-Andi


Index: include/linux/init.h
===================================================================
RCS file: /cvs/linux/include/linux/init.h,v
retrieving revision 1.23
diff -u -u -r1.23 init.h
--- include/linux/init.h	2000/11/15 00:13:57	1.23
+++ include/linux/init.h	2000/12/22 20:38:54
@@ -65,7 +65,7 @@
 
 #define __setup(str, fn)								\
 	static char __setup_str_##fn[] __initdata = str;				\
-	static struct kernel_param __setup_##fn __initsetup = { __setup_str_##fn, fn }
+	static struct kernel_param __setup_##fn __attribute__((unused)) __initsetup = { __setup_str_##fn, fn }
 
 #endif /* __ASSEMBLY__ */
 
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
