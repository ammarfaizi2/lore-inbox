Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272838AbRJJB2U>; Tue, 9 Oct 2001 21:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272773AbRJJB2K>; Tue, 9 Oct 2001 21:28:10 -0400
Received: from rj.sgi.com ([204.94.215.100]:47794 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S272838AbRJJB2F>;
	Tue, 9 Oct 2001 21:28:05 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        VDA <VDA@port.imtp.ilyichevsk.odessa.ua>, linux-kernel@vger.kernel.org
Subject: Re: kernel size 
In-Reply-To: Your message of "Tue, 09 Oct 2001 16:43:48 +0200."
             <20011009164348.I30515@nightmaster.csn.tu-chemnitz.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 10 Oct 2001 11:27:49 +1000
Message-ID: <7542.1002677269@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Oct 2001 16:43:48 +0200, 
Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de> wrote:
>strip -R .ident -R .comment -R .note
>
>is your friend. 
>
>Or if we would like to solve it more elegant:
>
>--- linux-2.4.10/arch/i386/vmlinux.lds       Tue Oct  9 16:36:06 2001
>+++ linux/arch/i386/vmlinux.lds   Tue Oct  9 16:36:28 2001
>@@ -70,6 +70,9 @@
>        *(.text.exit)
>        *(.data.exit)
>        *(.exitcall.exit)
>+       *(.ident)
>+       *(.comment)
>+       *(.note)
>        }
>
>   /* Stabs debugging sections.  */
>
>
>which puts it into the list of sections to be discarde on i386.

Already done.  When vmlinux is converted to [b]Zimage kbuild runs
  objcopy -O binary -R .note -R .comment -S
The comments are stripped out at that stage.  Before you start fiddling
with vmlinux.lds, try this:

  objcopy -O binary -R .note -R .comment -S vmlinux vmlinux.stripped

Look at vmlinux.stripped, it is what actually gets loaded.  If there
are any offending strings from gcc then we can look at them but I
really doubt that there are any.

