Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751383AbWAZTsT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751383AbWAZTsT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:48:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWAZTsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:48:18 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.143]:48842 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751382AbWAZTsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:48:15 -0500
In-Reply-To: <9e4733910601251603n543dbe3ej93286743b01eef6e@mail.gmail.com>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Re: [RFC] VM: I have a dream...
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF71C72623.C3A3C598-ON88257102.006A1BB5-88257102.006CC98C@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 26 Jan 2006 11:48:14 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0HF124 | January 12, 2006) at
 01/26/2006 14:48:13,
	Serialize complete at 01/26/2006 14:48:13
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Are there any Linux file systems that work by mmapping the entire
>drive and using the paging system to do the read/writes? With 64 bits
>there's enough address space to do that now. How does this perform
>compared to a traditional block based scheme?

They pretty much all do that.  A filesystem driver doesn't actually map 
the whole drive into memory addresses all at once and generate page faults 
by referencing memory -- instead, it generates the page faults explicitly, 
which it can do more efficiently, and sets up the mappings in smaller 
pieces as needed (also more efficient).  But the code that reads the pages 
into the file cache and cleans dirty file cache pages out to the disk is 
the same paging code that responds to page faults on malloc'ed pages and 
writes such pages out to swap space when their page frames are needed for 
other things.

>With the IBM 128b address space aren't the devices vulnerable to an
>errant program spraying garbage into the address space? Is it better
>to map each device into it's own address space?

Partitioning your storage space along device lines and making someone who 
wants to store something identify a device for it is a pretty primitive 
way of limiting errant programs.  Something like Linux disk quota and 
rlimit (ulimit) is more appropriate to the task, and systems that gather 
all their disk storage (even if separate from main memory) into a single 
automated pool do have such quota systems.

--
Bryan Henderson                     IBM Almaden Research Center
San Jose CA                         Filesystems

