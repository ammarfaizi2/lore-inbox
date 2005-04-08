Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262697AbVDHGHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262697AbVDHGHp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 02:07:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262698AbVDHGHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 02:07:45 -0400
Received: from lantana.tenet.res.in ([202.144.28.166]:23712 "EHLO
	lantana.cs.iitm.ernet.in") by vger.kernel.org with ESMTP
	id S262697AbVDHGG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 02:06:58 -0400
Date: Fri, 8 Apr 2005 11:37:17 +0530 (IST)
From: "P.Manohar" <pmanohar@lantana.cs.iitm.ernet.in>
To: linux-kernel@vger.kernel.org
Subject: scancodes to X-Windows
In-Reply-To: <000b01c51db7$9492da80$8e3c65cb@y3e5j4>
Message-ID: <Pine.LNX.4.60.0504081124520.6201@lantana.cs.iitm.ernet.in>
References: <000b01c51db7$9492da80$8e3c65cb@y3e5j4>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Mail-scanner Found to be clean
X-MailScanner-From: pmanohar@lantana.cs.iitm.ernet.in
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hai all,
The following is the code snippet from  drivers/char/keyboard.c

if ((raw_mode = (kbd->kbdmode == VC_RAW))) {
                 /*
                  *      The following is a workaround for hardware
                  *      which sometimes send the key release event twice
                  */
                 unsigned char next_scancode = scancode|up_flag;
                 if (up_flag && next_scancode==prev_scancode) {
                         /* unexpected 2nd release event */
                 } else {
                         prev_scancode=next_scancode;
                         put_queue(next_scancode);
                 }
                 /* we do not return yet, because we want to maintain
                    the key_down array, so that we have the correct
                    values when finishing RAW mode or when changing VT's */
         }

   I did so much googling, unable find 
My doubts are,

   1)Is in raw mode also the scancodes are send to tty buffer (as we are 
using put_queue() here.
   2) whether X will read from tty buffer are will it take scancodes 
directly ,in this case where it will store those scancodes,if X is busy doing
some other work.

In the put_queue function

#ifdef CONFIG_FORWARD_KEYBOARD
extern int forward_chars;

void put_queue(int ch)
{
         if (forward_chars == fg_console+1){
                 kbd_forward_char (ch);
         } else {
                 if (tty) {
                         tty_insert_flip_char(tty, ch, 0);
                         con_schedule_flip(tty);
                 }
         }
}

Where that kbd_forward_char is defined or what it will do.
what CONFIG_FORWARD_KEYBOARD signifies.
This is not present in my config file,(I am using RH linux 2.4.20)

I got confused of it , if you know about please mail me.

   Thanks&Regards,
   P.Manohar,


