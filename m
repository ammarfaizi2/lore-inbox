Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262122AbSJEHvO>; Sat, 5 Oct 2002 03:51:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262127AbSJEHvO>; Sat, 5 Oct 2002 03:51:14 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:24078 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262122AbSJEHvN>; Sat, 5 Oct 2002 03:51:13 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Why does x86_64 support a SuSE-specific ioctl?
Date: 5 Oct 2002 00:56:31 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <anm5vf$m6p$1@cesium.transmeta.com>
References: <Pine.NEB.4.44.0210041654570.11119-100000@mimas.fachschaften.tu-muenchen.de.suse.lists.linux.kernel> <p73adltqz9g.fsf@oldwotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <p73adltqz9g.fsf@oldwotan.suse.de>
By author:    Andi Kleen <ak@suse.de>
In newsgroup: linux.dev.kernel
>
> Adrian Bunk <bunk@fs.tum.de> writes:
> > 
> > TIOCGDEV is (as the comment above indicates) in neither 2.4.20-pre9 nor in
> > 2.5.40 and I'm wondering why the x86_64 kernel supports a SuSE-specific
> > i386 ioctl?
> 
> Why not? 
> 
> I resubmitted the TIOCGDEV patch to Marcelo now, which implements it 
> for the console device.
> 

> -
> +		case TIOCGDEV:
> +			return put_user (kdev_t_to_nr (real_tty->device), (unsigned int*) arg);

This is broken -- you're returning a dev_t as an unsigned int.  On
i386 that means overwriting two bytes of userspace you shouldn't be,
and if dev_t > unsigned int in the future it has the opposite problem.
Note that this is different from TIOCGPTN which return a pts number,
not a dev_t.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
