Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317521AbSGOQR4>; Mon, 15 Jul 2002 12:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317522AbSGOQRz>; Mon, 15 Jul 2002 12:17:55 -0400
Received: from mail.storm.ca ([209.87.239.66]:29676 "EHLO mail.storm.ca")
	by vger.kernel.org with ESMTP id <S317521AbSGOQRy>;
	Mon, 15 Jul 2002 12:17:54 -0400
Message-ID: <3D32E97A.AD808E43@storm.ca>
Date: Mon, 15 Jul 2002 11:25:46 -0400
From: Sandy Harris <pashley@storm.ca>
Organization: Flashman's Dragoons
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [patch[ Simple Topology API
References: <p73ofdbv1a4.fsf@oldwotan.suse.de>
		<Pine.LNX.4.44.0207141156540.19060-100000@home.transmeta.com>
		<20020714214334.A16892@wotan.suse.de> <m1k7nxpvlg.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Andi Kleen <ak@suse.de> writes:
> >
> > At least on Hammer the latency difference is small enough that
> > caring about the overall bandwidth makes more sense.
> 
> I agree.  I will have to look closer but unless there is more
> juice than I have seen in Hyper-Transport it is going to become
> one of the architectural bottlenecks of the Hammer.
> 
> Currently you get 1600MB/s in a single direction.

That's on an 8-bit channel, as used on Clawhammer (AMD's lower cost
CPU for desktop market). The spec allows 2, 4, 6, 16 or 32-bit
channels. If I recall correctly, the AMD presentation at OLS said
Sledgehammer (server market) uses 16-bit.

> Not to bad.
> But when the memory controllers get out to dual channel DDR-II 400,
> the local bandwidth to that memory is 6400MB/s, and the bandwidth to
> remote memory 1600MB/s, or 3200MB/s (if reads are as common as
> writes).
> 
> So I suspect bandwidth intensive applications will really benefit
> from local memory optimization on the Hammer.  I can buy that the
> latency is negligible,

I'm not so sure. Clawhammer has two links, can do dual-CPU. One link
to the other CPU, one for I/O. Latency may well be negligible there.

Sledgehammer has three links, can do no-glue 4-way with each CPU
using two links to talk to others, one for I/O.

    I/O -- A ------ B -- I/O
           |        |
           |        |
    I/O -- C ------ D -- I/O

They can also go to no-glue 8-way:

    I/O -- A ------ B ------ E ------ G -- I/O
           |        |        |        |
           |        |        |        |
    I/O -- C ------ D ------ F ------ H -- I/O

I suspect latency may become an issue when more than one link is
involved and there can be contention.

Beyond 8-way, you need glue logic (hypertransport switches?) and
latency seems bound to become an issue.

> the fact the links don't appear to scale
> in bandwidth as well as the connection to memory may be a bigger
> issue.
