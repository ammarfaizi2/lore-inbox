Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSFYRpi>; Tue, 25 Jun 2002 13:45:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315748AbSFYRph>; Tue, 25 Jun 2002 13:45:37 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:1665 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S315721AbSFYRph>;
	Tue, 25 Jun 2002 13:45:37 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200206251743.VAA00510@sex.inr.ac.ru>
Subject: Re: efficient copy_to_user and copy_from_user routines in Linux Kernel
To: akpm@zip.COM.AU (Andrew Morton)
Date: Tue, 25 Jun 2002 21:43:23 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3D18A26A.73E6DD07@zip.com.au> from "Andrew Morton" at Jun 25, 2 09:15:01 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> I changed tcp to use a different copy if either source or dest were
> not eight-byte aligned, and found that the resulting improvement
> across a mixed networking load was only 1%.  Your numbers are higher,
> so perhaps there are different alignments in the mix...

Did you look at sender or changed both of the functions?

After that accident TCP was changed and it does not use copy_from_user more,
it does copy_and_csum even when no checksum is required. So, his results
on sender side (except for strange anomaly at msg size 8K) just confirm
nil effect of copy_from_user.

What's about copy_to_user, we forgot about this at all,
worrying mostly about sender side. :-)

Alexey
