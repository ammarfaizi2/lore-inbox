Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264186AbTH1PxU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:53:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264189AbTH1PxU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:53:20 -0400
Received: from dub.inr.ac.ru ([193.233.7.105]:53707 "HELO dub.inr.ac.ru")
	by vger.kernel.org with SMTP id S264186AbTH1PxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:53:18 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200308281553.TAA22047@dub.inr.ac.ru>
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
To: quade@hsnr.de (Juergen Quade)
Date: Thu, 28 Aug 2003 19:53:11 +0400 (MSD)
Cc: nagendra_tomar@adaptec.com, linux-kernel@vger.kernel.org,
       wa@almesberger.net
In-Reply-To: <20030828152934.GA7924@hsnr.de> from "Juergen Quade" at  =?ISO-8859-1?Q?=20=E1=D7=C7?= 28, 2003 05:29:34 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Here we have it! In my opintion, the line
> 
> 	clear_bit(TASKLET_STATE_SCHED, &t->state);
> 
> is just a _BUG_. 

No, really. The sense of tasklet_kill() is that tasklet is under complete
control of caller upon exit from it. This clear_bit just makes some (only
marginally useful) reinitialization for the case the user will want
to reuse the struct. Essentially, after tasklet_unlock_wait() you can do
everything with the struct, it is not an alive object anymore.


> 2. we should find some means to make it usable for recursive tasklets.

I would not say it is easy. When tasklet is enqueued on another cpu you
have no way to stop it unless you are in process context, where you can
sit and wait for completion.

Alexey
