Return-Path: <linux-kernel-owner+w=401wt.eu-S932292AbXAPCQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbXAPCQa (ORCPT <rfc822;w@1wt.eu>);
	Mon, 15 Jan 2007 21:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbXAPCQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Jan 2007 21:16:29 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:50676 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932273AbXAPCQ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Jan 2007 21:16:27 -0500
Date: Tue, 16 Jan 2007 02:14:38 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Nate Diller <nate@agami.com>
Cc: Nate Diller <nate.diller@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Alexander Viro <viro@zeniv.linux.org.uk>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       Kenneth W Chen <kenneth.w.chen@intel.com>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, netdev@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, linux-aio@kvack.org,
       xfs-masters@oss.sgi.com
Subject: Re: [PATCH -mm 3/10][RFC] aio: use iov_length instead of ki_left
Message-ID: <20070116021438.GA15774@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Nate Diller <nate@agami.com>, Nate Diller <nate.diller@gmail.com>,
	Andrew Morton <akpm@osdl.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Benjamin LaHaise <bcrl@kvack.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Suparna Bhattacharya <suparna@in.ibm.com>,
	Kenneth W Chen <kenneth.w.chen@intel.com>,
	David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	netdev@vger.kernel.org, ocfs2-devel@oss.oracle.com,
	linux-aio@kvack.org, xfs-masters@oss.sgi.com
References: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com> <20070116015450.9764.52713.patchbomb.py@nate-64.agami.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070116015450.9764.52713.patchbomb.py@nate-64.agami.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 15, 2007 at 05:54:50PM -0800, Nate Diller wrote:
> Convert code using iocb->ki_left to use the more generic iov_length() call. 

No way.  We need to reduce the numer of iovec traversals, not adding
more of them.

