Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316582AbSFDIyf>; Tue, 4 Jun 2002 04:54:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316584AbSFDIye>; Tue, 4 Jun 2002 04:54:34 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:56848 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S316582AbSFDIyd>; Tue, 4 Jun 2002 04:54:33 -0400
Date: Tue, 4 Jun 2002 09:54:27 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Jens Axboe <axboe@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
        linux-kernel@vger.kernel.org
Subject: Re: PATCH/RFC: fix 2.5.20 ramdisk
Message-ID: <20020604095427.B30552@flint.arm.linux.org.uk>
In-Reply-To: <20020603180627.A23056@flint.arm.linux.org.uk> <20020604083525.GA2512@suse.de> <20020604094532.A30552@flint.arm.linux.org.uk> <3CFC7226.2010101@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 04, 2002 at 09:54:14AM +0200, Martin Dalecki wrote:
> > --- orig/drivers/block/rd.c	Wed May 29 21:40:26 2002
> > +++ linux/drivers/block/rd.c	Tue Jun  4 09:44:21 2002
> > @@ -144,6 +144,7 @@
> >  {
> >  	struct address_space * mapping;
> >  	unsigned long index;
> > +	unsigned int vec_offset;
> 
> Just a small nit. Shouldn't taht be size_t ?

I really don't see where you got that thought from.  A bio_vec is:

struct bio_vec {
        struct page     *bv_page;
        unsigned int    bv_len;
        unsigned int    bv_offset;
};

bv_offset is unsigned int.  Therefore, vec_offset should be likewise.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

