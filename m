Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWGTRZz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWGTRZz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jul 2006 13:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750798AbWGTRZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jul 2006 13:25:55 -0400
Received: from outmx026.isp.belgacom.be ([195.238.4.91]:64449 "EHLO
	outmx026.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S1750793AbWGTRZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jul 2006 13:25:54 -0400
Subject: Re: [PATCH] drivers: Conversions from kmalloc+memset to
	k(z|c)alloc.
From: Panagiotis Issaris <takis@gna.org>
To: "Daniel K." <daniel@cluded.net>
Cc: Panagiotis Issaris <takis@lumumba.uhasselt.be>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       chas@cmf.nrl.navy.mil, miquel@df.uba.ar, kkeil@suse.de,
       benh@kernel.crashing.org, video4linux-list@redhat.com,
       rmk+mmc@arm.linux.org.uk, Neela.Kolli@engenio.com, jgarzik@pobox.com,
       vandrove@vc.cvut.cz, adaplas@pol.net, thomas@winischhofer.net,
       weissg@vienna.at, philb@gnu.org, linux-pcmcia@lists.infradead.org,
       jkmaline@cc.hut.fi, paulus@samba.org
In-Reply-To: <44BD9BA8.7070202@cluded.net>
References: <20060719004659.GA30823@lumumba.uhasselt.be>
	 <44BD9BA8.7070202@cluded.net>
Content-Type: text/plain
Date: Thu, 20 Jul 2006 19:25:16 +0200
Message-Id: <1153416317.11873.22.camel@hemera>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On wo, 2006-07-19 at 02:40 +0000, Daniel K. wrote:
> > [...] 
> > diff --git a/drivers/char/rio/riocmd.c b/drivers/char/rio/riocmd.c
> > index 4df6ab2..593940f 100644
> > --- a/drivers/char/rio/riocmd.c
> > +++ b/drivers/char/rio/riocmd.c
> > @@ -556,9 +556,7 @@ struct CmdBlk *RIOGetCmdBlk(void)
> >  {
> >  	struct CmdBlk *CmdBlkP;
> >  
> > -	CmdBlkP = (struct CmdBlk *)kmalloc(sizeof(struct CmdBlk), GFP_ATOMIC);
> > -	if (CmdBlkP)
> > -		memset(CmdBlkP, 0, sizeof(struct CmdBlk));
> > +	CmdBlkP = kzalloc(sizeof(struct CmdBlk), GFP_ATOMIC);
> >  	return CmdBlkP;
> >  }
> >  
> 
> Why not return kzalloc(...) here? Alternatively, return (type *) kzalloc(...),
> if you believe in explicit type casting of void pointers.
I figured someone might want to add extra code in f.e. RIOGetCmddBlk to
be able to debug/modify memory allocation behavior for the RIO driver
only. It does look a bit messy though. So I've updated it in my updated
patch.

Cheers,
Takis

