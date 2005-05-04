Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbVEDVAv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbVEDVAv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 17:00:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVEDUxx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 16:53:53 -0400
Received: from wproxy.gmail.com ([64.233.184.201]:11960 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261546AbVEDUvT convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 16:51:19 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Iz40WYHTVL8U+nP3yPslJb85P9gMAjVbkbfxtLuPJSNdrbyg9eQzwXHmOv6v8tF0SzoQ4tI4n8YEenVVwGgvbdya+ne4L+W9d0/0xuvYqpVhh0X0PHcp1iUtLz/ZtXZqLHMTVuX3z7qcrA5T5MEUDDs39xUXxK7uk3khHCRXqXM=
Message-ID: <81b0412b05050413514544d29c@mail.gmail.com>
Date: Wed, 4 May 2005 22:51:16 +0200
From: Alex Riesen <raa.lkml@gmail.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
To: Deepak <deepakgaur@fastmail.fm>
Subject: Re: Hanged/Hunged process in Linux
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1115185128.12535.233322099@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1115185128.12535.233322099@webmail.messagingengine.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/4/05, Deepak <deepakgaur@fastmail.fm> wrote:
> (1) A process not accepting any signals and consuming system resources

wrong. It may have decided to go through a critical section of its job, and
the job takes a long time.

> (2) A process in STOP state

wrong. The prosess is being debugged or is stopped (killall -STOP bash).
Besides, often the RUNNING state is more suspicious.

> (3) A process in deadlock state

how can you detect this from outside of the process(es)?!

> Process conforming to definition 3 will be due to race conditions/bad
> programming.Definition 1 does define a proper hanged process but is it
> possible to create such a process in LInux as in linux signal delivery
> to the process and its handling is assured by the Linux kernel.

Anything, except for SIGKILL and SIGSTOP can be overridden.
And it doesn't help you anyway in detecting of runaway processes.

> Anybody having another definition for a "Hanged process" in Linux
> context

Except for the case described by Valdis Klietnieks, it's hard to define.
How do you distinguish between a very busy process and the deadly
locked in itself one?
You'll probably end up defining some arbitrary timeouts for the
processes under your control, some watchdog interface for the
processes and plain old kill(..., SIGCONT); kill(..., SIGKILL); restart();
