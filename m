Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311940AbSCTSt6>; Wed, 20 Mar 2002 13:49:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311943AbSCTSts>; Wed, 20 Mar 2002 13:49:48 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:59292 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S311940AbSCTSti>; Wed, 20 Mar 2002 13:49:38 -0500
Date: Wed, 20 Mar 2002 12:04:55 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: linux-kernel@vger.kernel.org
Subject: Putrid Elevator Behavior 2.4.18/19
Message-ID: <20020320120455.A19074@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Jens/Linux,

The elevator code is malfunctioning in 2.4.18/19-pre when we start 
reaching the upward limits with multiple 3Ware adapters 
running together.  We started seeing the problem when we went to 
64 K aligned writes with sustained > 200 MB/S writes to 
multiple 3Ware adapters.  

We have verified that the 3Ware adapters are not holding the request
off, but that one of the requests is getting severely starved and
does not get posted to the 3Ware adapters until thousands of IOs
have gone before it.  

The basic symptom is a lower offset 4K write gets hung in the elevator 
as it traverses a very long list of requests being written linearly 
to a disk device.  Both Darren and I have seen this problem in NetWare
with remirroring, which is why we went to the A/B alternating 
list to prevent this type of starvation.  There are a very small number 
of reads being posted during this test to update meta-data.

The data that is being held off is meta-data that occupies a lower sector 
offset on the device.  This startvation error is very troublesome and 
results in certain sectors not being freed up as anticipated, which 
results in a fatal error for our system.  The elevator ends of getting 
very far behind.  

By way of example, this delayed write is held off for several **MINUTES**.
This is severaly broken.

Please let me know what other information you would like Darren and I 
to run down and provide.  We are at present coding some changes into 
your elevator to implement an A and B list so this startvation problem
is completely avoided.

Please advise,

Jeff




