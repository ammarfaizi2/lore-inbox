Return-Path: <linux-kernel-owner+w=401wt.eu-S932458AbXAPIWn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932458AbXAPIWn (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 03:22:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932462AbXAPIWn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 03:22:43 -0500
Received: from smtp113.sbc.mail.mud.yahoo.com ([68.142.198.212]:20553 "HELO
	smtp113.sbc.mail.mud.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S932459AbXAPIWl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 03:22:41 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=IpX0h/9o5TvJ+2OlUQ2LNbDQHO9OJfIZ4RcmfD0LmKST/XfL36PMJiqA/EEjmarAxT8RKsJ7YIW0nSD4NDbItzhBch3raL5Gtx53eW7ZrXjP7BXyDhLeKDijq0HHcMxpkZNzmIH5ioZU498FLfxFfwYt/2UU/xXI4Hy+Q2EWPDg=  ;
X-YMail-OSG: b4my3GwVM1mAXIKOPazrP3A3XRaw2f8hAQHARFKPPAo9o7vwcqGzY.c770g82_VhDOoH2BSSLZ0mQoDiUiPPi06hOu6xpHYsVgsNVg_cSSDdXortCY5QJvbecvwdFWkWawrhbA8HnJD7OC2.GutiYaKkFIv0uALWYVSfO5fYN3GO7eyH_HqQdy3fCEFX
From: David Brownell <david-b@pacbell.net>
To: Nate Diller <nate.diller@gmail.com>
Subject: Re: [PATCH -mm 0/10][RFC] aio: make struct kiocb private
Date: Tue, 16 Jan 2007 00:22:35 -0800
User-Agent: KMail/1.7.1
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@osdl.org>,
       Benjamin LaHaise <bcrl@kvack.org>,
       Christoph Hellwig <hch@infradead.org>,
       Kenneth W Chen <kenneth.w.chen@intel.com>, linux-aio@kvack.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       Nate Diller <nate@agami.com>, netdev@vger.kernel.org,
       ocfs2-devel@oss.oracle.com, Suparna Bhattacharya <suparna@in.ibm.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>, xfs-masters@oss.sgi.com
References: <20070116015450.9764.37697.patchbomb.py@nate-64.agami.com> <20070116032347.GA3697@infradead.org> <5c49b0ed0701152025t2e9fdd6cld36b077f36c78afe@mail.gmail.com>
In-Reply-To: <5c49b0ed0701152025t2e9fdd6cld36b077f36c78afe@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701160022.38492.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 January 2007 8:25 pm, Nate Diller wrote:

> I don't think we should be waiting on sync I/O 
> at the *top* of the call stack, like with wait_on_sync_kiocb(), I'd
> say the best place to wait is at the *bottom*, down in the I/O
> scheduler.

Erm ... *what* I/O scheduler?  These I/O requests may go directly
to the end of the hardware I/O queue, which already has an I/O model
where each request can correspond directly to a KIOCB.  And which
does not include any synchronous primitives.

No such scheduler has previously been, or _should_ be, required.

