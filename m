Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262960AbTDBLF6>; Wed, 2 Apr 2003 06:05:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262962AbTDBLF6>; Wed, 2 Apr 2003 06:05:58 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:5640 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S262960AbTDBLF5>;
	Wed, 2 Apr 2003 06:05:57 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: genksyms crashes on drivers/char/joystick/pcigame.c 
In-reply-to: Your message of "Tue, 01 Apr 2003 17:19:18 +0200."
             <20030401151918.GJ1870@os.inf.tu-dresden.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 02 Apr 2003 21:17:11 +1000
Message-ID: <25740.1049282231@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Apr 2003 17:19:18 +0200, 
Adam Lackorzynski <adam@os.inf.tu-dresden.de> wrote:
>when genksyms is used on drivers/char/joystick/pcigame.c during "make
>dep" it segfaults.

genksyms assumes and requires valid C code as input.  genksyms does not
attempt to validate the source, that is the job of gcc.  If gcc barfs
on the code, then do not attempt to run it through genksyms.  This
looks like a chicken and egg problem but is not, compile with
MODVERSIONS=n to verify that new code is valid before building with
MODVERSIONS=y.  To put it another way, do not run modversions on test
kernels.

