Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270329AbTHJO16 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 10:27:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270420AbTHJO16
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 10:27:58 -0400
Received: from werbeagentur-aufwind.com ([217.160.128.76]:37529 "EHLO
	mail.werbeagentur-aufwind.com") by vger.kernel.org with ESMTP
	id S270329AbTHJO15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 10:27:57 -0400
Subject: Re: [PATCH] loop: fixing cryptoloop troubles.
From: Christophe Saout <christophe@saout.de>
To: Pascal Brisset <pascal.brisset-ml@wanadoo.fr>
Cc: Fruhwirth Clemens <clemens-dated-1061346967.29a4@endorphin.org>,
       linux-kernel@vger.kernel.org, mbligh@aracnet.com, kernel@gozer.org,
       axboe@suse.de
In-Reply-To: <20030810140912.6F7224007E9@mwinf0301.wanadoo.fr>
References: <20030810023606.GA15356@ghanima.endorphin.org>
	 <20030810140912.6F7224007E9@mwinf0301.wanadoo.fr>
Content-Type: text/plain
Message-Id: <1060525667.14835.4.camel@chtephan.cs.pocnet.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sun, 10 Aug 2003 16:27:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am So, 2003-08-10 um 16.10 schrieb Pascal Brisset:

> > In loop_transfer_bio the initial vector has been computed only once. For any
> > situation where more than one bio_vec is present the initial vector will be
> > wrong. Here is the trivial but important fix. 
> 
> Looks good, but:
> - I doubt this could explain the alteration pattern (1 byte every 512).
> - Corruption also occured with cipher_null (which ignores the IV).

I personally think that the only way to get things right is to do
encryption sector by sector (not bvec by bvec) since every sector can
have its own iv.

I've implemented a crypto target for device-mapper that does this and it
doesn't seem to suffer from these corruption problems:
http://marc.theaimsgroup.com/?l=linux-kernel&m=105967481007242&w=2 and a
slightly updated patch: http://www.saout.de/misc/dm-crypt.diff

Unfortunately I haven't got a single response. :(

Just got one person outside LKML to (successfully) test it.

Should I repost the patch (inline this time) with an additional [PATCH]
or am I being annoying? Joe Thornber (the dm maintainer) would like to
see this patch merged.

--
Christophe Saout <christophe@saout.de>
Please avoid sending me Word or PowerPoint attachments.
See http://www.fsf.org/philosophy/no-word-attachments.html

