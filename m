Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263009AbTH0Brs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 21:47:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263014AbTH0Brs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 21:47:48 -0400
Received: from dub.inr.ac.ru ([193.233.7.105]:51623 "HELO dub.inr.ac.ru")
	by vger.kernel.org with SMTP id S263009AbTH0Brr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 21:47:47 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200308270147.FAA07024@dub.inr.ac.ru>
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
To: wa@almesberger.net (Werner Almesberger)
Date: Wed, 27 Aug 2003 05:47:18 +0400 (MSD)
Cc: quade@hsnr.de, nagendra_tomar@adaptec.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030826145636.E1212@almesberger.net> from "Werner Almesberger" at  =?ISO-8859-1?Q?=20=E1?=
	=?ISO-8859-1?Q?=D7=C7?= 26, 2003 02:56:36 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Hmm, actually, no. On UP, yes. But on SMP, you might tasklet_kill
> while the tasklet is running, but before it has had a chance to
> tasklet_schedule itself. tasklet_schedule will have no effect in
> this case.
> 
> Alexey, if my observation is correct, the property
> 
> | * If tasklet_schedule() is called, then tasklet is guaranteed
> |   to be executed on some cpu at least once after this.
> 
> does not hold if using tasklet_kill on SMP.

It still holds. tasklet_kill just waits for completion of scheduled
events. Well, it _assumes_ that cpu which calls tasklet_schedule
does not try to wake the tasklet after death. But it is from area
of pure scholastics already: waker and killer have to synchronize in some
way anyway. 

Alexey
