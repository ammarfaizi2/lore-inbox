Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131307AbRDIANa>; Sun, 8 Apr 2001 20:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131308AbRDIANV>; Sun, 8 Apr 2001 20:13:21 -0400
Received: from ns.suse.de ([213.95.15.193]:24082 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S131307AbRDIANR>;
	Sun, 8 Apr 2001 20:13:17 -0400
Date: Mon, 9 Apr 2001 02:13:09 +0200
From: Andi Kleen <ak@suse.de>
To: Alex Q Chen <aqchen@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Zero Copy IO
Message-ID: <20010409021309.A17466@gruyere.muc.suse.de>
In-Reply-To: <OF31086D36.2158EA0D-ON87256A28.008001ED@LocalDomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <OF31086D36.2158EA0D-ON87256A28.008001ED@LocalDomain>; from aqchen@us.ibm.com on Sun, Apr 08, 2001 at 04:31:27PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2001 at 04:31:27PM -0700, Alex Q Chen wrote:
> I am trying to find a way to pin down user space memory from kernel, so
> that these user space buffer can be used for direct IO transfer or
> otherwise known as "zero copying IO".  Searching through the Internet and
> reading comments on various news groups, it would appear that most
> developers including Linus himself doesn't believe in the benefit of "zero
> copying IO".  Most of the discussion however was based on network card
> drivers.  For certain other drivers such as SCSI Tape driver, which need to
> handle great deal of data transfer, it would seemed still be more
> advantageous to enable zero copy IO than copy_from_user() and copy_to_user
> () all the data.  Other OS such as AIX and OS2 have kernel functions that
> can be used to accomplish such a task.  Has any ground work been done in
> Linux 2.4 to enable "zero copying IO"?

Yes, e.g. the raw io device does it using kiovecs. See 
drivers/char/raw.c,fs/iobuf.c et.al. 2.4+zerocopy networking also has a 
different implementation.
The raw.c implementation is not very efficient at the moment though,
mostly because of limitations in the block device layer (but that 
should be no problem for a direct tape driver) 
This work is also in the 2.2 kernels of most distributions.


-Andi

