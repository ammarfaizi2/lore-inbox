Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281847AbRK1BbV>; Tue, 27 Nov 2001 20:31:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283002AbRK1BbL>; Tue, 27 Nov 2001 20:31:11 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:9088 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S281857AbRK1Ba5>; Tue, 27 Nov 2001 20:30:57 -0500
Date: Tue, 27 Nov 2001 18:34:18 -0700
From: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
        jmerkey@timpanogas.org
Subject: Block I/O Enchancements, 2.5.1-pre2
Message-ID: <20011127183418.A812@vger.timpanogas.org>
In-Reply-To: <15364.3457.368582.994067@gargle.gargle.HOWL> <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0111271701140.1629-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Nov 27, 2001 at 05:04:46PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 05:04:46PM -0800, Linus Torvalds wrote:
> 
> On Wed, 28 Nov 2001, Paul Mackerras wrote:
> >
> > Is there a description of the new block layer and its interface to
> > block device drivers somewhere?  That would be helpful, since Ben
> > Herrenschmidt and I are going to have to convert several
> > powermac-specific drivers.
> 
> Jens has something written up, which he sent to me as an introduction to
> the patch. I'll send that out unless he does a cleaned-up version, but I'd
> actually prefer for him to do the sending. Jens?
> 
> 		Linus
> 


Linus/Jens,

I've just completed my review of submit_bio and the changes to 
generic_make_request and I have some questions for whomever
can answer.

1.  The changes made to submit_bh indicate I can now send long 
chains of variable block size requests to the I/O layer similiar
to the capability of Windows 2000 and NetWare I/O subsystems.

2.  The elevator layer is merging these requests, and making a 
single sweep request for contiguous sector runs.

3.  In theory, I should be able to support page cache capability
for NWFS and possibly NTFS in Linux the way these wierd non-Unix 
OS's work.

4.  This interface may **NOT** support non-block aligned requests
across all the drivers.  I also need to be able to submit a 
request chain 512-2048-512-1024-4096 where the first IO requested
may by on a non-block aligned boundry.  i.e.  Device is configured
for 1024 byte blocks, I start the request as 512 @ LBA 1 -> 1024 @ LBA 2, 
etc.  The code looks like it will work.

I would love to test this wonderful code and will hopefully this evening,
however, all the SCSI drivers appear to be broken, as well as the 
3Ware. :-)

Please advise,

Jeff




> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
