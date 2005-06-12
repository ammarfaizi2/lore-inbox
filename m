Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbVFLQE4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbVFLQE4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Jun 2005 12:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262633AbVFLQE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Jun 2005 12:04:56 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:40972 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S262632AbVFLQEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Jun 2005 12:04:53 -0400
Date: Sun, 12 Jun 2005 18:04:50 +0200
From: Willy Tarreau <willy@w.ods.org>
To: DJ.CnX@phreaker.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: ld bug
Message-ID: <20050612160450.GB8907@alpha.home.local>
References: <20050612171050.529d5be8.DJ.CnX@phreaker.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050612171050.529d5be8.DJ.CnX@phreaker.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Sun, Jun 12, 2005 at 05:10:50PM +0200, DJ.CnX@phreaker.net wrote:
> 
> hello guys....
> 
> source:
> 
> section .text
> 
> global main
> 
> msg db "och bin",0x0
> msg_len equ $-msg
> 
> main:
>            pusha
>            mov eax,4
>            mov ebx,1
>            mov ecx,msg
>            mov edx,msg_len
>            int 0x80
> 
>            popa
>            xor eax,eax
>            inc eax
>            int 0x80
> 
> 
> compilation command:
> sh# nasm -f elf -o new.o new.asm
> sh# ld -e main -o new new.o
> sh# strace ./new
> execve("./new", ["./new"], [/* 78 vars */]) = 0
> --- SIGSEGV (Segmentation fault) @ 0 (0) ---
> +++ killed by SIGSEGV +++
> i compiled the whole shit with gcc and it worked... .-/

Although this is not the right list for this, it seems that the start
pointer in your program is 0, and since this page is not mapped, you
get a segfault. How to fix this I don't know, but this definitely is
not a kernel bug.

Willy

