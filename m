Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317188AbSF1MDR>; Fri, 28 Jun 2002 08:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317187AbSF1MDQ>; Fri, 28 Jun 2002 08:03:16 -0400
Received: from mail.goquest.com ([63.172.73.8]:62382 "HELO mail.goquest.com")
	by vger.kernel.org with SMTP id <S317185AbSF1MDQ>;
	Fri, 28 Jun 2002 08:03:16 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Michael S. Zick" <mszick@goquest.com>
To: anton wilson <anton.wilson@camotion.com>, linux-kernel@vger.kernel.org
Subject: Re: printks in the scheduler freeze during scripts
Date: Fri, 28 Jun 2002 06:56:15 -0500
X-Mailer: KMail [version 1.2]
References: <200206271349.JAA16318@test-area.com>
In-Reply-To: <200206271349.JAA16318@test-area.com>
MIME-Version: 1.0
Message-Id: <02062806561501.00733@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 June 2002 09:03 am, anton wilson wrote:
> I'm running linux 2.4.17 and Redhat 7.2 with the preemptive and low latency
> patches, and whenever I stick printks in the scheduler(void) my system
> freezes somewhere after it tries to load the system font. Where it stops
> seems to be random. I can only run under single user mode without my system
> freezing. Does anyone have any clues why? Or any better ways to go about
> tracking the scheduling of processes in the scheduler?

Something I have used in my testing:

Add, in the task structure:

task_t  *sched_from;

In schedule, prior to context_switch:

next->sched_from = prior; /* at this point still == get_current ()*/

Somewhere else (so you don't inadvertantly side-effect to death schedule()):

Follow the back-link and printk whatever for the task that you are interested 
in, being careful not to reference task structures that no longer exist.

Mike
>
>
> Anton
