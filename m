Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282101AbRK1Jch>; Wed, 28 Nov 2001 04:32:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282100AbRK1Jc1>; Wed, 28 Nov 2001 04:32:27 -0500
Received: from [195.66.192.167] ([195.66.192.167]:8719 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S282093AbRK1JcQ>; Wed, 28 Nov 2001 04:32:16 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Andreas Dilger <adilger@turbolabs.com>
Subject: Re: [BUG] Bad #define, nonportable C, missing {}
Date: Wed, 28 Nov 2001 11:19:32 -0200
X-Mailer: KMail [version 1.2]
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Mathijs Mohlmann <mathijs@knoware.nl>,
        Jan Hudec <bulb@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <E168SMG-0006k2-00@the-village.bc.nu> <01112716035401.00872@manta> <20011127113830.E730@lynx.no>
In-Reply-To: <20011127113830.E730@lynx.no>
MIME-Version: 1.0
Message-Id: <01112811193201.00924@manta>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 November 2001 16:38, Andreas Dilger wrote:
> On Nov 27, 2001  16:03 -0200, vda wrote:
> > On Monday 26 November 2001 18:28, Alan Cox wrote:
> > > Nothing to do with me 8). I didnt write that bit of the i2o code. I
> > > agree its both confusing and buggy. Send a fix ?
> >
> > This is a test to be sure my replacement is equivalent:
> > --------------------
> > #include <stdio.h>
> > #define MODINC(x,y) (x = x++ % y)
> > #define MODULO_INC(x,y) ((x) = ((x)%(y))+1)
>
> Ugh, clearly the code is broken, so we don't want equivalent code, but
> correct code.  Use the unambiguous "MODINC(x,y) ((x) = ((x) + 1) % (y))"
> form and not "have a bug that has properly defined behaviour under ANSI C".
>
> Just looking at the code, it is fairly clear that the desire is to keep
> q_in and q_out >= 0 and < I20_EVT_Q_LEN, which is the size of the event_q
> array.  With the buggy version, it is possible that you could have q_in or
> q_out == I2O_EVT_Q_LEN, which is overflowing the array.  Bad, bad, bad.

You probably right. I know nothing about what it is intended to do, I just
replaced ugly named nonportable macro with the better named portable one
which is doing the same thing.

If you are confident old macro was also buggy (it yields 1,2,3...N,1,2,3... 
and should 0,1,2,...N-1,0,1,2...) please feel free to post corrected patch.
(I suggest changing macro name too as I did)
--
vda

> --- i2o_config.c.new	Mon Oct 22 13:39:56 2001
> +++ i2o_config.c.orig	Tue Nov 27 16:03:19 2001
> @@ -45,7 +45,7 @@
>  static spinlock_t i2o_config_lock = SPIN_LOCK_UNLOCKED;
>  struct wait_queue *i2o_wait_queue;
>
> -#define MODINC(x,y) (x = x++ % y)
> +#define MODINC(x,y) ((x) = ((x) + 1) % (y))
>
>  struct i2o_cfg_info
>  {
