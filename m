Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265586AbUAGPyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 10:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265600AbUAGPyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 10:54:44 -0500
Received: from user-12hcje4.cable.mindspring.com ([69.22.77.196]:53420 "EHLO
	bender.davehollis.com") by vger.kernel.org with ESMTP
	id S265586AbUAGPym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 10:54:42 -0500
Subject: Re: Slow receive with AX8817 USB2 ethernet adapter
From: David T Hollis <dhollis@davehollis.com>
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <yw1xisjnvp9e.fsf@ford.guide>
References: <yw1xr7ybvpv0.fsf@ford.guide>  <yw1xisjnvp9e.fsf@ford.guide>
Content-Type: text/plain; charset=
Message-Id: <1073490614.5634.31.camel@dhollis-lnx.kpmg.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8) 
Date: Wed, 07 Jan 2004 10:54:38 -0500
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-01-07 at 08:53, Måns Rullgård wrote:
> mru@kth.se (Måns Rullgård) writes:
> 
> > I'm getting very bad receive rates with a Netgear FA-120 USB2 Ethernet
> > adapter under Linux 2.6.0.  Timing an incoming TCP stream, I get only
> > 600 kB/s.  Sending works properly at 10 MB/s.  I first reported this
> > problem some time in July or August.  Is it just me having this issue?
> > Can I get any helpful information somehow?
> 
Hmm, I am seeing the same results using ttcp:

**** Send Results ****
[root@dhollis-lnx dhollis]# ttcp -t -s -D -n 8192 192.168.5.1
ttcp-t: buflen=8192, nbuf=8192, align=16384/0, port=5001  tcp  ->
192.168.5.1
ttcp-t: socket
ttcp-t: nodelay
ttcp-t: connect
ttcp-t: 67108864 bytes in 7.89 real seconds = 8302.39 KB/sec +++
ttcp-t: 8192 I/O calls, msec/call = 0.99, calls/sec = 1037.80
ttcp-t: 0.0user 0.1sys 0:07real 1% 0i+0d 0maxrss 0+2pf 1118+151csw


**** Receiving Results *****
[root@dhollis-lnx 2.6.0]# ttcp -r -s -D
ttcp-r: buflen=8192, nbuf=2048, align=16384/0, port=5001  tcp
ttcp-r: socket
ttcp-r: accept from 192.168.5.1
ttcp-r: 16777216 bytes in 25.18 real seconds = 650.68 KB/sec +++
ttcp-r: 7385 I/O calls, msec/call = 3.49, calls/sec = 293.29
ttcp-r: 0.0user 0.1sys 0:25real 0% 0i+0d 0maxrss 0+2pf 10115+163csw


[root@dhollis-lnx 2.6.0]# ttcp -r -s -D
ttcp-r: buflen=8192, nbuf=2048, align=16384/0, port=5001  tcp
ttcp-r: socket
ttcp-r: accept from 192.168.5.1
ttcp-r: 67108864 bytes in 5.81 real seconds = 11276.03 KB/sec +++
ttcp-r: 42074 I/O calls, msec/call = 0.14, calls/sec = 7239.19
ttcp-r: 0.0user 0.4sys 0:05real 8% 0i+0d 0maxrss 0+2pf 41000+3667csw


Notice that I was able to achieve 11MB/s at one point and I was able to
repeat those results continually.  I then unloaded the module, reloaded,
re-ifconfigged and was back at the 600-700k mark.  It's going to take
some further debugging to fully trace this problem out.

-- 
David T Hollis <dhollis@davehollis.com>

