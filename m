Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266233AbUAGQNu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266238AbUAGQNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:13:50 -0500
Received: from user-12hcje4.cable.mindspring.com ([69.22.77.196]:60844 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S266233AbUAGQNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:13:13 -0500
Subject: Re: Slow receive with AX8817 USB2 ethernet adapter
From: David T Hollis <dhollis@davehollis.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1073490614.5634.31.camel@dhollis-lnx.kpmg.com>
References: <yw1xr7ybvpv0.fsf@ford.guide>  <yw1xisjnvp9e.fsf@ford.guide>
	 <1073490614.5634.31.camel@dhollis-lnx.kpmg.com>
Content-Type: text/plain; charset=
Message-Id: <1073491990.5634.36.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 07 Jan 2004 11:13:10 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-07 at 10:54, David T Hollis wrote:
> On Wed, 2004-01-07 at 08:53, Måns Rullgård wrote:
> > mru@kth.se (Måns Rullgård) writes:
> > 
> > > I'm getting very bad receive rates with a Netgear FA-120 USB2 Ethernet
> > > adapter under Linux 2.6.0.  Timing an incoming TCP stream, I get only
> > > 600 kB/s.  Sending works properly at 10 MB/s.  I first reported this
> > > problem some time in July or August.  Is it just me having this issue?
> > > Can I get any helpful information somehow?
> > 
> Hmm, I am seeing the same results using ttcp:
> 
Some more results.  This time I walked away for a few minutes, came back
and ran the test again and started getting the 10MB numbers again.  No
driver unload, etc.  Interesting thing is the I/O calls and time per
call.  I'm curious as to whether  the varying results are tied to memory
allocation, locking, or what.

[root@dhollis-lnx 2.6.0]# ttcp -r -s -D
ttcp-r: buflen=8192, nbuf=2048, align=16384/0, port=5001  tcp
ttcp-r: socket
ttcp-r: accept from 192.168.5.1
ttcp-r: 16777216 bytes in 24.33 real seconds = 673.40 KB/sec +++
ttcp-r: 7523 I/O calls, msec/call = 3.31, calls/sec = 309.20
ttcp-r: 0.0user 0.1sys 0:24real 0% 0i+0d 0maxrss 0+2pf 10348+204csw
[root@dhollis-lnx 2.6.0]# ttcp -r -s -D
ttcp-r: buflen=8192, nbuf=2048, align=16384/0, port=5001  tcp
ttcp-r: socket
ttcp-r: accept from 192.168.5.1
ttcp-r: 16777216 bytes in 26.47 real seconds = 618.95 KB/sec +++
ttcp-r: 7623 I/O calls, msec/call = 3.56, calls/sec = 287.98
ttcp-r: 0.0user 0.2sys 0:26real 0% 0i+0d 0maxrss 0+2pf 10502+218csw
[root@dhollis-lnx 2.6.0]# ttcp -r -s -D
ttcp-r: buflen=8192, nbuf=2048, align=16384/0, port=5001  tcp
ttcp-r: socket
ttcp-r: accept from 192.168.5.1
ttcp-r: 16777216 bytes in 1.49 real seconds = 11011.40 KB/sec +++
ttcp-r: 10862 I/O calls, msec/call = 0.14, calls/sec = 7300.16
ttcp-r: 0.0user 0.1sys 0:01real 8% 0i+0d 0maxrss 0+2pf 10685+712csw
[root@dhollis-lnx 2.6.0]# ttcp -r -s -D
ttcp-r: buflen=8192, nbuf=2048, align=16384/0, port=5001  tcp
ttcp-r: socket
ttcp-r: accept from 192.168.5.1
ttcp-r: 16777216 bytes in 1.49 real seconds = 10994.16 KB/sec +++
ttcp-r: 10722 I/O calls, msec/call = 0.14, calls/sec = 7194.79
ttcp-r: 0.0user 0.0sys 0:01real 6% 0i+0d 0maxrss 0+2pf 10467+1568csw
[root@dhollis-lnx 2.6.0]# ttcp -r -s -D
ttcp-r: buflen=8192, nbuf=2048, align=16384/0, port=5001  tcp
ttcp-r: socket
ttcp-r: accept from 192.168.5.1
ttcp-r: 67108864 bytes in 5.86 real seconds = 11183.02 KB/sec +++
ttcp-r: 42708 I/O calls, msec/call = 0.14, calls/sec = 7287.66
ttcp-r: 0.0user 0.4sys 0:05real 8% 0i+0d 0maxrss 0+2pf 41508+8406csw

-- 
David T Hollis <dhollis@davehollis.com>

