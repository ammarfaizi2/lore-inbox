Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267482AbTAVNWO>; Wed, 22 Jan 2003 08:22:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267484AbTAVNWN>; Wed, 22 Jan 2003 08:22:13 -0500
Received: from pluvier.ens-lyon.fr ([140.77.167.5]:57514 "EHLO
	mailhost.ens-lyon.fr") by vger.kernel.org with ESMTP
	id <S267482AbTAVNWL>; Wed, 22 Jan 2003 08:22:11 -0500
Date: Wed, 22 Jan 2003 14:31:07 +0100
From: Brice Goglin <bgoglin@ens-lyon.fr>
To: linux-kernel@vger.kernel.org
Cc: davem@redhat.com, kuznet@ms2.inr.ac.ru
Subject: AH transformation broken since 2.5.56
Message-ID: <20030122133107.GD13948@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Support for IPsec AH in net/ipv4/ah.c is broken since 2.5.56
(still broken in 2.5.59).
I tried with CONFIG_INET_AH=y and m, I got the same error :

make -f scripts/Makefile.build obj=net/ipv4
  gcc -Wp,-MD,net/ipv4/.ah.o.d -D__KERNEL__ -Iinclude -Wall -Wstrict-prototypes 
-Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe 
-mpreferred-stack-boundary=2 -march=i686 -Iinclude/asm-i386/mach-default 
-fomit-frame-pointer -nostdinc -iwithprefix include -DMODULE   
-DKBUILD_BASENAME=ah -DKBUILD_MODNAME=ah   -c -o net/ipv4/ah.o net/ipv4/ah.c
net/ipv4/ah.c: In function `ah_hmac_digest':
net/ipv4/ah.c:154: warning: implicit declaration of function `crypto_hmac_init'
net/ipv4/ah.c:155: `crypto_hmac_update' undeclared (first use in this function)
net/ipv4/ah.c:155: (Each undeclared identifier is reported only once
net/ipv4/ah.c:155: for each function it appears in.)
net/ipv4/ah.c:156: warning: implicit declaration of function `crypto_hmac_final'
make[2]: *** [net/ipv4/ah.o] Erreur 1
make[1]: *** [net/ipv4] Erreur 2
make: *** [net] Erreur 2

Regards

Brice Goglin
============
Ph.D Student
Laboratoire de l'Informatique et du Parallélisme
ENS Lyon
France
