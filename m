Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313124AbSDOJ0V>; Mon, 15 Apr 2002 05:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313126AbSDOJ0U>; Mon, 15 Apr 2002 05:26:20 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:19731 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313124AbSDOJ0T>; Mon, 15 Apr 2002 05:26:19 -0400
Subject: Re: Direct access to IDE disk from kernel modules
To: Enrico.bravin@cern.ch (Enrico BRAVIN)
Date: Mon, 15 Apr 2002 10:44:08 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3CBA9B27.1020904@cern.ch> from "Enrico BRAVIN" at Apr 15, 2002 11:19:35 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16x31s-0005sD-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a way to directly dump a buffer on an IDE disk from inside a 
> kernel module without goig trough user space?
> I have written a driver for a frame grabber and would like be able to 
> dump the frames real time directly to a dedicated IDE disk.
> My frames are already in a DMAble buffer.

You can get the same effect going via user space just fine, and the
performance of IDE is well below the point that should make a difference
since PCI bandwidth is likely to be your bottleneck.

mmap the capture buffers into a user application (eg video4linux api), then
write the files using the O_DIRECT option or a raw device (see rawctl and
friends)
