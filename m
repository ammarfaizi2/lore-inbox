Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261718AbUENQm1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261718AbUENQm1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 12:42:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261706AbUENQmG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 12:42:06 -0400
Received: from mail-relay-2.tiscali.it ([212.123.84.92]:14506 "EHLO
	mail-relay-2.tiscali.i") by vger.kernel.org with ESMTP
	id S261718AbUENQlm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 12:41:42 -0400
Date: Fri, 14 May 2004 18:41:54 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [4KSTACK][2.6.6] Stack overflow in radeonfb
Message-ID: <20040514164154.GA3852@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
References: <20040513145640.GA3430@dreamland.darkstar.lan> <1084488901.3021.116.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1084488901.3021.116.camel@gaston>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Fri, May 14, 2004 at 08:55:02AM +1000, Benjamin Herrenschmidt ha scritto: 
> 
> > 
> > int radeonfb_set_par(struct fb_info *info)
> > {
> >         struct radeonfb_info *rinfo = info->par;
> >         struct fb_var_screeninfo *mode = &info->var;
> >         struct radeon_regs newmode;
> >         
> > struct radeon_regs is huge: 2356 bytes
> > Quick fix (I'll test ASAP):
> 
> Wow, this is evil indeed, I didn't expect that struct to be that big,
> but well... I did add a bunch of stuff to it lately.

There are 2 arrays at the end of the struct:

struct radeon_regs {
        ....
        u32             palette[256];
        u32             palette2[256];
};

they take 2KB alone and AFAICS they are not used anywhere. Maybe they
can be removed?

Luca
-- 
Home: http://kronoz.cjb.net
"Sei l'unica donna della mia vita".
(Adamo)
