Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262946AbTDVFuv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 01:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbTDVFuv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 01:50:51 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:269 "HELO
	vladimir.pegasys.ws") by vger.kernel.org with SMTP id S262946AbTDVFus
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 01:50:48 -0400
Date: Mon, 21 Apr 2003 23:00:13 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new system call mknod64
Message-ID: <20030422060013.GO16934@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <UTC200304220102.h3M126n06187.aeb@smtp.cwi.nl> <b8262k$6t8$1@cesium.transmeta.com> <20030422020153.GA18141@mail.jlokier.co.uk> <3EA4AE54.80607@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EA4AE54.80607@zytor.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 07:52:04PM -0700, H. Peter Anvin wrote:
> Jamie Lokier wrote:
> >>
> >>The main advantage with making it a struct is that it keep people from
> >>doing stupid stuff like (int)dev where dev is a kdev_t...  There is
> >>all kinds of shit like that in the kernel...
> > 
> > If you want that good quality 64-bit code, try making it a struct
> > containing just a u64 :)
> > 
> 
> Perhaps:
> 
> #if BITS_PER_LONG == 64
> typedef struct { u64 val; } kdev_t;
> 
> /* Macros for major minor mkdev */
> #else
> typedef struct { u32 major, minor; } kdev_t;
> 
> /* Macros... */
> #endif
> 

or a union?
typedef union { u64 dev; struct { u32 major, minor; } d; } kdev_t;

<duck>

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
