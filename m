Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262859AbSJaStP>; Thu, 31 Oct 2002 13:49:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262805AbSJaStO>; Thu, 31 Oct 2002 13:49:14 -0500
Received: from chaos.analogic.com ([204.178.40.224]:18562 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263246AbSJaStB>; Thu, 31 Oct 2002 13:49:01 -0500
Date: Thu, 31 Oct 2002 13:57:48 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: jt@hpl.hp.com
cc: Juan Gomez <juang@us.ibm.com>, Josh Myer <jbm@joshisanerd.com>,
       jbm@blessed.joshisanerd.com, linux-kernel@vger.kernel.org
Subject: Re: How to get a local IPv4 address from within a kernel module?
In-Reply-To: <20021031183009.GB2972@bougret.hpl.hp.com>
Message-ID: <Pine.LNX.3.95.1021031135434.13160A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Oct 2002, Jean Tourrilhes wrote:

> On Thu, Oct 31, 2002 at 10:09:54AM -0800, Juan Gomez wrote:
> > 
> > Josh
> > 
> > That is the purpose of my orignal message. In fact I have implemented
> > somthing along the lines of what you suggest below and I just want to test
> > the waters on whether this will be accepted. My current implementation is a
> > little more specific as it only gets the interfaces with IPv4 enabled on
> > them and skip lo but the idea is to get a consensus on what would be
> > genrally useful and then introduce that.
> > 
> > Regards, Juan
> 
> 	I personally think it's a very bad idea, because it will lead
> to confusion. You will define a concept of "the node IP address",
> which doesn't exist and is a very dangerous assumption.
> 	Just take VPN, which is becoming very widespread. You have two
> IP addresses, one on the interface, one on the tunnel. Which one do
> you get ? Those two IP address will have widely different behaviour
> and you can't exchange them.
> 	My fear is that people will start coding around this API and
> flawed concept, and most of their programs will be immediately flawed,
> because incapable to adapt to the reality of networking (it will work
> in the simple case, but give bizarre behavior in non simple cases).
> 	Don't get me wrong, there is a small class of applications
> where the IP address doesn't matter (and for those, 127.0.0.1 should
> be fine). But, from my experience, the vast majority of people wanting
> "the node IP address" have broken designs, i.e. it's not that they
> want any one of them, it's that they assume that only one exist.
> 
> 	Now, there is only one thing that could qualify as "the node
> IP address", this is the IP address associated with the hostname :
> 		gethostbyname(hostname());
> 	IMHO, if you define the interface you are proposing, it should
> always return the result above, because this is a well defined
> semantic and it is more useful.
> 
> 	But, I'm only one of the little guy here, so what I say
> doesn't matter much. Ask Alan or DaveM.
> 	Regards,
> 
> 	Jean
> -

Also, many machines have many IP addresses, even when using the 
same controller:

eth0      Link encap:Ethernet  HWaddr 00:50:DA:19:7A:7D  
          inet addr:10.100.2.224  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          RX packets:8339427 errors:4 dropped:0 overruns:0 frame:4
          TX packets:650046 errors:0 dropped:0 overruns:0 carrier:0
          collisions:4954 txqueuelen:100 
          Interrupt:10 Base address:0xb800 

eth0:1    Link encap:Ethernet  HWaddr 00:50:DA:19:7A:7D  
          inet addr:10.106.100.167  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:10 Base address:0xb800 

eth0:2    Link encap:Ethernet  HWaddr 00:50:DA:19:7A:7D  
          inet addr:10.106.100.232  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:10 Base address:0xb800 

eth0:3    Link encap:Ethernet  HWaddr 00:50:DA:19:7A:7D  
          inet addr:10.106.100.233  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:10 Base address:0xb800 

eth0:4    Link encap:Ethernet  HWaddr 00:50:DA:19:7A:7D  
          inet addr:10.106.100.234  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:10 Base address:0xb800 

eth0:5    Link encap:Ethernet  HWaddr 00:50:DA:19:7A:7D  
          inet addr:10.106.100.235  Bcast:10.255.255.255  Mask:255.0.0.0
          UP BROADCAST RUNNING MULTICAST  MTU:1500  Metric:1
          Interrupt:10 Base address:0xb800 

lo        Link encap:Local Loopback  
          inet addr:127.0.0.1  Mask:255.0.0.0
          UP LOOPBACK RUNNING  MTU:16436  Metric:1
          RX packets:19174 errors:0 dropped:0 overruns:0 frame:0
          TX packets:19174 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:0 



Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
   Bush : The Fourth Reich of America


