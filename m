Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263714AbUESAgi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263714AbUESAgi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 20:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263725AbUESAgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 20:36:38 -0400
Received: from fw.osdl.org ([65.172.181.6]:57286 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263714AbUESAgb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 20:36:31 -0400
Date: Tue, 18 May 2004 17:38:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Simmons <jsimmons@infradead.org>
Cc: VANDROVE@vc.cvut.cz, vince@kyllikki.org,
       linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: vga16fb broke
Message-Id: <20040518173845.1e03288c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0405190117430.16503-100000@phoenix.infradead.org>
References: <20040518171612.516ad43c.akpm@osdl.org>
	<Pine.LNX.4.44.0405190117430.16503-100000@phoenix.infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Simmons <jsimmons@infradead.org> wrote:
>
> 
> > I have pondered your email at length and have failed to understand it.
> > 
> > I _think_ you're saying that we need to do this, which will fix x86:
> > 
> > --- 25/drivers/video/vga16fb.c~vga16fb-fix	Tue May 18 17:10:14 2004
> > +++ 25-akpm/drivers/video/vga16fb.c	Tue May 18 17:10:39 2004
> > @@ -1347,7 +1347,7 @@ int __init vga16fb_init(void)
> >  
> >  	/* XXX share VGA_FB_PHYS and I/O region with vgacon and others */
> >  
> > -	vga16fb.screen_base = ioremap(VGA_MAP_MEM(VGA_FB_PHYS), VGA_FB_PHYS_LEN);
> > +	vga16fb.screen_base = VGA_MAP_MEM(VGA_FB_PHYS);
> >  	if (!vga16fb.screen_base) {
> >  		printk(KERN_ERR "vga16fb: unable to map device\n");
> >  		ret = -ENOMEM;
> 
> This will make the driver on all platforms. 

There's a missing word in that sentence.  Was it "work" or "crash"?  This
matters ;)

> _
> > 
> > and that ARM and others need to teach their VGA_MAP_MEM() to do an internal
> > ioremap().
> > 
> > Or do you mean something else?  Please be more clear?
> 
> I like to see the VGA_MAP_MEM hack go away and be replaced with ioremap.

If you can cut a patch we can ask arch maintainers to review and test it.
