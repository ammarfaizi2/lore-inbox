Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275012AbRJJHCV>; Wed, 10 Oct 2001 03:02:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275003AbRJJHCK>; Wed, 10 Oct 2001 03:02:10 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:60103 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S274997AbRJJHBv>; Wed, 10 Oct 2001 03:01:51 -0400
Date: Wed, 10 Oct 2001 12:36:03 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: balbir.singh@wipro.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: RFC: patch to allow lock-free traversal of lists with insertion
Message-ID: <20011010123603.A17043@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In article <3BC3D9ED.6050901@wipro.com> BALBIR SINGH wrote:

> What about cases like the pci device list or any other such list. Sometimes
> you do not care if somebody added something, while you were looking through
> the list as long as you do not get illegal addresses or data.
> Wouldn't this be very useful there? Most of these lists come up
> at system startup and change rearly, but we look through them often.

How often does the linux kernel need to go through the PCI device
list ? Looking at only SCSI code, it seems that not very often.
If that is the case in general, optimizing it for lockless
lookup (assuming that you use RCU or something to support deletion),
is probably an overkill.

One example of where it is useful is maintenance of route information
in either storage or network. Route information changes infrequently but
needs to be looked up for every I/O and being able to do lockless
lookup here is a good gain.

Thanks
Dipankar
-- 
Dipankar Sarma  <dipankar@in.ibm.com> Project: http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
