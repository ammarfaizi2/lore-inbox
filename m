Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262882AbTDVCkb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 22:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262883AbTDVCkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 22:40:31 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:60687 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S262882AbTDVCk3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 22:40:29 -0400
Message-ID: <3EA4AE54.80607@zytor.com>
Date: Mon, 21 Apr 2003 19:52:04 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
Organization: Zytor Communications
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en, sv
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
References: <UTC200304220102.h3M126n06187.aeb@smtp.cwi.nl> <b8262k$6t8$1@cesium.transmeta.com> <20030422020153.GA18141@mail.jlokier.co.uk>
In-Reply-To: <20030422020153.GA18141@mail.jlokier.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
>>
>>The main advantage with making it a struct is that it keep people from
>>doing stupid stuff like (int)dev where dev is a kdev_t...  There is
>>all kinds of shit like that in the kernel...
> 
> If you want that good quality 64-bit code, try making it a struct
> containing just a u64 :)
> 

Perhaps:

#if BITS_PER_LONG == 64
typedef struct { u64 val; } kdev_t;

/* Macros for major minor mkdev */
#else
typedef struct { u32 major, minor; } kdev_t;

/* Macros... */
#endif

	-hpa


