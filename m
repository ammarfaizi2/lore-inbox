Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129226AbQLKQQn>; Mon, 11 Dec 2000 11:16:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129183AbQLKQQd>; Mon, 11 Dec 2000 11:16:33 -0500
Received: from anchor-post-34.mail.demon.net ([194.217.242.92]:275 "EHLO
	anchor-post-34.mail.demon.net") by vger.kernel.org with ESMTP
	id <S129319AbQLKQQO>; Mon, 11 Dec 2000 11:16:14 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Nick.Holloway@pyrites.org.uk (Nick Holloway)
Newsgroups: list.linux-kernel
Subject: Re: kapm-idled : is this a bug?
Date: 11 Dec 2000 15:45:36 -0000
Organization: Alfie's Internet Node
Message-ID: <912sr0$5va$1@alfie.demon.co.uk>
In-Reply-To: <Pine.LNX.4.10.10012111151470.2070-100000@localhost> <Pine.LNX.4.21.0012111315350.4808-100000@duckman.distro.conectiva>
X-Newsreader: NN version 6.5.0 CURRENT #119
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

riel@conectiva.com.br (Rik van Riel) writes:
> On Mon, 11 Dec 2000 stewart@neuron.com wrote:
> 	[snip whine]
> 
> >  I've consistently re-produced this on my Dell Latitude CS laptop. I'm
> >  wondering if this will reduce battery life since the CPU is constantly
> >  being loaded instead of properly idled.
> 
> What do you suppose the 'idled' in 'kapm-idled' stands for?

We know it was an attempt to stop people complaining about the fact that
"kapm" was hogging the CPU.  Looks like it doesn't work.

At the time, I had a look at the kernel source, and came to the conclusion
that there was no easy way for the cpu accounting in "do_process_times()"
to automatically assign ticks from a particular process to the idle
process.

However, would it be possible for apm_cpu_idle() to periodically assign
the values for per_cpu_*time for the kernel thread to the idle process?
This isn't a performance critical part of the kernel, and would lead to
less false reports (as above).

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
