Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273455AbRIYUCD>; Tue, 25 Sep 2001 16:02:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273462AbRIYUBx>; Tue, 25 Sep 2001 16:01:53 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:43535 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S273455AbRIYUBq>; Tue, 25 Sep 2001 16:01:46 -0400
Message-ID: <3BB0E2B1.6DCCF9DF@zip.com.au>
Date: Tue, 25 Sep 2001 13:01:53 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Chris Newton <newton@unb.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: excessive interrupts on network cards
In-Reply-To: <3BB0E01D@webmail1>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Newton wrote:
> 
> Hi,
> 
>   I 'think' the number of interrupts being generated for the network traffic I
> monitor, is excessive.  Having talked quikly with Donald Becker, he indicated
> that I should be seeing a little less than the number of RX/TX packets/s on a
> wire, in terms of interrupts/s.  That, however, is not what I am seeing.  I am
> seeing 3 times as many interrupts/s as I am seeing packets/s.
> 
>   I have used three network devices to look at the stream I am monitoring, and
> it is usually aorund 5K packet/s IN, and 5K out, fed full duplex into a single
> 3Com 3c982 (2.4.10 kernel reports that anyways).  However, watching:

3c982 is a dual-port server NIC.  Is your card dual-port?  If not, it's probably
a 3c980, and I goofed :)

>  'procinfo -D', reports on the order of 30,000 interrupts per second.

That does sound rather high.  You should compare the interrupt rate
with the packet rate from `ifconfig' or /proc/net/dev.

Normally, 3c59x will show approx three Tx packets per interrupt
and one Rx packet per interrupt.  It varies with workload, but
it tends to vary in the "good" direction - at higher packet
rates, we do more work in a single interrupt and the interrupt-per-packet
rate falls.
