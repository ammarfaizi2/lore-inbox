Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293495AbSCZKMk>; Tue, 26 Mar 2002 05:12:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293596AbSCZKMa>; Tue, 26 Mar 2002 05:12:30 -0500
Received: from mail.actcom.co.il ([192.114.47.13]:26521 "EHLO
	lmail.actcom.co.il") by vger.kernel.org with ESMTP
	id <S293495AbSCZKMY>; Tue, 26 Mar 2002 05:12:24 -0500
Message-Id: <200203261012.g2QAC4q26806@lmail.actcom.co.il>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Itai Nahshon <nahshon@actcom.co.il>
Reply-To: nahshon@actcom.co.il
To: Kevin Pedretti <ktpedre@sandia.gov>, kernelnewbies@nl.linux.org
Subject: Re: do_exit() and lock_kernel() semantics
Date: Tue, 26 Mar 2002 12:11:51 +0200
X-Mailer: KMail [version 1.3.2]
Cc: ktpedre@sandia.gov, linux-kernel@vger.kernel.org
In-Reply-To: <3C9F7993.7050205@sandia.gov>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 25 March 2002 21:25 pm, Kevin Pedretti wrote:
> The reason I ask is that I'm working on/modifying a set of modules that
> accesses user space from interrupt context.  I know this is not a good
> thing to do generally, but for performance reasons the original author
> wanted to copy directly into a mlocked user space buffer from a network

Some drivers (I know for sure about OSS drivers) do it the opposite way.

The driver allocates a buffer (or usually multiple buffers) in physical 
memory. The buffers are directly accessible from the device hardware
for DMA etc. The interrupt routines normally would not touch the buffers
(although they could) but just tell the device how to use the buffers.

The user's process that needs to use the device can use the read/write
interface, or for better performance mmap the device (which maps
the buffers into a contiguous user space) and access the buffers directly.

With the mmap api, ioctls are used to tell the process how much new data
is available (for reading) or how much was consumed by the device (so
these buffers can be written with new data).

-- Itai
