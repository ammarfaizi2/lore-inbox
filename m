Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265196AbTAUAfm>; Mon, 20 Jan 2003 19:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266917AbTAUAfm>; Mon, 20 Jan 2003 19:35:42 -0500
Received: from web80309.mail.yahoo.com ([66.218.79.25]:35600 "HELO
	web80309.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S265196AbTAUAfl>; Mon, 20 Jan 2003 19:35:41 -0500
Message-ID: <20030121004441.39150.qmail@web80309.mail.yahoo.com>
Date: Mon, 20 Jan 2003 16:44:41 -0800 (PST)
From: Kevin Lawton <kevinlawton2001@yahoo.com>
Subject: EDD bug find: wrong #define is used to declare edd[] area.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It appears to me that the wrong #define is being used to declare the
size of the EDD (BIOS Enhanced Disk Drive Services) area of the setup
parameter page.  The following lines use 'EDDNR', but I believe they
meant to use 'EDDMAXNR':  (src @ 2.5.59)

  include/asm-i386/edd.h:line 168:

    extern struct edd_info edd[EDDNR];

  arch/i386/kernel/setup.c:line 477:

    struct edd_info edd[EDDNR];


For reference:

  include/asm-i386/edd.h:
  #define EDDNR 0x1e9           /* addr of number of edd_info structs at EDDBUF
  #define EDDMAXNR 6            /* number of edd_info structs starting at
EDDBUF  */

EDDNR is the offset in the parameter page, not the number of entries.
EDDMAXNR seems to be the literal to use.  I haven't tried this fix,
because I don't use it.  Just noticed it while digging through the source.

-Kevin Lawton

__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com
