Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283707AbRLEDSt>; Tue, 4 Dec 2001 22:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283712AbRLEDSj>; Tue, 4 Dec 2001 22:18:39 -0500
Received: from fluent1.pyramid.net ([206.100.220.212]:56876 "EHLO
	fluent1.pyramid.net") by vger.kernel.org with ESMTP
	id <S283707AbRLEDSe>; Tue, 4 Dec 2001 22:18:34 -0500
Message-Id: <4.3.2.7.2.20011204190927.00df5b80@10.1.1.42>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Tue, 04 Dec 2001 19:17:45 -0800
To: "David S. Miller" <davem@redhat.com>, lm@bitmover.com
From: Stephen Satchell <satch@concentric.net>
Subject: Re: SMP/cc Cluster description
Cc: Martin.Bligh@us.ibm.com, riel@conectiva.com.br, lars.spam@nocrew.org,
        alan@lxorguk.ukuu.org.uk, hps@intermeta.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <20011204.183601.22018455.davem@redhat.com>
In-Reply-To: <20011204163646.M7439@work.bitmover.com>
 <Pine.LNX.4.33L.0112042129160.4079-100000@imladris.surriel.com>
 <2457910296.1007480257@mbligh.des.sequent.com>
 <20011204163646.M7439@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:36 PM 12/4/01 -0800, David S. Miller wrote:
>What is the difference between your messages and spin locks?
>Both seem to shuffle between cpus anytime anything interesting
>happens.
>
>In the spinlock case, I can thread out the locks in the page cache
>hash table so that the shuffling is reduced.  In the message case, I
>always have to talk to someone.

While what I'm about to say has little bearing on the SMP/cc case:  one 
significant advantage of messages over spinlocks is being able to assign 
priority with low overhead in the quick-response real-time multi-CPU 
arena.  I worked with a cluster of up to 14 CPUs using something very much 
like NUMA in which task scheduling used a set of prioritized message 
queues.  The system I worked on was designed to break transaction-oriented 
tasks into a string of "work units" each of which could be processed very 
quickly -- on the order of three milliseconds or less.  (The limit of 14 
CPUs was set by the hardware used to implement the main system bus.)

I bring this up only because I have never seen a spinlock system that dealt 
with priority issues very well when under heavy load.

OK, I've said my piece, now I'll sit back and continue to watch your 
discussion.

Satch

