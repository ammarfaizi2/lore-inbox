Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262625AbUCaVnC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262605AbUCaVl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:41:26 -0500
Received: from motgate5.mot.com ([144.189.100.105]:41454 "EHLO
	motgate5.mot.com") by vger.kernel.org with ESMTP id S262547AbUCaVjQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:39:16 -0500
Message-ID: <D5A7E45D575DD61180130002A5DB377C04E48C67@ca25exm01>
From: Stephens Tim-MGI1634 <Tim.Stephens@motorola.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Why does serial.c not allow you to share the serial console port 
	 interrupt?
Date: Wed, 31 Mar 2004 13:37:21 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.2)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm trying to understand why the serial.c driver does not allow the sharing of the serial console interrupt.  There are several places on the net the mention you cannot share the console interrupt, however there is no explaination why.  I assume it has something to do with OOPS reporting.  Please advise.

I'm trying to enable the second serial port on a MIPS based embedded system.  Both serial ports (16550 type) are attached to the same MIPS interrupt.  The console is attached to ttyS0, which shares the MIPS interrupt with ttyS1.

The code in question is:

#ifdef CONFIG_SERIAL_CONSOLE
    /*
     *    The interrupt of the serial console port
     *    can't be shared.
     */
    if (sercons.flags & CON_CONSDEV) {
        for(i = 0; i < NR_PORTS; i++)
            if (i != sercons.index &&
                rs_table[i].irq == rs_table[sercons.index].irq)
                rs_table[i].irq = 0;
    }
#endif

If I change the #ifdef to #if 0 both the console and ttyS1 seem to work ok.

Thanks,
Tim
