Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262616AbUKQVVc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262616AbUKQVVc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 16:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbUKQVUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 16:20:34 -0500
Received: from tarius.tycho.ncsc.mil ([144.51.3.1]:26860 "EHLO tycho.ncsc.mil")
	by vger.kernel.org with ESMTP id S262571AbUKQVRC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 16:17:02 -0500
Message-ID: <0D2F5426C26FD511A1C400B0D0D0596801569196@deliverance.tycho.ncsc.mil>
From: "DuBuisson, Thomas" <tmdubui@tycho.ncsc.mil>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: IPsec packet dropping due to MTU problem (was RE: XFRM / DF F
	lag / Fragmentation Needed)
Date: Wed, 17 Nov 2004 16:16:53 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> After A establishes an SSH connection with C and tries to transfer the
>> patches the size of a packet from A destined for C quickly reaches 1500
>> while the MTU
>> to A is ~1400.  At this point A sends an ICMP 'Fragmentation Needed'
>> packet to its self (see xfrm_output.c xfrm4_tunnel_check_size(...)).  It
>> seems this packet is never acted on - it just disappears into the
>> loopback interface.  The proper mtu trial/error process never takes
>> place.
>There is a known problem in xfrm4_tunnel_check_size if your underlying
>path MTU is a multiple of 8.  So if your path MTU is 1480, you'll need
>to lower it to 1476 before it will work.
The problem occurs even when the PMTU is any value, 1476 would be one
example.
While I don't quite understand the xfrm4_tunnel_check_size bug by looking at
the code but
I have instrumented the function and don't see any behavior I disagree with
in the tested 
cases.  

It seems to me that this problem is more with Linux ignoring the received
ICMP error.  
ICMP messages from a host to itself, imh observation, aren't properly
handled and that is where the problem I have encountered is coming from.

Thomas
