Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129734AbRCAQxx>; Thu, 1 Mar 2001 11:53:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129725AbRCAQxo>; Thu, 1 Mar 2001 11:53:44 -0500
Received: from gear.torque.net ([204.138.244.1]:62224 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S129723AbRCAQxh>;
	Thu, 1 Mar 2001 11:53:37 -0500
Message-ID: <3A9E7D1B.3B0C067B@torque.net>
Date: Thu, 01 Mar 2001 11:47:23 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.4.2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Writing on raw device with software RAID 0 is slow
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Ben LaHaise wrote:
> On Thu, 1 Mar 2001, Stephen C. Tweedie wrote:
> 
> > Yep.  There shouldn't be any problem increasing the 64KB size, it's
> > only the lack of accounting for the pinned memory which stopped me
> > increasing it by default.
> 
> Actually, how about making it a sysctl?  That's probably the most
> reasonable approach for now since the optimal size depends on hardware.

Something else may slow down raw IO. A buffer
that looks contiguous in the user space typically looks
quite splintered from the kernel's perspective. This
means that a buffer of 64 KB in the user space ends
up being a scatter gather list of 16 elements (assuming
PAGE_SIZE of 4KB) en route to the IDE or SCSI subsystem.

Now one SCSI adapter that I have examined must push each
scatter gather element through its firmware to the DMA 
engine which can only hold one element at a time. 
That takes time.

Doug Gilbert
