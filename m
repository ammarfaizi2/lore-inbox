Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264821AbUEEW26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264821AbUEEW26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 18:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264824AbUEEW25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 18:28:57 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:26020 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264821AbUEEW24
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 18:28:56 -0400
Date: Wed, 5 May 2004 10:55:23 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Chris Wright <chrisw@osdl.org>
Cc: manfred@colorfullife.com, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] simplify mqueue_inode_info->messages allocation
Message-ID: <20040505135523.GC1418@logos.cnet>
References: <20040504174214.D21045@build.pdx.osdl.net> <20040504174713.E21045@build.pdx.osdl.net> <20040504180622.F21045@build.pdx.osdl.net> <20040504183722.H21045@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040504183722.H21045@build.pdx.osdl.net>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 04, 2004 at 06:37:22PM -0700, Chris Wright wrote:
> * Chris Wright (chrisw@osdl.org) wrote:
> > --- ./ipc/mqueue.c~single_alloc	2004-05-04 15:16:34.000000000 -0700
> > +++ ./ipc/mqueue.c~	2004-05-04 15:59:25.000000000 -0700
> 
> Ugh!  Andrew pointed out to me that this is crap.  Sorry about the added
> noise.  Here's a patch relative to a file that actually exists. 

While we're at it, in do_create:

        ret = vfs_create(dir->d_inode, dentry, mode, NULL);
        if (ret) {
                kfree(msgs);
                return ERR_PTR(ret);

The msgs pointer can be NULL. Isnt that going to BUG if so?

