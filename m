Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131292AbRCWRN3>; Fri, 23 Mar 2001 12:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131293AbRCWRNT>; Fri, 23 Mar 2001 12:13:19 -0500
Received: from pincoya.inf.utfsm.cl ([200.1.19.3]:14853 "EHLO
	pincoya.inf.utfsm.cl") by vger.kernel.org with ESMTP
	id <S131292AbRCWRNL>; Fri, 23 Mar 2001 12:13:11 -0500
Message-Id: <200103231712.f2NHC3xY001829@pincoya.inf.utfsm.cl>
To: "J . A . Magallon" <jamagallon@able.es>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gcc-3.0 warnings 
In-Reply-To: Message from "J . A . Magallon" <jamagallon@able.es> 
   of "Fri, 23 Mar 2001 01:11:41 +0100." <20010323011140.A1176@werewolf.able.es> 
Date: Fri, 23 Mar 2001 13:12:03 -0400
From: Horst von Brand <vonbrand@inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"J . A . Magallon" <jamagallon@able.es> said:
> I have been building (and hopefully booting) ac-21 with gcc-3.0 snapshot
> dated 20010312. I have cleared the 99% of the warnings that 3.0 issues
> when building the kernel. Obviuosly, only in the main kernel part for
> i386 and the drivers I use. I suppose other arch will require a similar
> cleanup.
> 
> All are related to multiline strings in asm() sentences, that seem to have
> been deprecated, and out: or default: labels at the end of blocks. Pathc
> is inlined.

The problem with labels at the end of blocks, like so:

   {
      ....
      goto out;
      ....
   out:
   }

is that this is not legal C: The label should be part of a sentence, and
there is none. Just write (note the ';' after the label):

   {
      ....
      goto out;
      ....
   out: ;
   }

(Yes, this is ugly).
-- 
Dr. Horst H. von Brand                       mailto:vonbrand@inf.utfsm.cl
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513
