Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbTJJBmK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 21:42:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262718AbTJJBmK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 21:42:10 -0400
Received: from fep01-svc.mail.telepac.pt ([194.65.5.200]:1680 "EHLO
	fep01-svc.mail.telepac.pt") by vger.kernel.org with ESMTP
	id S262714AbTJJBmG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 21:42:06 -0400
Date: Fri, 10 Oct 2003 02:42:06 +0100
From: Nuno Monteiro <nmonteiro@uk2.net>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] Re: linking problem with 2.6.0-test6-bk10
Message-ID: <20031010014206.GA9121@hobbes.itsari.int>
References: <42450.212.113.164.100.1065637962.squirrel@maxproxy1.uk2net.com> <20031008200420.GA23545@redhat.com> <57145.212.113.164.100.1065647937.squirrel@maxproxy3.uk2net.com> <20031009234000.GC4683@hobbes.itsari.int> <20031010004047.GE4683@hobbes.itsari.int> <20031010004224.GH4683@hobbes.itsari.int> <20031010005521.GC25856@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20031010005521.GC25856@redhat.com> (from davej@redhat.com on Fri, Oct 10, 2003 at 01:55:22 +0100)
X-Mailer: Balsa 2.0.15
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
