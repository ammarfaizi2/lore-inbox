Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280817AbRKTNDs>; Tue, 20 Nov 2001 08:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281059AbRKTNDi>; Tue, 20 Nov 2001 08:03:38 -0500
Received: from natpost.webmailer.de ([192.67.198.65]:40683 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S280817AbRKTNDX>; Tue, 20 Nov 2001 08:03:23 -0500
Message-Id: <200111201303.OAA17296@post.webmailer.de>
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: linux-kernel@vger.kernel.org
Subject: 2.4.15-pre6 compile errors
Date: Tue, 20 Nov 2001 14:01:26 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have tried to compile a few useless configurations (on i686, gcc-2.96) of 
the latest kernel and so far found three cases where a valid configuration 
fails to compile:

CONFIG_PPP_DEFLATE && (CONFIG_CRAMFS || CONFIG_ZISOFS):
Symbol clashes from two zlib copies (again...). I suppose the symbols in 
drivers/net/zlib.c could all be made static unless a merge of both zlib 
copies is already planned.

!CONFIG_INET:
Some files in net/core/ are compiled unconditionally, but depend on TCP/IP 
(CONFIG_INET).  The problem is that TCP_ENC_send in include/net/tcp_ecn.h
accesses the disabled 'af_inet' part of struct sock. A simple #ifdef at the 
right place should solve this.

CONFIG_MULTIQUAD && CONFIG_DEBUG_IOVIRT:
arch/i386/boot/compressed/misc.o can't resolve __io_virt_debug (from outb_p) 
when linking bzImage. This configuration is really useless and fixing this 
would be rather ugly, so I suggest explicitly forbidding it to help the next 
fool to try 'yes | make config'.

Arnd <><
