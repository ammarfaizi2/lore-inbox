Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263229AbTDCBhe>; Wed, 2 Apr 2003 20:37:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263231AbTDCBhd>; Wed, 2 Apr 2003 20:37:33 -0500
Received: from bgl1mr1-a-fixed.sancharnet.in ([61.1.128.45]:4741 "EHLO
	bgl1mr1-a-fixed.sancharnet.in") by vger.kernel.org with ESMTP
	id <S263229AbTDCBhW>; Wed, 2 Apr 2003 20:37:22 -0500
Date: Wed, 02 Apr 2003 11:44:50 +0530
From: Bijoy Thomas <bijoys_2000@rediffmail.com>
Subject: Plz help!!
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Message-id: <000501c2f984$1c2b6340$78ec013d@bijoy>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
X-Priority: 3
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi guys!!!
 
        This is my first mail to ts list and i'm eagerly awaiting a
reply. I was goin thru the printk source and found out that pritk was
calling the write method of struct console 's present on a list
pointed to by console_drivers. So I thot of adding my own console
driver like this....
 
#define MODULE
#define __KERNEL__
#include<linux/module.h>
#include<linux/kernel.h>
#include<linux/console.h>
#include<linux/sched.h>
 
void my_write(struct console *co,const char *buf,unsigned count)
{
  struct tty_struct *my_tty;
  my_tty = current->tty;
  if(my_tty != NULL)
  {
    ((my_tty->driver).write)(my_tty,0,buf,strlen(buf));
  }
}
 
struct console my_console = {
name:"MYCON",
write:my_write,
flags:CON_ENABLED,
index:-1,
};
 
int init_module()
{
  register_console(&my_console);
  return 0;
}
 
void cleanup_module()
{
}
 
When I insmoded the module (in run level 3) it worked fine. While it
was still inserted i typed 'startx' and when i pressed 'Enter' ,the
machine instantly rebooted!!! I tried this again and it happened. With
MYCON registered ,if I issue the startx command ,the machine reboots.
Also if MYCON is registered and I shutdown using 'init 0' again the reboot 
happens.Can anyone explain??
 
bye
Bijoy Jacob Thomas


