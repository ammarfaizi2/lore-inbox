Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267248AbRGPI4o>; Mon, 16 Jul 2001 04:56:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267255AbRGPI4e>; Mon, 16 Jul 2001 04:56:34 -0400
Received: from weta.f00f.org ([203.167.249.89]:17796 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267248AbRGPI41>;
	Mon, 16 Jul 2001 04:56:27 -0400
Date: Mon, 16 Jul 2001 20:56:33 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: Jonathan Lundell <jlundell@pobox.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Andrew Morton <andrewm@uow.edu.au>,
        Andreas Dilger <adilger@turbolinux.com>,
        "Albert D. Cahalan" <acahalan@cs.uml.edu>,
        Ben LaHaise <bcrl@redhat.com>,
        Ragnar Kjxrstad <kernel@ragnark.vestdata.no>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mike@bigstorage.com, kevin@bigstorage.com, linux-lvm@sistina.com
Subject: Re: [PATCH] 64 bit scsi read/write
Message-ID: <20010716205633.G11938@weta.f00f.org>
In-Reply-To: <200107151747.f6FHlAU60256@aslan.scsiguy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107151747.f6FHlAU60256@aslan.scsiguy.com>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 15, 2001 at 11:47:10AM -0600, Justin T. Gibbs wrote:

    Simply disabling the write cache does not guarantee the order of
    writes.  For one, with tagged I/O and the use of the SIMPLE_Q tag
    qualifier, commands may be completed in any order.  If you want
    some semblance of order, either disable the write cache or use the
    FUA bit in all writes, and use the ORDERED tag qualifier.  Even
    when using these options, it is not clear that the drive cannot
    reorder writes "slightly" to make track writes more efficient
    (e.g. two separate commands to write sequential sectors on the
    same track may be written in reverse order).

ORDERED sounds like the trick...  I assume this is some kind of
write-barrier? If so, then I assume it has some kind of strict
temporal ordering, even between command issues to the drive.

If so, that would be idea if we can have the fs communicate this all
the way down to the device layer, making it work for soft-raid and LVM
be a little harder perhaps.



  --cw
