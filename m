Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVFLTdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVFLTdv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 15:33:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbVFLTcQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 15:32:16 -0400
Received: from rly-ip03.mx.aol.com ([64.12.138.7]:63427 "EHLO
	rly-ip03.mx.aol.com") by vger.kernel.org with ESMTP id S261212AbVFLTXn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 15:23:43 -0400
Date: Sun, 12 Jun 2005 21:23:06 +0200
From: DJ.CnX@phreaker.net
To: linux-kernel@vger.kernel.org
Subject: execve-bug ...
Message-Id: <20050612212306.7383a6bd.DJ.CnX@phreaker.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-AOL-IP: 195.93.61.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux rrlf 2.6.5-7.151-default #1 Fri Mar 18 11:31:21 UTC 2005 i686 i686 i386 GNU/Linux

----------------- new.asm -------------------------
bits 32
section .text

global _start

msg db "och bin",0x0
msg_len equ $-msg 

_start:
           pusha
	   mov eax,4
	   mov ebx,1
	   mov ecx,msg
	   mov edx,msg_len
	   int 0x80
	   
	   popa
	   xor eax,eax
	   inc eax
	   int 0x80
---------------------------------------------------	   


shell# nasm -f elf -o new.o new.asm
shell# ld -o new new.o
shell# ./new
och binshell#







Linux rrlf 2.6.11 #2 Thu May 12 15:46:31 CEST 2005 i686 i686 i386 GNU/Linux

-------------- new.asm ----------------------------
bits 32
section .text

global _start

msg db "och bin",0x0
msg_len equ $-msg 

_start:
           pusha
	   mov eax,4
	   mov ebx,1
	   mov ecx,msg
	   mov edx,msg_len
	   int 0x80
	   
	   popa
	   xor eax,eax
	   inc eax
	   int 0x80
----------------------------------------------------

shell# nasm -f elf -o new.o new.asm 
shell# ld -o new new.o
shell# ./new
Segmentation Fault.



i even tried to execute the binary i've compiled on 2.6.5.x but it didnt
work : Segmentation Fault. So i think its a bug in the "execve"-function. 

