Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263036AbTDFROW (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 13:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263037AbTDFROW (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 13:14:22 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:62350
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S263036AbTDFROV (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 13:14:21 -0400
Subject: Re: [PATCH] take 48-bit lba a bit further
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Petr Vandrovec <vandrove@vc.cvut.cz>
Cc: Jens Axboe <axboe@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030406164306.GC8303@vana.vc.cvut.cz>
References: <20030406130737.GL786@suse.de>
	 <20030406164306.GC8303@vana.vc.cvut.cz>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049646450.1349.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Apr 2003 17:27:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-04-06 at 17:43, Petr Vandrovec wrote:
> > Works perfectly in testing here, ext2/3 generates nice big 512KiB
> > requests and the drive flies.
> > 
> >  	(void) probe_lba_addressing(drive, 1);
> >  
> > +	if (drive->addressing)
> > +		blk_queue_max_sectors(&drive->queue, 1024);
> > +
> 
> Should not you honor host's max queue length? siimage & pdc4030 sets
> max_sectors to 128 (resp. 16 resp. 127), while you overwrite it here
> unconditionally with 1024.

For production code thats required. The actual change required is to
clamp the default/hwif set queue limit to 256 if driver->addressing !=1

