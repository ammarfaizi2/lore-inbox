Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266224AbUFPJrx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUFPJrx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 05:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266228AbUFPJrx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 05:47:53 -0400
Received: from mail.fh-wedel.de ([213.39.232.194]:58309 "EHLO mail.fh-wedel.de")
	by vger.kernel.org with ESMTP id S266224AbUFPJru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 05:47:50 -0400
Date: Wed, 16 Jun 2004 11:47:37 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Florian Schirmer <jolt@tuxbox.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>,
       B.Zolnierkiewicz@elka.pw.edu.pl, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [STACK] >3k call path in ide
Message-ID: <20040616094737.GA2548@wohnheim.fh-wedel.de>
References: <20040609122921.GG21168@wohnheim.fh-wedel.de> <20040615163445.6b886383.rddunlap@osdl.org> <200406160911.11985.jolt@tuxbox.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200406160911.11985.jolt@tuxbox.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 June 2004 09:11:11 +0200, Florian Schirmer wrote:
> 
> >  failed:
> >      ide_release(link);
> >      link->state &= ~DEV_CONFIG_PENDING;
> >
> > +    /* memory allocation errors */
> > +err_cisparse:
> > +    kfree(cfginfo);
> > +err_cfginfo:
> > +    kfree(def_cte);
> > +err_def_cte:
> > +    kfree(tbuf);
> > +err_tbuf:
> > +    printk(KERN_NOTICE "ide-cs: ide_config failed memory allocation\n");
> > +    goto failed;
> >  } /* ide_config */
> 
> Huh? This will either leak memory (non alloc error case) or deadlock (mem 
> alloc error case). I'm missing something?

Leak memory.  I also tend to depend on the fact that kfree(NULL) works
just fine:

err_kfree:
	kfree(cfginfo);
	kfree(def_cte);
	kfree(tbuf);
	printk(KERN_NOTICE "ide-cs: ide_config failed memory allocation\n");
	goto failed;

Makes the error path a little simpler.

Jörn

-- 
The strong give up and move away, while the weak give up and stay.
-- unknown
