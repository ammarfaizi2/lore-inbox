Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319030AbSHFJfZ>; Tue, 6 Aug 2002 05:35:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319031AbSHFJfZ>; Tue, 6 Aug 2002 05:35:25 -0400
Received: from [213.69.213.4] ([213.69.213.4]:30108 "EHLO i-t-c-s.de")
	by vger.kernel.org with ESMTP id <S319030AbSHFJfY> convert rfc822-to-8bit;
	Tue, 6 Aug 2002 05:35:24 -0400
X-AuthUser: tmi@wikon.de
Content-Type: text/plain; charset=US-ASCII
From: Thomas Mierau <tmi@wikon.de>
Organization: WIKON Kommunikationstechnik GmbH
To: Willy Tarreau <willy@w.ods.org>
Subject: Re: 2.4.19-ac4 IRQ messup?
Date: Tue, 6 Aug 2002 11:39:43 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208052251170.21076-100000@korben.citd.de> <200208061014.13619.tmi@wikon.de> <20020806083943.GA32229@alpha.home.local>
In-Reply-To: <20020806083943.GA32229@alpha.home.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200208061139.35323.tmi@wikon.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks,
I looked it up its called watchdog (what else). It was set to 5000ms and I 
changed it to 300ms. But the result is : no change!
I can see the transmit and receives on the switch. The problem must be the 
receive part of the transceiver.
I ran mii-diag and it reports that it is set up for full duplex 100Mbit and 
has a link. So that reports back ok.
Any other ideas ?

Am Dienstag, 6. August 2002 10:39 schrieb Willy Tarreau:
> On Tue, Aug 06, 2002 at 10:14:30AM +0200, Thomas Mierau wrote:
> > the ping on eth0
> > The blocks of 5 return at the same time , as the time differnce is always
> > 1sec off look pretty nasty
>
> I think you get intreface resets. I had such a problem with a 3c575CB (same
> driver), connected to a defective chipset. I couldn't send high traffic
> rates, but could receive. There is a watchdog timeout that you can
> reconfigure in the 3c59x driver (I don't remember its name, use modinfo).
> If you reduce the timeout, you should see reduced drifting in the pings. I
> used 300ms I think. But IMHO, that's definitely not a timing problem.
> Perhaps in your case, it's simply a half/full duplex misconfiguration.
>
> Regards,
> Willy
>
> > PING 192.168.47.47 (192.168.47.47) from 192.168.47.11 eth0: 56(84) bytes
> > of data.
> > 64 bytes from 192.168.47.47: icmp_seq=1 ttl=255 time=912 ms
> > 64 bytes from 192.168.47.47: icmp_seq=2 ttl=255 time=4912 ms
> > 64 bytes from 192.168.47.47: icmp_seq=3 ttl=255 time=3912 ms
> > 64 bytes from 192.168.47.47: icmp_seq=4 ttl=255 time=2912 ms
> > 64 bytes from 192.168.47.47: icmp_seq=5 ttl=255 time=1912 ms
> > 64 bytes from 192.168.47.47: icmp_seq=6 ttl=255 time=912 ms
> > 64 bytes from 192.168.47.47: icmp_seq=7 ttl=255 time=4905 ms
> > 64 bytes from 192.168.47.47: icmp_seq=8 ttl=255 time=3905 ms
> > 64 bytes from 192.168.47.47: icmp_seq=9 ttl=255 time=2905 ms
> > 64 bytes from 192.168.47.47: icmp_seq=10 ttl=255 time=1905 ms
> > 64 bytes from 192.168.47.47: icmp_seq=11 ttl=255 time=905 ms
> > 64 bytes from 192.168.47.47: icmp_seq=12 ttl=255 time=4912 ms
> > 64 bytes from 192.168.47.47: icmp_seq=13 ttl=255 time=3911 ms
> > 64 bytes from 192.168.47.47: icmp_seq=14 ttl=255 time=2912 ms
> > 64 bytes from 192.168.47.47: icmp_seq=15 ttl=255 time=1912 ms
> > 64 bytes from 192.168.47.47: icmp_seq=16 ttl=255 time=912 ms
> > 64 bytes from 192.168.47.47: icmp_seq=17 ttl=255 time=4902 ms
> > 64 bytes from 192.168.47.47: icmp_seq=18 ttl=255 time=3902 ms
> > 64 bytes from 192.168.47.47: icmp_seq=19 ttl=255 time=2902 ms
> > 64 bytes from 192.168.47.47: icmp_seq=20 ttl=255 time=1902 ms
> > 64 bytes from 192.168.47.47: icmp_seq=21 ttl=255 time=902 ms

