Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262987AbTDIKMm (for <rfc822;willy@w.ods.org>); Wed, 9 Apr 2003 06:12:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262988AbTDIKMm (for <rfc822;linux-kernel-outgoing>); Wed, 9 Apr 2003 06:12:42 -0400
Received: from mail.zmailer.org ([62.240.94.4]:27012 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id S262987AbTDIKMk (for <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Apr 2003 06:12:40 -0400
Date: Wed, 9 Apr 2003 13:24:17 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Oliver Neukum <oliver@neukum.name>
Cc: Frank Davis <fdavis@si.rr.com>, linux-kernel@vger.kernel.org
Subject: Re: kernel support for non-english user messages
Message-ID: <20030409102417.GE29167@mea-ext.zmailer.org>
References: <3E93A958.80107@si.rr.com> <20030409080803.GC29167@mea-ext.zmailer.org> <200304091133.40974.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304091133.40974.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 09, 2003 at 11:33:40AM +0200, Oliver Neukum wrote:
> > To propagate the idea further, why not have proper message catalogs,
> >
> > and that way translations.  Instead of:
> > > printk(KERN_WARN "This driver is messed up!\n");
> >
> > There would be:
> >   printk(KERN_WARN "1234-6789 this driver is messed up!\n")
> >
> > In the old days of big iron beasts, there used to be multivolume
> > binders full of system messages, and their explanations.
> > Searching went thru those "1234-5678" strings.
> >
> > There were sets of those manuals in a number of customer languages.
> 
> If we do this, why not go the whole way?
> Could we compute a hash value for every message that's not KERN_CRIT,
> use it to create a table of messages and hashes and replace the messages
> in the kernel image with the hash values leaving expansion to klogd?

  Because hashes  1) change at slightest text changes,  2)  are quite 
  meaningless when a message gets some inserted material, like 
  numbers in them.

  In the big-iron era the messages had 32 ot 64 bit numeric identities
  (or 36 bit in such machines), and were allocated number-spaced by
  each subsystem/product.  E.g.  Assembler had codes 3AFB-**** thru
  3AFF-****,  etc.

  VMS has a bit different style, but how it does exactly do it, I don't
  recall for sure.   %Subsysid-severity-msgid   (or something like that.)

  Presently Linux kernel has just the <severity> code.  Mostly subsysid
  is "kernel", although that could be divided further, so that msgid does
  not need to carry that info, e.g. "kernel-crit-ext3fs_inode_corruption_7"
  instead: "ext3fs-crit-inode_corruption_7"  (or alike).
  The amount of text is .. considerable .. in that kind of styles.

  With:

    printk(msgidcode, KERN_CRIT "mumblemumble", params)

  produced load-time footprint is reduced somewhat.

  Could that come out as:

     <6-MSGID-CODE> mumblemumble...

  Perhaps.  (16+16 bits hex coded should be quite sufficient.
  If some kernel subsystem has over 64 000 messages, things
  are quite bad...)

  Folks at IBM do know how to do things like this.



  Mind you, this WILL NOT help something like  klogd  to translate
  received messages into language XYZ,  merely help administrator
  to find further explanations.

> 	Regards
> 		Oliver

/Matti Aarnio
