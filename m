Return-Path: <linux-kernel-owner+w=401wt.eu-S1755280AbXABO3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755280AbXABO3K (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 09:29:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755270AbXABO3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 09:29:10 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41155 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755280AbXABO3J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 09:29:09 -0500
Date: Tue, 2 Jan 2007 14:29:01 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Suparna Bhattacharya <suparna@in.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-aio@kvack.org, akpm@osdl.org,
       drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
Subject: Re: [FSAIO][PATCH 7/8] Filesystem AIO read
Message-ID: <20070102142901.GB14954@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
	akpm@osdl.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20061228084252.GG6971@in.ibm.com> <20061228115747.GB25644@infradead.org> <20061228151830.GB10156@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228151830.GB10156@in.ibm.com>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 28, 2006 at 08:48:30PM +0530, Suparna Bhattacharya wrote:
> Yes, we can do that -- how about aio_restarted() as an alternate name ?

Sounds fine to me.

> > Pluse possible naming updates discussed in the last mail.  Also do we
> > really need to pass current->io_wait here?  Isn't the waitqueue in
> > the kiocb always guaranteed to be the same?  Now that all pagecache
> 
> We don't have have the kiocb available to this routine. Using current->io_wait
> avoids the need to pass the iocb down to deeper levels just for the sync vs
> async checks, also allowing such routines to be shared by other code which
> does not use iocbs (e.g. generic_file_sendfile->do_generic_file_read
> ->do_generic_mapping_read) without having to set up dummy iocbs.

We really want to switch senfile to kiocbs btw, - for one thing to
allow an aio_sendfile implementation and second to make it more common
to all the other I/O path code so we can avoid special cases in the
fs code  So I'm not convinced by that argument.  But again we don't
need to put the io_wait removal into your patchkit.  I'll try to
hack on it once I'll get a little spare time.

