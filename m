Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289282AbSBDXk0>; Mon, 4 Feb 2002 18:40:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289288AbSBDXkQ>; Mon, 4 Feb 2002 18:40:16 -0500
Received: from mx2.elte.hu ([157.181.151.9]:51384 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289282AbSBDXkF>;
	Mon, 4 Feb 2002 18:40:05 -0500
Date: Tue, 5 Feb 2002 02:37:50 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <3C5F1B0A.DD38E4D0@kolumbus.fi>
Message-ID: <Pine.LNX.4.33.0202050235360.21544-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 5 Feb 2002, Jussi Laako wrote:

> > Please renice your CPU hog soundcard processes to -11, does that make any
> > difference? (under -K2)
>
> I can renice this only for testing purposes. Normally these are not
> run as root so I can't do negative renice.

but you can run the audio tasks as SCHED_FIFO?

(you do not have to run the tasks as root, you only have to do the renice
as root.)

> > is it more important to run these CPU hogs than to run interactive tasks?
> > If yes then renice them to -11.
>
> Yes and no... :) Interactive tasks get their work from CPU hogs so
> those are strongly related. If interactive task puts CPU hog to wait
> it will also lose it's data.

you can tune the actual weight of importance by decrasing the priority of
the CPU-hog (or increasing the priority of the interactive task) a bit.
But ideally you'd want to decrease the priority of the CPU hog, because
that way you protect it not only from your 'own' interactive tasks, but
from other activities on the system as well.

	Ingo

