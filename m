Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129175AbRBYNzU>; Sun, 25 Feb 2001 08:55:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129170AbRBYNzJ>; Sun, 25 Feb 2001 08:55:09 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:55814 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S129144AbRBYNzA>; Sun, 25 Feb 2001 08:55:00 -0500
Subject: Re: Core dumps for threads
To: cw@f00f.org (Chris Wedgwood)
Date: Sun, 25 Feb 2001 13:57:31 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), n0ano@valinux.com (Don Dugger),
        linux-kernel@vger.kernel.org
In-Reply-To: <20010225221505.A12595@metastasis.f00f.org> from "Chris Wedgwood" at Feb 25, 2001 10:15:05 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14X1g5-00033i-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sat, Feb 24, 2001 at 09:57:44PM +0000, Alan Cox wrote:
> 
>     The I/O to dump the core would race other changes on the mm. The
>     right fix is probably to copy the mm (as fork does) then dump the
>     copy.
> 
> Stupid question... but since all threads see the same memory space as
> each other; can we not lock the entire vma for the process whilst
> it's being written out?

It isnt the vma, its the entire mm you would need to lock. And I dont think
you can do a deadlock free lock of that sanely, hence its better to copy
the mm (thats pretty efficienty anyway as it wont copy the data)

