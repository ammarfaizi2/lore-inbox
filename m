Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbTEAVWE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 17:22:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262697AbTEAVWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 17:22:04 -0400
Received: from gw.chygwyn.com ([62.172.158.50]:1808 "EHLO gw.chygwyn.com")
	by vger.kernel.org with ESMTP id S262696AbTEAVWD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 17:22:03 -0400
From: Steven Whitehouse <steve@gw.chygwyn.com>
Message-Id: <200305012135.WAA19582@gw.chygwyn.com>
Subject: Re: Remains of seq_file conversion for DECnet, plus fixes
To: hch@infradead.org (Christoph Hellwig)
Date: Thu, 1 May 2003 22:35:46 +0100 (BST)
Cc: davem@redhat.com (David S. Miller),
       linux-decnet-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <20030501215709.A28210@infradead.org> from "Christoph Hellwig" at May 01, 2003 09:57:09 PM
Organization: ChyGywn Limited
X-RegisteredOffice: 7, New Yatt Road, Witney, Oxfordshire. OX28 1NU England
X-RegisteredNumber: 03887683
Reply-To: Steve Whitehouse <Steve@ChyGwyn.com>
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> 
> On Thu, May 01, 2003 at 09:52:01PM +0100, Steven Whitehouse wrote:
> > --- linux-2.5.68-bk10/fs/seq_file.c	Sun Apr 20 03:27:58 2003
> > +++ linux/fs/seq_file.c	Mon Apr 21 14:40:35 2003
> > @@ -338,3 +338,13 @@
> >  	kfree(op);
> >  	return res;
> >  }
> > +
> > +int kfree_release(struct inode *inode, struct file *file)
> > +{
> > +	struct seq_file *seq = file->private_data;
> > +
> > +	kfree(seq->private);
> > +	seq->private = NULL;
> > +	return seq_release(inode, file);
> > +}
> 
> The name is a bit generic for an export function.  What about
> seq_release_kfree?
> 

Yes, I'd considered that and eventually settled for the non-prefixed version
since it followed the pattern set by single_release() which doesn't have
the seq_ prefix. I don't mind changing it though if the prefixed version is
preferred,

Steve.

