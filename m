Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263700AbTDTVOH (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263704AbTDTVOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:14:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:2200 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263700AbTDTVOF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:14:05 -0400
Date: Sun, 20 Apr 2003 22:26:07 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Andries.Brouwer@cwi.nl
Cc: aebr@win.tue.nl, linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [CFT] more kdev_t-ectomy
Message-ID: <20030420212607.GJ10374@parcelfarce.linux.theplanet.co.uk>
References: <UTC200304202117.h3KLHH217162.aeb@smtp.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <UTC200304202117.h3KLHH217162.aeb@smtp.cwi.nl>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 20, 2003 at 11:17:17PM +0200, Andries.Brouwer@cwi.nl wrote:
 
> Given a number, one can copy it around freely, without the need
> to obtain a reference each time one copies it.
> Many of these numbers are just copied around and never used.
> In such a case, refcounting is a real waste of time.

Excuse me, but "copied around and never used" is by definition a real
waste of time.  And proper fix is neither "keep it" nor "replace with
pointer".  It's "kill it".

>     By now all uses of mk_kdev()/major()/minor()/MAJOR()/MINOR() in the drivers
>     are either trivially removable or represent very real problems.  And it's
>     not that there was a lot of them - in my current tree there's ~85 instances
>     of kdev_t in the source.  And only one of them (->i_rdev) is widely used -
>     ~500 instances, most of them go away as soon as CIDR patch gets merged.
>     The rest is part noise, part real bugs that need to be fixed anyway
>     (~40--80 of those).
> 
> Yes, I tend to agree. Funny that you do not mention MKDEV - that was
> the thing I worked on eliminating long ago.

No, I do not mention it.  And for a good reason.  It's the only constructor
for constant values of dev_t.  You could keep every such value in two
fields, but then you get all their uses go in pairs and starting with
MKDEV().  Or have lookup code play with MAJOR()/MINOR() for no good
reason whatsoever.

MKDEV(<constant>,<constant>) is a valid thing, as far as I'm concerned.
