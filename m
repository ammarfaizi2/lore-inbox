Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264432AbRFXTrL>; Sun, 24 Jun 2001 15:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264444AbRFXTq6>; Sun, 24 Jun 2001 15:46:58 -0400
Received: from 213.237.12.194.adsl.brh.worldonline.dk ([213.237.12.194]:60260
	"HELO firewall.jaquet.dk") by vger.kernel.org with SMTP
	id <S264432AbRFXTqq>; Sun, 24 Jun 2001 15:46:46 -0400
Date: Sun, 24 Jun 2001 21:46:35 +0200
From: Rasmus Andersen <rasmus@jaquet.dk>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>,
        Eric Lammerts <eric@lammerts.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add kmalloc check in drviers/pcmcia/rsrc_mgr.c (245-ac16)
Message-ID: <20010624214635.C847@jaquet.dk>
In-Reply-To: <20010623152202.B840@jaquet.dk> <Pine.LNX.4.33.0106231901560.7165-100000@ally.lammerts.org> <20010623143006.A7004@conectiva.com.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010623143006.A7004@conectiva.com.br>; from acme@conectiva.com.br on Sat, Jun 23, 2001 at 02:30:06PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 23, 2001 at 02:30:06PM -0300, Arnaldo Carvalho de Melo wrote:
[...] 
> printk(KERN_ERR __FUNCTION__ "Out of memory.");
> 
> Then if you move the code to other function or if you change the name of
> the function you don't have to go all over the code doing
> s/old_function_name/new_function_name/g

Excellent suggestion. How about this one:

--- linux-245-ac16-clean/drivers/pcmcia/rsrc_mgr.c      Sat May 19 20:59:21 2001+++ linux-245-ac16/drivers/pcmcia/rsrc_mgr.c    Sat Jun 23 15:06:54 2001
@@ -189,6 +189,11 @@

     /* First, what does a floating port look like? */
     b = kmalloc(256, GFP_KERNEL);
+    if (!b) {
+       printk(" -- aborting.\n");
+       printk(KERN_ERR __FUNCTION__ ": Out of memory.");
+       return;
+    }
     memset(b, 0, 256);
     for (i = base, most = 0; i < base+num; i += 8) {
        if (check_io_resource(i, 8))

-- 
Regards,
        Rasmus(rasmus@jaquet.dk)

You don't become a failure until you're satisfied with being one. 
  -- Anonymous
