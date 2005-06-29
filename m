Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262240AbVF2EVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262240AbVF2EVQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 00:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVF2EVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 00:21:16 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:48522 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262240AbVF2EVA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 00:21:00 -0400
Subject: Re: [PATCH 2/3] freevxfs: minor cleanups
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20050628163114.6594e1e1.akpm@osdl.org>
References: <iit0gm.lxobpl.5z2b9jduhy9fvx6tjxrco46v4.refire@cs.helsinki.fi>
	 <iit0h1.q7pnex.bkir3xysppdufw6d9h65boz37.refire@cs.helsinki.fi>
	 <20050628163114.6594e1e1.akpm@osdl.org>
Date: Wed, 29 Jun 2005 07:20:21 +0300
Message-Id: <1120018821.9658.4.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution 2.2.1.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2005-06-28 at 16:31 -0700, Andrew Morton wrote:
> That struct initialisation:
> 
> > +	*infp = (struct vxfs_sb_info) {
> > +		.vsi_raw = rsbp,
> > +		.vsi_bp = bp,
> > +		.vsi_oltext = rsbp->vs_oltext[0],
> > +		.vsi_oltsize = rsbp->vs_oltsize,
> > +	};
> 
> Is a bit unconventional, but it doesn't alter the size of the .o file, so
> whatever.

The rationale for this is that since NULL is not guaranteed to be zero
by the C standard, memset() doesn't really initialize pointers properly.
The above does. This came up when I wanted to replace explicit NULL
assignments from the NTFS code with kcalloc() and the maintainer
refused. Al Viro suggested the above form and was accepted by the NTFS
maintainer as well.

			Pekka

