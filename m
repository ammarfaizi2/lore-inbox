Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316159AbSENXix>; Tue, 14 May 2002 19:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316160AbSENXiw>; Tue, 14 May 2002 19:38:52 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:38924 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S316159AbSENXiv>; Tue, 14 May 2002 19:38:51 -0400
Subject: Re: InfiniBand BOF @ LSM - topics of interest
To: Tony.P.Lee@nokia.com
Date: Wed, 15 May 2002 00:58:14 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk, lmb@suse.de, woody@co.intel.com,
        linux-kernel@vger.kernel.org, zaitcev@redhat.com
In-Reply-To: <4D7B558499107545BB45044C63822DDE3A206D@mvebe001.NOE.Nokia.com> from "Tony.P.Lee@nokia.com" at May 14, 2002 01:19:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E177mBK-0000gT-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I like to see user application such as VNC, SAMBA build directly
> on top of IB API.  I have couple of IB cards that can 
> send 10k 32KBytes message (320MB of data) every ~1 second over 
> 1x link with only <7% CPU usage (single CPU xeon 700MHz).  
> I was very impressed.  
> 
> Go thru the socket layer API would just slow thing down.

Thats an assumption that is actually historically not a very good one to
make. There are fundamental things that most of the "no network layer"
people tend to forget

1.	Van Jacobson saturated 10Mbit ethernet with a Sun 3/50
2.	SGI saturated HIPPI with MIPS processors that are at best comparable
	to the lowest end wince PDAs
3.	Having no network layer in almost every case is tied to the belief
	that bandwidth is infinite and you need to congestion control

In a network congestion based collapse is spectacularly bad. Some of the
internet old hands can probably tell you the horror stories of the period
the whole internet backbone basically did that until they got their research
right. Nagle's tinygram congestion avoidance work took Ford's network usage
down by I believe the paper quoted 90%.

The socket API is very efficient. TCP is extremely efficient in the service
it provides. IB can support large messages, which massively ups the throughput.

Let me ask you a much more important question 

Can you send achieve 90% efficiency on a 90% utilized fabric with multiple
nodes and multiple hops ? If you can't then you are not talking about a 
network you are talking about a benchmark.

Alan

