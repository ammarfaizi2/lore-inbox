Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316499AbSEOUs5>; Wed, 15 May 2002 16:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316500AbSEOUs5>; Wed, 15 May 2002 16:48:57 -0400
Received: from mgw-dax2.ext.nokia.com ([63.78.179.217]:64673 "EHLO
	mgw-dax2.ext.nokia.com") by vger.kernel.org with ESMTP
	id <S316499AbSEOUsy> convert rfc822-to-8bit; Wed, 15 May 2002 16:48:54 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: InfiniBand BOF @ LSM - topics of interest
Date: Wed, 15 May 2002 13:47:42 -0700
Message-ID: <4D7B558499107545BB45044C63822DDE3A2071@mvebe001.NOE.Nokia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: InfiniBand BOF @ LSM - topics of interest
Thread-Index: AcH8J9i54SrCHhaIQkejsHwr2jMOIgAJVmcg
From: <Tony.P.Lee@nokia.com>
To: <wookie@osdl.org>, <alan@lxorguk.ukuu.org.uk>
Cc: <lmb@suse.de>, <woody@co.intel.com>, <linux-kernel@vger.kernel.org>,
        <zaitcev@redhat.com>
X-OriginalArrivalTime: 15 May 2002 20:47:43.0317 (UTC) FILETIME=[C2C2A050:01C1FC51]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Thats an assumption that is actually historically not a 
> very good one to
> > make. There are fundamental things that most of the "no 
> network layer"
> > people tend to forget
> > 
> > 1.	Van Jacobson saturated 10Mbit ethernet with a Sun 3/50
> > 2.	SGI saturated HIPPI with MIPS processors that are at 
> best comparable
> > 	to the lowest end wince PDAs
> > 3.	Having no network layer in almost every case is tied to 
> the belief
> > 	that bandwidth is infinite and you need to congestion control
> > 
>  First I want to say that the average person using the system the
> socket interface with the underlying network stack is the best
> way to go. IMHO
>  
> But if the issue isn't throughput and if the application requires
> some items to have low latency.  The size of the network stack can
> have an adverse effect on the overall performance of the system.  A
> good example is in a Distributed Lock Manager (DLM).  In this case
> the round trip including the software stack limits the number of
> locks per second that can occur. 
> 
>   So if we can fit everything that we need into a 64 byte IB packet
> for the imaginary application that would take 256 nsec to transmit
> to the other system. (2.5 Gb/sec link) If you assume zero turn around
> time you get 512 nsec as the lowest lock request/grant time possible
> which puts you in the range of doing a little under 980,000
> lock/unlock operations per second on a single lock and of course when
> you add the software to actually process the packet the number of
> lock/unlock operations per second will always be below that 
> in the real 
> world.  When you compare this to a modern processors ability to
> do lock/unlocks this is really a small number of lock/unlock 
> operations per second. 
> 
> So the ability to scarf that packet into the application and respond
> is the hard issue to solve in scalability.
> 
> Tim
> 

For VNC type application, instead server translates
every X Windows, Mac, Windows GUI calls/Bitmap update
to TCP stream, you convert the GUI API calls to 
IB RC messages and bitmap updates to RDMA write directly 
to client app's frame buffer.  

For SAMBA like fs, the file read api can be translated to 
IB RC messages on client + RDMA write to remote 
client app's buffer directly from server.

They won't be "standard" VNC/SAMBA any more. 

On the other hand, we can put VNC over TCP over IP over IB,
- "for people with hammer, every problem looks like a nail." :-)

In theory, we can have IB DVD drive RDMA video directly 
over IB switch to IB enable VGA frame buffer and completely
by pass the system.  CPU only needed setup the proper 
connections.   The idea is to truely virtualized the system
resources and "resource server" RDMA the data to anyone on IB
switch with minimal CPU interaction in the process.

You can also config a normal SCSI card DMA data to virtualized 
IB address on PCI address space and have the data shows up 15 meters
or 2 km away on server's "virtual scsi driver" destination DMA address.
It made iSCSI looked like dial up modem in term of performance
and latency. 


----------------------------------------------------------------
Tony 
