Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262418AbTANLj5>; Tue, 14 Jan 2003 06:39:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262425AbTANLj4>; Tue, 14 Jan 2003 06:39:56 -0500
Received: from ealliance.ro ([213.233.121.14]:38361 "HELO ealliance.ro")
	by vger.kernel.org with SMTP id <S262418AbTANLjy> convert rfc822-to-8bit;
	Tue, 14 Jan 2003 06:39:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Mihnea Balta <dark_lkml@mymail.ro>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel hooks just to get rid of copy_[to/from]_user() and syscall overhead?
Date: Tue, 14 Jan 2003 13:47:16 +0200
X-Mailer: KMail [version 1.4]
References: <200301101645.39535.dark_lkml@mymail.ro>
In-Reply-To: <200301101645.39535.dark_lkml@mymail.ro>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301141347.16990.dark_lkml@mymail.ro>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 10 January 2003 16:45, Mihnea Balta wrote:
> Hi,
>
> I have to implement a system which grabs udp packets off a gigabit
> connection, take some basic action based on what they contain, repack their
> data with a custom protocol header and send them through a gigabit ethernet
> interface on broadcast.

Following the indications I got here, I did the packet recieving stuff using a 
mmaped packet socket. From what I understand, that is a recieve-only 
interface, so it seems that I'm stuck with old sendto() for putting the 
packets back on the wire. I'd like to know if sendto() can do 20000 (small) 
packets/second on a fast x86 MP machine (dual or maybe quad) which doesn't do 
much besides this routing process. If it can't, please tell me if there's any 
feasible way of implementing a kind of buffer, i.e. keeping recieved packets 
in a local buffer and sending them alltoghether when the buffer fills or 
after a timer expires (I'm thinking DMA to the NIC or something simmilar, as 
the buffer will contain the complete packets, with all the required packets).

Thanks,
Mihnea

PS: feasible == not spending 1 month development time for a 1 
microsecond/packet improvement.

