Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263320AbTKJM2F (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 07:28:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263352AbTKJM2F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 07:28:05 -0500
Received: from web20605.mail.yahoo.com ([216.136.226.163]:18447 "HELO
	web20605.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263320AbTKJM2C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 07:28:02 -0500
Message-ID: <20031110122801.16452.qmail@web20605.mail.yahoo.com>
Date: Mon, 10 Nov 2003 04:28:01 -0800 (PST)
From: Stefan Talpalaru <stefantalpalaru@yahoo.com>
Subject: Re: PATCH: CMD640 IDE chipset
To: Alexander Atanasov <alex@ssi.bg>
Cc: linux-kernel@vger.kernel.org,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
In-Reply-To: <20031029144845.14d57ba6.alex@ssi.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Alexander!

> 	Hello,
> On Wed, 29 Oct 2003 04:12:18 -0800 (PST)
> Stefan Talpalaru <stefantalpalaru@yahoo.com> wrote:
> > and also some useless code (the wrapers: __put_cmd640_reg() and 
> > __get_cmd640_reg() - which I removed and placed the locks where
> > needed; the pci_conf1() and pci_conf2() functions).
> 	These wrappers were added to correct the locking in
> driver. There are places that you must access serveral registers

 where?

> holding the lock and that's why the wrappers came, so they
> are not useless. The locking in your patch is wrong -

  They are ugly.

> the problem is that you call get_cmd640_reg or put_cmd640_reg, which
> try to take ide_lock, while already holding it and it's a deadlock 

  I find it hard to believe (I'm running a patched kernel right now!),
but
 i'm only a newbie at kernel hacking, so please show me the light (not
joking).
  Thanks in advance.

> - thats what the wrappers solved. So, please , drop that change.
>        setup_count |= __get_cmd640_reg(arttim_regs[index]) & 0x3f;
> -       __put_cmd640_reg(arttim_regs[index], setup_count);
> -       __put_cmd640_reg(drwtim_regs[index],
pack_nibbles(active_count, recovery
> _count));
> +       setup_count |= get_cmd640_reg(arttim_regs[index]) & 0x3f;
> +       put_cmd640_reg(arttim_regs[index], setup_count);
> +       put_cmd640_reg(drwtim_regs[index], pack_nibbles(active_count,
recovery_c
> ount));
>         spin_unlock_irqrestore(&ide_lock, flags);
>  }
> 	here
> -       __put_cmd640_reg(reg, b);
> +       put_cmd640_reg(reg, b);
>         spin_unlock_irqrestore(&ide_lock, flags);
> 	and here for example.
> --
> have fun,
> alex

later,


=====
Stefan Talpalaru

__________________________________
Do you Yahoo!?
Protect your identity with Yahoo! Mail AddressGuard
http://antispam.yahoo.com/whatsnewfree
