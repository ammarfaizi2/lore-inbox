Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131869AbQK2Rlf>; Wed, 29 Nov 2000 12:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131872AbQK2RlZ>; Wed, 29 Nov 2000 12:41:25 -0500
Received: from 127-CORU-X7.libre.retevision.es ([62.83.54.127]:3844 "HELO
        mantianito.arroutada.es") by vger.kernel.org with SMTP
        id <S131869AbQK2RlH>; Wed, 29 Nov 2000 12:41:07 -0500
Date: Wed, 29 Nov 2000 17:24:15 +0100
From: Santiago Garcia Mantinan <manty@i.am>
To: linux-kernel@vger.kernel.org
Subject: why volatile on vgacon.c?
Message-ID: <20001129172415.A2171@mantianito.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I used to be able to run my 12 ethernet ports pentium based bridge without
vga card, but with tty1, tty2, ... still working, as the kernel used to
recognice a kind of a cga card on my machine even though there was none. But
the kernel could write to the memory were the card was supposed to be, and
so it worked.

That was on 2.2 series, but since I moved it to 2.4 series I don't have that
cga card found anymore. I have looked on the kernel code and followed it to
the __init function in vgacon.c, more concretely this piece of code...

        scr_writew(0xAA55, p);
        scr_writew(0x55AA, p + 1);
        if (scr_readw(p) != 0xAA55 || scr_readw(p + 1) != 0x55AA) {

Well, the thing is that this code and the code in this function is almost
the same in 2.4 as in 2.2, however reading returns the written values on 2.2
and different ones (0xffff) on 2.4

This is caused by the volatile declaration of *p on 2.4, so the questions
are:

was the old (I have found a CGA) behaviour considered a bug and is the
volatile declaration its fix?

If so, is there any way to have /dev/tty1 on a no graphic card i386 machine?
(besides unvolatilizating *p wich works for me)

Regards...
-- 
Manty/BestiaTester -> http://manty.net

PS: Please cc me, as I'm not on the list.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
