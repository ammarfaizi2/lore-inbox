Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263970AbRFWOy1>; Sat, 23 Jun 2001 10:54:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263979AbRFWOyQ>; Sat, 23 Jun 2001 10:54:16 -0400
Received: from [62.47.35.223] ([62.47.35.223]:52466 "EHLO kanga.hofr.at")
	by vger.kernel.org with ESMTP id <S263970AbRFWOyH>;
	Sat, 23 Jun 2001 10:54:07 -0400
From: Der Herr Hofrat <der.herr@hofr.at>
Message-Id: <200106231454.f5NEsKu14812@kanga.hofr.at>
Subject: sizeof problem in kernel modules
To: linux-kernel@vger.kernel.org
Date: Sat, 23 Jun 2001 16:54:20 +0200 (CEST)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi !

 can someone explain to me whats happening here ?

--simple.c--
#include <linux/module.h>
#include <linux/kernel.h>

struct { short x; long y; short z; }bad_struct;
struct { long y; short x; short z; }good_struct;

int init_module(void){
	printk("good_struct %d, bad_struct %d\n",sizeof(good_struct),sizeof(bad_struct));
	return 0;
}

void cleanup_module(void){
	}

--Makefile--

all: simple.o

CC= gcc 
CFLAGS= -pipe -fno-strength-reduce -DCPU=686 -march=i686 \
	-Wall -Wstrict-prototypes -g -D__KERNEL__ -DMODULE \
	-D_LOOSE_KERNEL_NAMES -O2   -c 
INCLUDE= -I/usr/include/linux 

clean:
	rm -f simple.o

---------------------------------------------------------------

I would expect both structs to be 8byte in size , or atleast the same size !
but good_struct turns out to be 8bytes and bad_struct 12 .

what am I doing wrong here ?

thx !
hofrat
