Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289255AbSBDXBv>; Mon, 4 Feb 2002 18:01:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289260AbSBDXBb>; Mon, 4 Feb 2002 18:01:31 -0500
Received: from mx2.elte.hu ([157.181.151.9]:18100 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289255AbSBDXB0>;
	Mon, 4 Feb 2002 18:01:26 -0500
Date: Tue, 5 Feb 2002 01:59:12 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: Ed Tomlinson <tomlins@cam.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] improving O(1)-J9 in heavily threaded situations
In-Reply-To: <3C5EE691.1E7C2ADF@kolumbus.fi>
Message-ID: <Pine.LNX.4.33.0202050157170.19749-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 4 Feb 2002, Jussi Laako wrote:

> My application uses three tier architecture where is low HAL layer
> reading audio from soundcard which is compressed and sent (TCP) to
> distributor process which decompresses the audio and distributes
> (UNIX/LOCAL) it to clients. Distributor's clients are the CPU hogs
> doing various processing tasks to the signal and then sending (TCP)
> the results to the very thin user interface.

Please renice your CPU hog soundcard processes to -11, does that make any
difference? (under -K2)

> HAL and distributor are running as SCHED_FIFO, but CPU hog processing
> tasks are dynamically fork()/exec()'d and run on default priority (not
> as root). So I should nice user interfaces to 15+?

is it more important to run these CPU hogs than to run interactive tasks?
If yes then renice them to -11.

	Ingo

