Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316789AbSE1AQE>; Mon, 27 May 2002 20:16:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316790AbSE1AQD>; Mon, 27 May 2002 20:16:03 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:8201 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316789AbSE1AQD>;
	Mon, 27 May 2002 20:16:03 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH][RFC] PentiumPro/II split in x86 config 
In-Reply-To: Your message of "Mon, 27 May 2002 16:54:20 +0200."
             <20020527145420.GA6738@werewolf.able.es> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 28 May 2002 10:15:52 +1000
Message-ID: <2195.1022544952@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 May 2002 16:54:20 +0200, 
"J.A. Magallon" <jamagallon@able.es> wrote:
>Due to Alan's advice, it also adds a check that will panic if a PII or
>higher kernel is run on a PPro or lesser (plz, I put that code in the
>place I thought it was the best, but probably I'm wrong...).
>+static void __init check_intel_compat(struct cpuinfo_x86 *c)
>+{
>+#if defined(CONFIG_MPENTIUMII) || defined(CONFIG_MPENTIUMIII) || defined(CONFIG_MPENTIUM4)
>+	if (c->x86 <= 5)
>+		panic("Kernel is unsafe/incompatible with this CPU model. Check your build settings !\n");
>+#endif
>+}

Don't rely on that working.  When you compile with -march=i686, gcc
emits cmov instructions all over the place, including in printk code.
The first cmov takes a fault and tries to panic, the panic code uses
printk which hits a second cmov and the machine is dead with no
messages.

