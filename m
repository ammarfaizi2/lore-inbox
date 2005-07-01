Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263314AbVGANH6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263314AbVGANH6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 09:07:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263333AbVGANH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 09:07:57 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:7664 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263314AbVGANH2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 09:07:28 -0400
From: Kevin Corry <kevcorry@us.ibm.com>
Organization: IBM
To: Andrew Morton <akpm@osdl.org>, zhaoqian@aaastor.com
Subject: Re: [PATCH] device-mapper: dm-raid1: Limit bios to size of mirror region
Date: Fri, 1 Jul 2005 07:56:35 -0500
User-Agent: KMail/1.8
Cc: Alasdair G Kergon <agk@redhat.com>, linux-kernel@vger.kernel.org
References: <20050630181931.GL4211@agk.surrey.redhat.com> <20050701002626.630c2b7d.akpm@osdl.org>
In-Reply-To: <20050701002626.630c2b7d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507010756.36015.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri July 1 2005 2:26 am, Andrew Morton wrote:
> Alasdair G Kergon <agk@redhat.com> wrote:
> > --- diff/drivers/md/dm-raid1.c 2005-06-17 20:48:29.000000000 +0100
> > +++ source/drivers/md/dm-raid1.c 2005-06-29 21:12:13.000000000 +0100
> > @@ -1060,6 +1060,7 @@
> >   }
> >
> >   ti->private = ms;
> > +  ti->split_io = ms->rh->region_size;
> >
> >   r = kcopyd_client_create(DM_IO_PAGES, &ms->kcopyd_client);
> >   if (r) {
>
> Ahem.
>
> drivers/md/dm-raid1.c: In function `mirror_ctr':
> drivers/md/dm-raid1.c:1072: invalid type argument of `->'
>
> ---
> devel/drivers/md/dm-raid1.c~device-mapper-dm-raid1-limit-bios-to-size-of-mi
>rror-region-fix 2005-07-01 00:25:26.000000000 -0700 +++
> devel-akpm/drivers/md/dm-raid1.c 2005-07-01 00:25:26.000000000 -0700 @@
> -1060,7 +1060,7 @@ static int mirror_ctr(struct dm_target *
>   }
>
>   ti->private = ms;
> -  ti->split_io = ms->rh->region_size;
> +  ti->split_io = ms->rh.region_size;
>
>   r = kcopyd_client_create(DM_IO_PAGES, &ms->kcopyd_client);
>   if (r) {
>
> How well tested was this?

Ehh...oops...sorry about that. :(

Zhao, you reported this issue originally. Have you been able to test this yet 
to see if it fixes the corruption problem you were describing? Or can you 
give us a test-case that I can run?

-- 
Kevin Corry
kevcorry@us.ibm.com
http://www.ibm.com/linux/
http://evms.sourceforge.net/
