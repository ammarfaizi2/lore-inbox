Return-Path: <linux-kernel-owner+w=401wt.eu-S932367AbXAPFhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbXAPFhf (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 00:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932374AbXAPFhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 00:37:35 -0500
Received: from nf-out-0910.google.com ([64.233.182.184]:20849 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932367AbXAPFhd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 00:37:33 -0500
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=UJupqkFauPJkx8COykslQ0InjLNSViPwi1qbse3bnhXA6Z//Yqq9AEBFGYVE5HHJnMCzPr6SMWib0f8iP9u4i868C9xxui5uBJaF7ACChqBLz10LSMbds+b6bZq+yd2ZA6+PBm7Vewl3L4IOzKkuMD35Pomuv5eFA9JrvEMgvwY=
Message-ID: <5c49b0ed0701152137s52e8f2c8sc93ea3a073e17e1c@mail.gmail.com>
Date: Mon, 15 Jan 2007 21:37:31 -0800
From: "Nate Diller" <nate.diller@gmail.com>
To: "Christoph Hellwig" <hch@infradead.org>, "Nate Diller" <nate@agami.com>,
       "Nate Diller" <nate.diller@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Trond Myklebust" <trond.myklebust@fys.uio.no>,
       "Benjamin LaHaise" <bcrl@kvack.org>,
       "Alexander Viro" <viro@zeniv.linux.org.uk>,
       "Suparna Bhattacharya" <suparna@in.ibm.com>,
       "Kenneth W Chen" <kenneth.w.chen@intel.com>,
       "David Brownell" <dbrownell@users.sourceforge.net>,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
Subject: Re: [PATCH -mm 3/10][RFC] aio: use iov_length instead of ki_left
In-Reply-To: <20070116021438.GA15774@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com>
	 <20070116015450.9764.52713.patchbomb.py@nate-64.agami.com>
	 <20070116021438.GA15774@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/15/07, Christoph Hellwig <hch@infradead.org> wrote:
> On Mon, Jan 15, 2007 at 05:54:50PM -0800, Nate Diller wrote:
> > Convert code using iocb->ki_left to use the more generic iov_length() call.
>
> No way.  We need to reduce the numer of iovec traversals, not adding
> more of them.

ok, I can work on a version of this that uses struct iodesc.  Maybe
something like this?

struct iodesc {
        struct iovec *iov;
        unsigned long nr_segs;
        size_t nbytes;
};

I suppose it's worth doing the iodesc thing along with this patchset
anyway, since it'll avoid an extra round of interface churn.

NATE
