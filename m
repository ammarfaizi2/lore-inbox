Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263026AbSJWJIY>; Wed, 23 Oct 2002 05:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263035AbSJWJIY>; Wed, 23 Oct 2002 05:08:24 -0400
Received: from relay.muni.cz ([147.251.4.35]:18071 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id <S263026AbSJWJIX>;
	Wed, 23 Oct 2002 05:08:23 -0400
Date: Wed, 23 Oct 2002 11:13:54 +0200
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Christoph Hellwig <hch@infradead.org>, Andries Brouwer <aebr@win.tue.nl>,
       linux-kernel@vger.kernel.org, marcelo@conectiva.com.br
Subject: Re: 2.4.20-pre11 /proc/partitions read
Message-ID: <20021023111353.M20511@fi.muni.cz>
References: <20021022161957.N26402@fi.muni.cz> <20021022184034.GA26585@win.tue.nl> <20021022194514.B3867@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021022194514.B3867@infradead.org>; from hch@infradead.org on Tue, Oct 22, 2002 at 07:45:14PM +0100
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
: I rather suspect it's the following bug (introduce by me, but not
: depend on CONFIG_BLK_STATS):
: 
: --- 1.23/drivers/block/genhd.c	Wed Aug 21 10:03:48 2002
: +++ edited/drivers/block/genhd.c	Tue Oct 22 20:43:16 2002
: @@ -155,13 +155,14 @@
:  
:  #ifdef CONFIG_PROC_FS
:  /* iterator */
: -static void *part_start(struct seq_file *s, loff_t *pos)
: +static void *part_start(struct seq_file *s, loff_t *ppos)
:  {
:  	struct gendisk *gp;
: +	loff_t pos = *ppos;
:  
:  	read_lock(&gendisk_lock);
:  	for (gp = gendisk_head; gp; gp = gp->next)
: -		if (!*pos--)
: +		if (!pos--)
:  			return gp;
:  	return NULL;
:  }

	Yes, this patch fixes my problem. Thanks!

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
|-- If you start doing things because you hate others and want to screw  --|
|-- them over the end result is bad.   --Linus Torvalds to the BBC News  --|
