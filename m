Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317282AbSGIA2C>; Mon, 8 Jul 2002 20:28:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317286AbSGIA2B>; Mon, 8 Jul 2002 20:28:01 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:25618 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S317282AbSGIA2A>;
	Mon, 8 Jul 2002 20:28:00 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] 2.5.25 net/core/Makefile 
In-reply-to: Your message of "Tue, 09 Jul 2002 01:11:35 +0100."
             <20020709001135.GA21383@suse.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 09 Jul 2002 10:30:31 +1000
Message-ID: <22345.1026174631@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jul 2002 01:11:35 +0100, 
Dave Jones <davej@suse.de> wrote:
>On Sat, Jul 06, 2002 at 06:30:29PM +1000, Keith Owens wrote:
> > The valid combination of CONFIG_NET=n, CONFIG_LLC undefined incorrectly
> > builds ext8022.o and gets unresolved references because there is no
> > network code.  Detected by kbuild 2.5, not detected by the existing
> > build system.
>
>And this breaks the valid combination of CONFIG_NET=y, CONFIG_LLC undef'd
>
>net/network.o: In function Register_8022_client':
>net/network.o(.text+0xe8b7): undefined reference to Llc_register_sap'
>net/network.o: In function Unregister_8022_client':
>net/network.o(.text+0xe8fe): undefined reference to Llc_unregister_sap'

??? That is the bug that I reported.  My patch fixes that bug.

Index: 25.1/net/core/Makefile
--- 25.1/net/core/Makefile Wed, 19 Jun 2002 14:11:35 +1000 kaos (linux-2.5/p/c/50_Makefile 1.4 444)
+++ 25.1(w)/net/core/Makefile Sat, 06 Jul 2002 18:27:16 +1000 kaos (linux-2.5/p/c/50_Makefile 1.4 444)
@@ -16,7 +16,7 @@ obj-$(CONFIG_FILTER) += filter.o
 
 obj-$(CONFIG_NET) += dev.o dev_mcast.o dst.o neighbour.o rtnetlink.o utils.o
 
-ifneq ($(CONFIG_LLC),n)
+ifneq ($(subst n,,$(CONFIG_LLC)),)
 obj-y += ext8022.o
 endif
 

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/



