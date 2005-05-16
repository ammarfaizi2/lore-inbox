Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261930AbVEPV7B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbVEPV7B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261902AbVEPV6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:58:54 -0400
Received: from hermine.aitel.hist.no ([158.38.50.15]:3850 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S261908AbVEPV4t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:56:49 -0400
Date: Tue, 17 May 2005 00:01:56 +0200
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext2 optimal partition size
Message-ID: <20050516220156.GA8032@hh.idb.hist.no>
References: <20050515160037.GE134@DervishD> <20050515164307.GB26197@hh.idb.hist.no> <20050515171437.GC248@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050515171437.GC248@DervishD>
User-Agent: Mutt/1.5.9i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 15, 2005 at 07:14:37PM +0200, DervishD wrote:
>     Hi Helge :)
> 
>     That's was just an example, and anyway I can create an ext2/3
> filesystem on a file.

Sure.  It won't be a "partition" though.
>  
> > Just make sure your partition is a whole number of blocks,
> > ext2/ext3 should then be able to utilize the partition fully to the
> > last block.
> 
>     Do that means that metadata (disk structures, block groups
> structs and the like) all fits in block-size chunks???

fs-blocksize chunks, yes.  (i.e. 1K or 4K blocks, not the
512 byte disk blocks.)

I don't know if aøll metadata fits iarbitrary number of block-sized chunks, 
but that cannot matter.  Any "extra" block can surely be utilized for
file data.


>  
> > Using a blocksize equal to the pagesize (i.e. 4096) is usually optimal.
> 
>     Thanks, I'll try it :) My main doubt was if the metadata was
> managed in block-sized chunks, it seems so.

Managing everything in block-sized chunks is a common design in unix filesystems.
It avoids many problems and allows arbitrary filesystem sizes.
Of course some structures will need quite a few blocks, but the number
of blocks will depend on the size of the filesystem and will therefore
always fit in the available space.  (Well, unless you try creating
something silly like a 1-block fs. :-)

Helge Hafting
