Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbTIVWyZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 18:54:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbTIVWyZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 18:54:25 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:4362 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S261645AbTIVWyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 18:54:23 -0400
Message-Id: <200309222253.PAA21087@cesium.transmeta.com>
To: linux-kernel@vger.kernel.org, cfriesen@nortelnetworks.com
From: "H. Peter Anvin" <hpa@zytor.com>
Newsgroups: linux.dev.kernel
Subject: Re: compiler warnings and syscall macros
References: <3F6F6B1B.9040609@nortelnetworks.com>
Organization: Transmeta Corporation, Santa Clara CA
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Comment-To: Chris Friesen <cfriesen@nortelnetworks.com>
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Date: Mon, 22 Sep 2003 15:49:33 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3F6F6B1B.9040609@nortelnetworks.com>
By author:    Chris Friesen <cfriesen@nortelnetworks.com>
In newsgroup: linux.dev.kernel
>
> 
> I'm trying to figure something out.  For ppc, in asm/unistd.h, 
> __syscall_nr is defined as:
> 
> 
> #define __syscall_nr(nr, type, name, args...)	\
> 	unsigned long __sc_ret, __sc_err;	\
> 	{					\
> <snipped for brevity>
> 	}					\
> 	if (__sc_err & 0x10000000)		\
> 	{					\
> 		errno = __sc_ret;		\
> 		__sc_ret = -1;			\
> 	}					\
> 	return (type) __sc_ret
> 
> 
> Whenever I use this in my code, I get compiler warnings about the 
> statment "__sc_ret = -1" since it is assigning a negative value to an 
> unsigned int.

Just do:

__sc_ret = -1UL;

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
If you send me mail in HTML format I will assume it's spam.
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
