Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269207AbRHBXVR>; Thu, 2 Aug 2001 19:21:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268928AbRHBXVH>; Thu, 2 Aug 2001 19:21:07 -0400
Received: from gear.torque.net ([204.138.244.1]:49420 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S268874AbRHBXUx>;
	Thu, 2 Aug 2001 19:20:53 -0400
Message-ID: <3B69DF99.B752AA5D@torque.net>
Date: Thu, 02 Aug 2001 19:17:45 -0400
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Richard Gooch <rgooch@ras.ucalgary.ca>, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [RFT] Support for ~2144 SCSI discs
In-Reply-To: <E15SKRV-0000tY-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > > kmalloc with GFP_KERNEL has a 128K limit which avoids the bizarre
> > > behaviour you get when you abuse get_free_pages.
> >
> > Last I heard, get_free_pages() also has a 128 kiB limit. So what's the
> > difference?
> 
> get_free_pages doesnt have such a limit. Thats why sg had the problem it did

Alan,
That is incorrect.

The failure I got with the sg driver with cdrdao
and cdda2wav was with 32 KB buffers, lots of them.
cdda2wav in RH 7.1 was trying to get 100 MB of them!

If you look at the sg driver you will find that it never
attempts a get_free_pages greater than SG_SCATTER_SZ (32 KB).
So that unkillable lockup on those apps demonstrates
rather well that GFP_KERNEL is dangerous.

Doug Gilbert
