Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268188AbTALAbv>; Sat, 11 Jan 2003 19:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268189AbTALAbv>; Sat, 11 Jan 2003 19:31:51 -0500
Received: from smtpgw1.bnl.gov ([130.199.3.28]:28865 "EHLO smtpgw1.bnl.gov")
	by vger.kernel.org with ESMTP id <S268188AbTALAbu>;
	Sat, 11 Jan 2003 19:31:50 -0500
Message-ID: <28A2E0D6A920954ABBF13AF712CEBDB6CF0A81@exchange05.bnl.gov>
From: "Hall, Luca" <hall@bnl.gov>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: System Call Problem
Date: Sat, 11 Jan 2003 19:38:11 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain;
	charset="iso-8859-1"
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello I have a small problem with a new sys call: 

Slackware 8 , Kernel 2.2.19
tring to add a system call i did:

/usr/src/linux/kernel/luca.c

#include <linux/luca.h>
#include <linux/kernel.h>

asmlinkage int sys_luca(void){
        printk("my call in the kernel\n");
        return(555);

}

/usr/src/linux/include/linux/luca.h

#ifndef __LINUX_LUCA_H
#define __LINUX_LUCA_H

#include <linux/linkage.h>
#include <linux/unistd.h>

_syscall0(int,luca)

#endif

/usr/src/linux/include/asm-i386/unistd.h

added: #define __NR_luca               191

/usr/src/linux/arch/i386/kernel/entry.S

added: .long SYMBOL_NAME(sys_luca)
changed from 190: .rept NR_syscalls-191

compiled with make dep, make bzImage

The problem is now that when I boot i see the printk messages at the 
bottom. around 5 - 7 times.
When I log in I see the printk messages, and dmesg also. I checked many 
resources and cant seem too find what I'm doing wrong; why is my funct being
called at boot time and 
login ?

thanks alot
luca

