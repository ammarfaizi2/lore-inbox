Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286194AbRLZMV4>; Wed, 26 Dec 2001 07:21:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286196AbRLZMVp>; Wed, 26 Dec 2001 07:21:45 -0500
Received: from colorfullife.com ([216.156.138.34]:6405 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S280938AbRLZMVl>;
	Wed, 26 Dec 2001 07:21:41 -0500
Message-ID: <000901c18e07$e2877d10$010411ac@local>
From: "Manfred Spraul" <manfred@colorfullife.com>
To: <alad@hss.hns.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Weird __put_user_asm behavior
Date: Wed, 26 Dec 2001 13:21:39 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4807.1700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The old code evaluates addr once, your new code evaluates it twice.
Have you tried an inline function instead of a macro?
linux/fs/binfmt_elf.c contains a few lines that probably break if 'addr' is evaluated twice:
<<<<<<<
        argv = (elf_caddr_t *) sp;
        if (!ibcs) {
                __put_user((elf_addr_t)(unsigned long) envp,--sp);
                __put_user((elf_addr_t)(unsigned long) argv,--sp);
        }
<<<<<<<<<

--
    Manfred

