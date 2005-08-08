Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750795AbVHHKAp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750795AbVHHKAp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 06:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750800AbVHHKAp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 06:00:45 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:1409 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1750795AbVHHKAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 06:00:44 -0400
References: <20050802071828.GA11217@redhat.com>
            <84144f0205080223445375c907@mail.gmail.com>
            <20050808095747.GD13951@redhat.com>
In-Reply-To: <20050808095747.GD13951@redhat.com>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: David Teigland <teigland@redhat.com>
Cc: Pekka Enberg <penberg@gmail.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: GFS
Date: Mon, 08 Aug 2005 13:00:43 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42F72D4B.00006DE7@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Teigland writes:
> > > +static int ea_set_i(struct gfs2_inode *ip, struct gfs2_ea_request *er,
> > > +                 struct gfs2_ea_location *el)
> > > +{
> > > +     {
> > > +             struct ea_set es;
> > > +             int error;
> > > +
> > > +             memset(&es, 0, sizeof(struct ea_set));
> > > +             es.es_er = er;
> > > +             es.es_el = el;
> > > +
> > > +             error = ea_foreach(ip, ea_set_simple, &es);
> > > +             if (error > 0)
> > > +                     return 0;
> > > +             if (error)
> > > +                     return error;
> > > +     }
> > > +     {
> > > +             unsigned int blks = 2;
> > > +             if (!(ip->i_di.di_flags & GFS2_DIF_EA_INDIRECT))
> > > +                     blks++;
> > > +             if (GFS2_EAREQ_SIZE_STUFFED(er) > ip->i_sbd->sd_jbsize)
> > > +                     blks += DIV_RU(er->er_data_len,
> > > +                                    ip->i_sbd->sd_jbsize);
> > > +
> > > +             return ea_alloc_skeleton(ip, er, blks, ea_set_block, el);
> > > +     }
> > 
> > Please drop the extra braces. 
> 
> Here and elsewhere we try to keep unused stuff off the stack.  Are you
> suggesting that we're being overly cautious, or do you just dislike the
> way it looks?

The extra braces hurt readability. Please drop them or make them proper 
functions instead. 

And yes, I think you're hiding potential stack usage problems here. Small 
unused stuff on the stack don't matter and large ones should probably be 
kmalloc() anyway. 

               Pekka 

