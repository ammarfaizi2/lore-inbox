Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273305AbSISVVx>; Thu, 19 Sep 2002 17:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273289AbSISVV3>; Thu, 19 Sep 2002 17:21:29 -0400
Received: from air-2.osdl.org ([65.172.181.6]:50706 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S273214AbSISVTr>;
	Thu, 19 Sep 2002 17:19:47 -0400
Date: Thu, 19 Sep 2002 14:25:05 -0700
From: Dave Olien <dmo@osdl.org>
To: Daniel Phillips <phillips@arcor.de>
Cc: Jens Axboe <axboe@suse.de>, Samium Gromoff <_deepfire@mail.ru>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.5] DAC960
Message-ID: <20020919142505.B27767@acpi.pdx.osdl.net>
References: <E17odbY-000BHv-00@f1.mail.ru> <20020915131920.GR935@suse.de> <20020916131359.A17880@acpi.pdx.osdl.net> <E17r2Rr-0001Vk-00@starship>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E17r2Rr-0001Vk-00@starship>; from phillips@arcor.de on Mon, Sep 16, 2002 at 10:26:23PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Daniel

Here's my latest progress on my changes to the DAC960 driver.

I spent Tuesday banging my head trying to figure out why data blocks
written to disk to SOMETIMES were read back with DIFFERENT data.
On wednesday, I changed from using Linux 2.5.34 to using Linux 2.5.36.
My bad data problem went away with that change.  There must have been
an important change in the 2.5.36 BIO code.

However, this change uncovered a yank-put error in my version of the
driver's shutdown notification function.  The version I mailed you will
print out messages about "bad dma" when you try to shutdown.
That code is freeing some dma structures to the wrong dma pool.
 Apparently Linux 2.5.34 never called that function.

I'm about to test changes to put the command and status mailboxes
into dma memory regions. I'll run some tests on it
over the week end, and mail you a new set of changes on Monday.

Let me know how it goes.

Thanks!


On Mon, Sep 16, 2002 at 10:26:23PM +0200, Daniel Phillips wrote:
> > 
> > I have the DAC960 driver working in 2.5.34.  The work isn't
> > complete yet.  But, I'm able to boot, and do mke2fs
> > on partitions on logical drives, and then do e2fsck
> > on those partitions.  It seems to work, although more
> > testing is required.  Is there any interest in reviewing
> > the code so far, or should I continue testing and complete
> > the remaining issues first?
> 
> Please post the patch, I'll try it right away.
> 
> -- 
> Daniel
