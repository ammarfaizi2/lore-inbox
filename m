Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422663AbWI2UQK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422663AbWI2UQK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 16:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWI2UQK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 16:16:10 -0400
Received: from xenotime.net ([66.160.160.81]:61591 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S1422663AbWI2UQI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 16:16:08 -0400
Date: Fri, 29 Sep 2006 13:17:30 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Roger Gammans <roger@computer-surgery.co.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, axboe@kernel.dk
Subject: Re: fs/bio.c - Hardcoded sector size ?
Message-Id: <20060929131730.0b733137.rdunlap@xenotime.net>
In-Reply-To: <20060928195627.GD4759@julia.computer-surgery.co.uk>
References: <20060928182238.GA4759@julia.computer-surgery.co.uk>
	<20060929113814.db87b8d5.rdunlap@xenotime.net>
	<20060928185820.GB4759@julia.computer-surgery.co.uk>
	<20060929121157.0258883f.rdunlap@xenotime.net>
	<20060928191946.GC4759@julia.computer-surgery.co.uk>
	<20060929123737.ec613178.rdunlap@xenotime.net>
	<20060928195627.GD4759@julia.computer-surgery.co.uk>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006 20:56:27 +0100 Roger Gammans wrote:

> On Fri, Sep 29, 2006 at 12:37:37PM -0700, Randy Dunlap wrote:
> > Hm, I looked thru fs/bio.c and block/*.c and Documentation/Docbook/*.tmpl.
> > The best place that I see to put it right now is in
> > include/linux/bio.h, struct bio, field: bi_sector.
> > 
> > What do you think of that?
> 
> Well, ... Um. I can't think of anywhere better either, so how about
> this:-
> 
> Signed-Off-By: Roger Gammans <rgammans@computer-sugery.co.uk>


Looks OK to me.  I would probably go for something a little
stronger, though, like:

	sector_t		bi_sector;	/* block layer sector
						 * addresses are always in
						 * 512-byte units in Linux */

Jens, is something like this (above or below) OK with you?


> diff --git a/include/linux/bio.h b/include/linux/bio.h
> index 76bdaea..77a8e6b 100644
> --- a/include/linux/bio.h
> +++ b/include/linux/bio.h
> @@ -70,7 +70,8 @@ typedef void (bio_destructor_t) (struct
>   * stacking drivers)
>   */
>  struct bio {
> -       sector_t                bi_sector;
> +       sector_t                bi_sector;      /* device address in 512 byte
> +                                                  sectors */
>         struct bio              *bi_next;       /* request queue link */
>         struct block_device     *bi_bdev;
>         unsigned long           bi_flags;       /* status, command, etc
> */


---
~Randy
