Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264692AbRFXVCE>; Sun, 24 Jun 2001 17:02:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264709AbRFXVBz>; Sun, 24 Jun 2001 17:01:55 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:9831
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S264692AbRFXVBf>; Sun, 24 Jun 2001 17:01:35 -0400
Date: Sun, 24 Jun 2001 23:01:26 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Eric Lammerts <eric@lammerts.org>
Cc: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        linux-kernel@vger.kernel.org, dhinds@zen.stanford.edu
Subject: Re: [PATCH] add kmalloc check in drviers/pcmcia/rsrc_mgr.c (245-ac16)
Message-ID: <20010624230126.F847@jaquet.dk>
In-Reply-To: <20010624214635.C847@jaquet.dk> <Pine.LNX.4.33.0106242243170.3024-100000@ally.lammerts.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0106242243170.3024-100000@ally.lammerts.org>; from eric@lammerts.org on Sun, Jun 24, 2001 at 10:52:31PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 24, 2001 at 10:52:31PM +0200, Eric Lammerts wrote:
[...] 
> There are zillions of functions called 'init_module' in the kernel.
> I think my suggestion was better (and it had a \n at the end!)

Agreed. Actually, 'ouch' on point two :) BTW, was it intentional
that you dropped the maintainer from the recipient-list back then?

--- linux-245-ac16-clean/drivers/pcmcia/rsrc_mgr.c      Sat May 19 20:59:21 2001+++ linux-245-ac16/drivers/pcmcia/rsrc_mgr.c    Sat Jun 23 15:06:54 2001
@@ -189,6 +189,11 @@
     
     /* First, what does a floating port look like? */
     b = kmalloc(256, GFP_KERNEL);
+    if (!b) {
+       printk(" -- aborting.\n");
+       printk(KERN_ERR "rsrc_mgr: Out of memory.\n");
+       return;
+    }
     memset(b, 0, 256);
     for (i = base, most = 0; i < base+num; i += 8) {
        if (check_io_resource(i, 8))
-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

You know how dumb the average guy is?  Well, by  definition, half
of them are even dumber than that.
            -- J.R. "Bob" Dobbs 
