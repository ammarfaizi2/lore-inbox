Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131341AbRAaLlc>; Wed, 31 Jan 2001 06:41:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131461AbRAaLlW>; Wed, 31 Jan 2001 06:41:22 -0500
Received: from [194.213.32.137] ([194.213.32.137]:3588 "EHLO bug.ucw.cz")
	by vger.kernel.org with ESMTP id <S131341AbRAaLlQ>;
	Wed, 31 Jan 2001 06:41:16 -0500
Message-ID: <20010129230831.B1214@bug.ucw.cz>
Date: Mon, 29 Jan 2001 23:08:31 +0100
From: Pavel Machek <pavel@suse.cz>
To: Joe deBlaquiere <jadb@redhat.com>, Andrew Morton <andrewm@uow.edu.au>
Cc: yodaiken@fsmlabs.com, Nigel Gamble <nigel@nrg.org>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0
In-Reply-To: <200101220150.UAA29623@renoir.op.net> <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>, <Pine.LNX.4.05.10101211754550.741-100000@cosmic.nrg.org>; <20010128061428.A21416@hq.fsmlabs.com> <3A742A79.6AF39EEE@uow.edu.au> <3A74462A.80804@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <3A74462A.80804@redhat.com>; from Joe deBlaquiere on Sun, Jan 28, 2001 at 10:17:46AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > There has been surprisingly little discussion here about the
> > desirability of a preemptible kernel.
> > 
> 
> And I think that is a very intersting topic... (certainly more 
> interesting than hotmail's firewalling policy ;o)
> 
> Alright, so suppose I dream up an application which I think really 
> really needs preemption (linux heart pacemaker project? ;o) I'm just not 
> convinced that linux would ever be the correct codebase to start with. 
> The fundamental design of every driver in the system presumes that there 
> is no preemption.

Nonsense. SMP+SMM BIOS is *very* similar to preemptible kernel.

SMP means that you can run two pieces in kernel at same time. With
preemptible kernel "same" is rather bigger granularity, but thats
minor difference. And SMI BIOS means that cpu can be stopped for
arbitrary time doing its housekeeping. (Going suspend to disk?)

> A recent example I came across is in the MTD code which invokes the 
> erase algorithm for CFI memory. This algorithm spews a command sequence 
> to the flash chips followed by a list of sectors to erase. Following 
> each sector adress, the chip will wait for 50usec for another address, 
> after which timeout it begins the erase cycle. With a RTLinux-style 

With SMM BIOS, this is br0ken.

> So what is the solution in the preemption case? Should we re-write every 
> driver to handle the preemption? Do we need a cli_yes_i_mean_it()
> for 

You can dissable SMM interrupts, AFAIK.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
