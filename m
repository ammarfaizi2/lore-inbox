Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267366AbTAOWdY>; Wed, 15 Jan 2003 17:33:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbTAOWdY>; Wed, 15 Jan 2003 17:33:24 -0500
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:16028 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S267366AbTAOWdX>; Wed, 15 Jan 2003 17:33:23 -0500
Date: Wed, 15 Jan 2003 16:42:00 -0600 (CST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: davidm@hpl.hp.com
cc: Sam Ravnborg <sam@ravnborg.org>,
       Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
       <ebiederm@xmission.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC] Consolidate vmlinux.lds.S files
In-Reply-To: <15907.5503.334066.50256@napali.hpl.hp.com>
Message-ID: <Pine.LNX.4.44.0301151638240.24883-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Jan 2003, David Mosberger wrote:

> 
>   Kai> I would suggest an approach like the following, of course
>   Kai> showing only a first simple step. A series of steps like this
>   Kai> should allow for a serious reduction in size of
>   Kai> arch/*/vmlinux.lds.S already, while being obviously correct and
>   Kai> allowing archs to do their own special thing if necessary (in
>   Kai> particular, IA64 seems to differ from all the other archs).
> 
> The only real difference for the ia64 vmlinux.lds.S is that it
> generates correct physical addressess, so that the boot loader doesn't
> have to know anything about the virtual layout of the kernel.
> Something that might be useful for other arches as well...

I just found another way of changing the LMA in vmlinux, which is far 
less intrusive than what IA-64 uses. Do you see any reason why something 
like the following patch (which changes the LMA for i386) wouldn't work 
for IA-64?

--Kai


===== arch/i386/vmlinux.lds.S 1.24 vs edited =====
--- 1.24/arch/i386/vmlinux.lds.S	Wed Jan 15 11:48:42 2003
+++ edited/arch/i386/vmlinux.lds.S	Wed Jan 15 16:36:04 2003
@@ -7,6 +7,7 @@
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
 OUTPUT_ARCH(i386)
 ENTRY(_start)
+PHDRS { kernel PT_LOAD AT(0x100000) ; }
 jiffies = jiffies_64;
 SECTIONS
 {
@@ -17,7 +18,7 @@
 	*(.text)
 	*(.fixup)
 	*(.gnu.warning)
-	} = 0x9090
+	} :kernel = 0x9090
 
   _etext = .;			/* End of text section */
 

