Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262120AbVBXKPY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262120AbVBXKPY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 05:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbVBXKOD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 05:14:03 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:53403 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262221AbVBXJ7M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 04:59:12 -0500
Subject: Re: [PATCH] CKRM: 4/10 CKRM: Full rcfs support
From: Arjan van de Ven <arjan@infradead.org>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
In-Reply-To: <E1D4FN0-0006v2-00@w-gerrit.beaverton.ibm.com>
References: <E1D4FN0-0006v2-00@w-gerrit.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 24 Feb 2005 10:59:01 +0100
Message-Id: <1109239142.6530.27.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-24 at 01:33 -0800, Gerrit Huizenga wrote:

> > > +	if (!access_ok(VERIFY_READ, buf, count))
> > > +		return -EFAULT;
> > > +	down(&(ri->vfs_inode.i_sem));
> > > +	optbuf = kmalloc(TARGET_MAX_INPUT_SIZE, GFP_KERNEL);
> > 
> > kmalloc with a lock held?  Is that a good idea?
> 
> Lock?  Or sema?  Sema should be okay here, right?

not if that semaphore can be grabbed from a file data write out path...

and the semaphore sounds VFS-ish so it sure makes me nervous.



