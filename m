Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261907AbUDHQU6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 12:20:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261952AbUDHQU6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 12:20:58 -0400
Received: from ftpbox.mot.com ([129.188.136.101]:10159 "EHLO ftpbox.mot.com")
	by vger.kernel.org with ESMTP id S261907AbUDHQUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 12:20:55 -0400
Message-ID: <D5A7E45D575DD61180130002A5DB377C04E48C75@ca25exm01>
From: Stephens Tim-MGI1634 <Tim.Stephens@motorola.com>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Why does serial.c not allow you to share the serial console port 
	 interrupt?
Date: Thu, 8 Apr 2004 09:19:57 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.2)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-post, no response from earlier posting.

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
