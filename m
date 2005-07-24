Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261485AbVGXWgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261485AbVGXWgn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Jul 2005 18:36:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261514AbVGXWgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Jul 2005 18:36:43 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:23457 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261498AbVGXWgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Jul 2005 18:36:37 -0400
Date: Sun, 24 Jul 2005 23:36:34 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christoph Hellwig <hch@infradead.org>,
       Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
       zab@zabbo.net, mason@suse.com
Subject: Re: [PATCH 2/6] Rename __lock_page to lock_page_slow
Message-ID: <20050724223634.GB9620@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Suparna Bhattacharya <suparna@in.ibm.com>, linux-aio@kvack.org,
	linux-kernel@vger.kernel.org, bcrl@kvack.org, wli@holomorphy.com,
	zab@zabbo.net, mason@suse.com
References: <20050620120154.GA4810@in.ibm.com> <20050620160126.GA5271@in.ibm.com> <20050620162404.GB5380@in.ibm.com> <20050724221702.GA9620@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050724221702.GA9620@infradead.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2005 at 11:17:02PM +0100, Christoph Hellwig wrote:
> On Mon, Jun 20, 2005 at 09:54:04PM +0530, Suparna Bhattacharya wrote:
> > In order to allow for interruptible and asynchronous versions of
> > lock_page in conjunction with the wait_on_bit changes, we need to
> > define low-level lock page routines which take an additional
> > argument, i.e a wait queue entry and may return non-zero status,
> > e.g -EINTR, -EIOCBRETRY, -EWOULDBLOCK etc. This patch renames 
> > __lock_page to lock_page_slow, so that __lock_page and 
> > __lock_page_slow can denote the versions which take a wait queue 
> > parameter.
> 
> How many users that don't use a waitqueue parameter will be left
> once all AIO patches go in?

Actually looking at the later patches we always seem to pass
current->io_wait anyway, so is there a real point for having the
argument?

