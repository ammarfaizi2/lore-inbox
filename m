Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315334AbSE2OAP>; Wed, 29 May 2002 10:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315300AbSE2OAN>; Wed, 29 May 2002 10:00:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:35816 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315335AbSE2N7l>;
	Wed, 29 May 2002 09:59:41 -0400
Date: Wed, 29 May 2002 06:58:02 -0700 (PDT)
From: Nivedita Singhvi <niv@us.ibm.com>
X-X-Sender: <nivedita@w-nivedita2.des.beaverton.ibm.com>
To: Ben Greear <greearb@candelatech.com>
cc: <cfriesen@nortelnetworks.com>, <linux-kernel@vger.kernel.org>
Subject: Re: how to get per-socket stats on udp rx buffer overflow?
In-Reply-To: <3CF3EE2A.1030605@candelatech.com>
Message-ID: <Pine.LNX.4.33.0205290640580.4572-100000@w-nivedita2.des.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 May 2002, Ben Greear wrote:

> Nivedita Singhvi wrote:
> 
> >>Is there any way for me to see how many incoming packets 
> >>were dropped on a udp socket due to overflowing the input buffer?  
> >>I specifically want this information on a per-socket basis.
> >>
> > 
> > The /proc/net/snmp Udp counter InErrors includes the global
> > count. It would be expensive and usually unnecessary to keep
> > per-socket stats. Is there a real need for seeing the 
> > per-socket count?
> 
> 
> It would not be that expensive..it's just an extra counter that
> is bumped whenever a pkt is dropped.

True for one counter, but generally when considering per
socket stats as a feature, you include all the TCP/UDP/IP
stats, and if youre not holding locks, thats probably an
atomic increment.  Pretty soon we're talking actual
performance and scalability money. (Even if we're not
in the mindset of saving every cycle wherever possible).


> I have need of similar information, but it's low priority
> for me right now, so I probably won't be adding a patch anytime
> soon...

If the info was needed and useful however, then thats a 
different matter :).


> > If it helps, you can check the current bytes in the recv queue
> > in netstat output - you wont know how many bytes have been dropped,
> > but at least you know the amnt in the queue waiting to be read..
> 
> 
> That is nearly worthless unless you are really killing your machine
> and constantly have your buffers full...

Yep, true, it was just a thought to help him identify
the connection that was droping packets because the queue
was full..

> Ben
> 

thanks,
Nivedita

