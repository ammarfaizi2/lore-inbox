Return-Path: <linux-kernel-owner+w=401wt.eu-S1751788AbXAPXgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbXAPXgb (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 18:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751931AbXAPXg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 18:36:28 -0500
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:34888 "EHLO
	smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877AbXAPXgY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 18:36:24 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Nate Diller" <nate.diller@gmail.com>
Subject: Re: [PATCH -mm 3/10][RFC] aio: use iov_length instead of ki_left
Date: Wed, 17 Jan 2007 00:36:07 +0100
User-Agent: KMail/1.9.5
Cc: "Christoph Hellwig" <hch@infradead.org>, "Nate Diller" <nate@agami.com>,
       "Andrew Morton" <akpm@osdl.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       "Benjamin LaHaise" <bcrl@kvack.org>,
       "Alexander Viro" <viro@zeniv.linux.org.uk>,
       "Suparna Bhattacharya" <suparna@in.ibm.com>,
       "Kenneth W Chen" <kenneth.w.chen@intel.com>,
       "David Brownell" <dbrownell@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
References: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com> <20070116021438.GA15774@infradead.org> <5c49b0ed0701152137s52e8f2c8sc93ea3a073e17e1c@mail.gmail.com>
In-Reply-To: <5c49b0ed0701152137s52e8f2c8sc93ea3a073e17e1c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701170036.12359.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 16. January 2007 06:37, Nate Diller wrote:
> On 1/15/07, Christoph Hellwig <hch@infradead.org> wrote:
> > On Mon, Jan 15, 2007 at 05:54:50PM -0800, Nate Diller wrote:
> > > Convert code using iocb->ki_left to use the more generic iov_length() call.
> >
> > No way.  We need to reduce the numer of iovec traversals, not adding
> > more of them.
> 
> ok, I can work on a version of this that uses struct iodesc.  Maybe
> something like this?
> 
> struct iodesc {
>         struct iovec *iov;
>         unsigned long nr_segs;
>         size_t nbytes;
> };
> 
> I suppose it's worth doing the iodesc thing along with this patchset
> anyway, since it'll avoid an extra round of interface churn.

What about this instead

struct iodesc {
	struct iovec *iov;
	unsigned long nr_segs;
	unsigned long seg_limit;
	size_t nr_bytes;
};

That will enable resizeable iodescs with partial completion state and
will enable successive filling of an iodesc with iovs.

This will be needed anyway. I built an complete short userspace 
module for that already. I can post and GPLv2 it somewhere, if people
are interested.

Regards

Ingo Oeser
