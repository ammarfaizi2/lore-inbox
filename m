Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264414AbTLGLoL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 06:44:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264415AbTLGLoL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 06:44:11 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:48079 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264414AbTLGLoH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 06:44:07 -0500
Date: Sun, 7 Dec 2003 12:44:00 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, Nuno Monteiro <nmonteiro@uk2.net>,
       torvalds@osdl.org
Subject: Re: [PATCH] Re: linking problem with 2.6.0-test6-bk10 (fwd)
Message-ID: <20031207114359.GU20739@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

the trivial patch by Nuno Monteiro forwarded below still applies against
-test11. Is there a reason why it wasn't applied?

cu
Adrian


----- Forwarded message from Nuno Monteiro <nmonteiro@uk2.net> -----

Date:	Fri, 10 Oct 2003 02:42:06 +0100
From: Nuno Monteiro <nmonteiro@uk2.net>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Re: linking problem with 2.6.0-test6-bk10

On 2003.10.10 01:55, Dave Jones wrote:
> 
> As well as looking pretty ugly, I can't convince myself this is safe.
> I think it's going to be better off making that whole code compile out
> if MTRRs are disabled. MTRR is a must-have if we want this code to actually
> work anyway.
> 
> Either change the ifdef at the top of centaur.c to 
> #ifdef CONFIG_X86_OOSTORE && CONFIG_MTRR, or futz around it in the
> Kconfig, by changing the X86_OOSTORE depends line to
> 


Hi Dave,


Right you are :)

Here is the updated fix.


--- linux-2.6.0-test7/arch/i386/Kconfig.orig	2003-10-10 02:24:47.000000000 +0100
+++ linux-2.6.0-test7/arch/i386/Kconfig	2003-10-10 02:16:14.000000000 +0100
@@ -394,7 +394,7 @@ config X86_USE_3DNOW
 
 config X86_OOSTORE
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6
+	depends on (MWINCHIP3D || MWINCHIP2 || MWINCHIPC6) && MTRR
 	default y
 
 config HPET_TIMER
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

----- End forwarded message -----

