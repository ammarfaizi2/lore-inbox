Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261759AbTCZQUD>; Wed, 26 Mar 2003 11:20:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261762AbTCZQUD>; Wed, 26 Mar 2003 11:20:03 -0500
Received: from d12lmsgate-4.de.ibm.com ([194.196.100.237]:53475 "EHLO
	d12lmsgate-4.de.ibm.com") by vger.kernel.org with ESMTP
	id <S261759AbTCZQUC>; Wed, 26 Mar 2003 11:20:02 -0500
Importance: Normal
Sensitivity: 
Subject: Re: [PATCH] s390 update (4/9): common i/o layer update.
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF53EAB661.698F04AC-ONC1256CF5.0059F8AC@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Wed, 26 Mar 2003 17:27:23 +0100
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 26/03/2003 17:28:52
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > + typeof (chsc_area_ssd.response_block)
> > +       *ssd_res = &chsc_area_ssd.response_block;
>
> Yikes!  Please use the actual type here instead of typeof()
Trouble is that response_block is an anonymous structure. There
is not type...

> > + if (sch->lpm == 0)
> > +       return -ENODEV;
> > + else
> > +       return -EACCES;
>
> I'd write this as return (sch->lpm ? -EACCES : -ENODEV), but maybe I'm
> just too picky..
No, you are not. return (sch->lpm ? -EACCES : -ENODEV) is better.

> > - sch = kmalloc (sizeof (*sch), GFP_DMA);
> > + sch = kmalloc (sizeof (*sch), GFP_KERNEL | GFP_DMA);
>
> What about using GFP_KERNEL | __GFP_DMA instead?  This makes it
> more clear that it's just a qualifier.
Hmm, GFP_DMA and __GFP_DMA are equivalent. I don't quite see your
point here.

blue skies,
   Martin


