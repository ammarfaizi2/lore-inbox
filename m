Return-Path: <linux-kernel-owner+w=401wt.eu-S1754858AbWL1OPa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754858AbWL1OPa (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 09:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbWL1OPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 09:15:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:38036 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752302AbWL1OP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 09:15:29 -0500
Date: Thu, 28 Dec 2006 14:15:18 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
       akpm@osdl.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
Subject: Re: [FSAIO][PATCH 7/8] Filesystem AIO read
Message-ID: <20061228141518.GA5211@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
	akpm@osdl.org, drepper@redhat.com, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, jakub@redhat.com, mingo@elte.hu
References: <20061227153855.GA25898@in.ibm.com> <20061228082308.GA4476@in.ibm.com> <20061228084252.GG6971@in.ibm.com> <20061228115747.GB25644@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061228115747.GB25644@infradead.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Pluse possible naming updates discussed in the last mail.  Also do we
> really need to pass current->io_wait here?  Isn't the waitqueue in
> the kiocb always guaranteed to be the same?  Now that all pagecache
> I/O goes through the ->aio_read/->aio_write routines I'd prefer to
> get rid of the task_struct field cludges and pass all this around in
> the kiocb.  

Btw, in current mainline task_struct.iowait is not used at all!  The patch
below would remove it vs mainline, although I don't think it should go
in as-is as it would create quite a bit of messup for your patchset.
