Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131680AbRAHT6c>; Mon, 8 Jan 2001 14:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131569AbRAHT6V>; Mon, 8 Jan 2001 14:58:21 -0500
Received: from mailer.psc.edu ([128.182.58.100]:21260 "EHLO mailer.psc.edu")
	by vger.kernel.org with ESMTP id <S132617AbRAHT6I>;
	Mon, 8 Jan 2001 14:58:08 -0500
Date: Mon, 8 Jan 2001 14:58:04 -0500 (EST)
From: John Heffner <jheffner@psc.edu>
To: Tim Sailer <sailer@bnl.gov>
cc: linux-kernel@vger.kernel.org, jfung@bnl.gov
Subject: Re: Network Performance?
In-Reply-To: <20010108090644.A12440@bnl.gov>
Message-ID: <Pine.NEB.4.05.10101081415330.3675-100000@dexter.psc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001, Tim Sailer wrote:

> > What is the round-trip time on the WAN?
> > 
> > Packet loss?
> 
> 101 packets transmitted, 101 packets received, 0% packet loss
> round-trip min/avg/max = 109.6/110.3/112.2 ms

Packet loss and RTT can be greatly affected by how much data you're
sending through a path, so a simple ping is probably not adequate.

Also, even a much smaller packet loss rate than 1/100 could really kill
your throughput.

> > Does the problem occur in both directions?
> 
> Good question. I'll find out.
> 
> > Are you _sure_ the window size is being set correctly? How
> > is it being set?
> 
> I'm fairly sure. We echo the value to the file. catting it back
> shows the correct value. If we go lower than default, it slows
> down even more.

You have to be certain you restart any applications currently running, but
it seems like you're probably already doing that, since you observe a
slow-down with smaller windows.

Is window scaling enabled in the kernel?
(/proc/sys/net/ipv4/tcp_window_scaling)

You said you're using this as a proxy.  To rule out the real ftp server
machine as a problem, are you doing an FTP directly from the Linux machine
to your destination?

Also, your destination machine must have an appropriate receive
window/buffer.

> > Are you able to generate TCP dumps when the problem is happening?
> 
> We can, if it will help.

Viewing a trace of the connection is often the most informative and
effective means of debugging a connection.  One note, traces should
probably be collected from the sender.  Receiver traces rarely contain
useful information.

Other questions: What kind of router(s) are you using?  How big are its
buffers?  What drop algorithm does it use?  Have you successfully had any
bulk TCP flows (from other OS's) go through this particular path at near
the full 80Mb?

There are a number of difficulties that may occur when trying to get full
bandwidth out of a long fat pipe (LFP).  You certainly aren't the only one
having problems.  Unfortunately it often takes a TCP expert to diagnose
the problem (or problems), since there are so many possible problems.

  -John

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
