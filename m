Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262238AbRETVf1>; Sun, 20 May 2001 17:35:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262243AbRETVfR>; Sun, 20 May 2001 17:35:17 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:51898 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S262238AbRETVe7>;
	Sun, 20 May 2001 17:34:59 -0400
Message-ID: <3B083878.1785C27D@mandrakesoft.com>
Date: Sun, 20 May 2001 17:34:48 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: const __init
In-Reply-To: <Pine.LNX.4.05.10105202210370.1667-100000@callisto.of.borg>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Geert Uytterhoeven wrote:
> 
> On Sun, 20 May 2001, Jeff Garzik wrote:
> > Geert Uytterhoeven wrote:
> > > Since a while include/linux/init.h contains the line
> > >
> > >     * Also note, that this data cannot be "const".
> > >
> > > Why is this? Because const data will be put in a different section?
> >
> > Causes a "section type conflict" build error, at least on x86.
> 
> On m68k I only saw section type conflict errors when using __init while it
> should have been __initdata.

This might be a very valid point...

(let me know if the following test is flawed)

> [jgarzik@rum tmp]$ cat > sectest.c
> #include <linux/module.h>
> #include <linux/init.h>
> static const char version[] __initdata = "foo";
> [jgarzik@rum tmp]$ gcc -D__KERNEL__ -I/spare/cvs/linux_2_4/include -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer -fno-strict-aliasing -pipe -mpreferred-stack-boundary=2 -march=i686    -c -o sectest.o sectest.c
> [jgarzik@rum tmp]$ 

No section type conflict appears.

-- 
Jeff Garzik      | "Do you have to make light of everything?!"
Building 1024    | "I'm extremely serious about nailing your
MandrakeSoft     |  step-daughter, but other than that, yes."
