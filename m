Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319063AbSHFLK4>; Tue, 6 Aug 2002 07:10:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319066AbSHFLK4>; Tue, 6 Aug 2002 07:10:56 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:26247 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S319063AbSHFLKy>; Tue, 6 Aug 2002 07:10:54 -0400
Date: Tue, 6 Aug 2002 13:13:56 +0200
From: "Udo A. Steinberg" <us15@os.inf.tu-dresden.de>
To: Jeff Dike <jdike@karaya.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user mode
Message-Id: <20020806131356.61ece6ca.us15@os.inf.tu-dresden.de>
In-Reply-To: <200208061120.GAA01735@ccure.karaya.com>
References: <20020806101059.51ae728d.us15@os.inf.tu-dresden.de>
	<200208061120.GAA01735@ccure.karaya.com>
Organization: Disorganized
X-Mailer: Sylpheed version 0.7.8claws (GTK+ 1.2.10; )
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Aug 2002 06:20:52 -0500
Jeff Dike <jdike@karaya.com> wrote:

> us15@os.inf.tu-dresden.de said:
> >                         if (current->pgrp != -arg &&
> >                                 current->pid != arg &&
> >                                 !capable(CAP_KILL)) return(-EPERM); 
> 
> What's the problem here?  This will let UML do F_SETOWN as well.

It will let the incoming process take over ownership of the socket,
which is probably what you mean and what you currently use.

I'm talking about a setup with the kernel residing in its own process.
On iret it would have to change ownership of the socket to another task,
i.e. process with kernel_pid wants to set task_pid as the owner of the
socket. The above code fragment doesn't permit this, as far as I can see.
What it does permit is the incoming task setting itself to the socket
owner, but that requires that the incoming task always runs a trampoline
first which accomplishes that.

-Udo.
