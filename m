Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSFFAxw>; Wed, 5 Jun 2002 20:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSFFAxv>; Wed, 5 Jun 2002 20:53:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:40445 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S316580AbSFFAxv>; Wed, 5 Jun 2002 20:53:51 -0400
Subject: Re: [PATCH] scheduler hints
From: Robert Love <rml@tech9.net>
To: Rick Bressler <rickb@mushroom.ca.boeing.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200206060046.g560kJi04034@mushroom.ca.boeing.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Jun 2002 17:53:36 -0700
Message-Id: <1023324831.912.376.camel@sinai>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-06-05 at 17:46, Rick Bressler wrote:

> Sequent had an interesting hint they cooked up with Oracle. (Or maybe it
> was the other way around.)  As I recall they called it 'twotask.'
> Essentially Oracle clients processes spend a lot of time exchanging
> information with its server process. It usually makes sense to bind them
> to the same CPU in an SMP (and especially NUMA) machine.  (Probably
> obvious to most of the folks on the group, but it is generally lots
> better to essentially communicate through the cache and local memory
> than across the NUMA bus.)

This is similar in theory to why we used to have the sync option on
wake_up for pipes... it does work.

We don't need a scheduler "hint" for this, though.  A big loud command
"bind me to this processor!" would do fine, and in 2.5 we have that:

just have one of the tasks do:

	sched_setaffinity(0, sizeof(unsigned long), 1);
	sched_setaffinity(other_guys_pid, sizeof(unsigned long), 1);

and both will be affined to CPU 1.

	Robert Love

