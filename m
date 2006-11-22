Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161748AbWKVFRt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161748AbWKVFRt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Nov 2006 00:17:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756775AbWKVFRt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Nov 2006 00:17:49 -0500
Received: from mo32.po.2iij.net ([210.128.50.17]:24640 "EHLO mo32.po.2iij.net")
	by vger.kernel.org with ESMTP id S1756795AbWKVFRs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Nov 2006 00:17:48 -0500
Message-Id: <200611220517.kAM5HXmQ033171@mbox31.po.2iij.net>
Date: Wed, 22 Nov 2006 14:17:33 +0900
From: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
To: Andrew Morton <akpm@osdl.org>
Cc: yoichi_yuasa@tripeaks.co.jp, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add return value checking of get_user() in
 set_vesa_blanking()
In-Reply-To: <20061121173115.6d258a5a.akpm@osdl.org>
References: <20061121141528.234a9335.yoichi_yuasa@tripeaks.co.jp>
	<20061121173115.6d258a5a.akpm@osdl.org>
Organization: TriPeaks Corporation
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Nov 2006 17:31:15 -0800
Andrew Morton <akpm@osdl.org> wrote:

> On Tue, 21 Nov 2006 14:15:28 +0900
> Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> wrote:
> 
> > Hi,
> > 
> > This patch has added return value checking of get_user() in set_vesa_blanking().
> > 
> > Yoichi
> > 
> > Signed-off-by: Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>
> >  
> > diff -pruN -X generic/Documentation/dontdiff generic-orig/drivers/char/vt.c generic/drivers/char/vt.c
> > --- generic-orig/drivers/char/vt.c	2006-11-21 10:23:39.409667250 +0900
> > +++ generic/drivers/char/vt.c	2006-11-21 10:11:48.037209250 +0900
> > @@ -3318,9 +3318,10 @@ postcore_initcall(vtconsole_class_init);
> >  
> >  static void set_vesa_blanking(char __user *p)
> >  {
> > -    unsigned int mode;
> > -    get_user(mode, p + 1);
> > -    vesa_blank_mode = (mode < 4) ? mode : 0;
> > +	unsigned int mode;
> > +
> > +	if (!get_user(mode, p + 1))
> > +		vesa_blank_mode = (mode < 4) ? mode : 0;
> >  }
> >  
> >  void do_blank_screen(int entering_gfx)
> 
> How about we go all the way?

It's good for us.

Thanks,

Yoichi
