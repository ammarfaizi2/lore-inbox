Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932368AbWBBWdZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932368AbWBBWdZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 17:33:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932367AbWBBWdY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 17:33:24 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:13503 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932373AbWBBWdX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 17:33:23 -0500
In-Reply-To: <200602022159.04508.a1426z@gawab.com>
To: Al Boldi <a1426z@gawab.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>
MIME-Version: 1.0
Subject: Re: [RFC] VM: I have a dream...
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OFA0D197E9.2DB3AE6F-ON88257109.007A60B4-88257109.007BE836@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Thu, 2 Feb 2006 14:33:18 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Release 7.0HF124 | January 12, 2006) at
 02/02/2006 17:33:19,
	Serialize complete at 02/02/2006 17:33:19
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>So w/ 1GB RAM, no swap, and 1TB disk mmap'd, could this mmap'd space be 
added 
>to the total memory available to the OS, as is done w/ swap?

Yes.

>And if that's possible, why not replace swap w/ mmap'd disk-space?

Because mmapped disk space has a permanent mapping of address to disk 
location.  That's how the earliest virtual memory systems worked, but we 
moved beyond that to what we have now (what we've been calling swapping), 
where the mapping gets established at the last possible moment, which 
means we can go a lot faster.  E.g. when the OS needs to steal 10 page 
frames used for malloc pages which are scattered across the virtual 
address space, it could write all those pages out in a single cluster 
wherever a disk head happens to be at the moment.

Also, given that we use multiple address spaces (my shell and your shell 
both have an Address 0, but they're different pages), there'd be a giant 
allocation problem in assigning a contiguous area of disk to each address 
space.

--
Bryan Henderson                     IBM Almaden Research Center
San Jose CA                         Filesystems

