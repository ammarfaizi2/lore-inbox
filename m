Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932391AbWHYOmN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWHYOmN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932455AbWHYOmN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:42:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:41181 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932391AbWHYOmM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:42:12 -0400
Date: Fri, 25 Aug 2006 15:41:52 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>, djbarrow@de.ibm.com,
       fpavlic@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH 2/3] kthread: update the s390 lcs driver to use kthread
Message-ID: <20060825144152.GB27364@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, djbarrow@de.ibm.com,
	fpavlic@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>
References: <20060824212323.GC30007@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824212323.GC30007@sergelap.austin.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 04:23:23PM -0500, Serge E. Hallyn wrote:
> Update the s390 Lan Channel Station Network Driver, which can be
> compiled as a module, to use kthread, rather than kernel_thread
> whose EXPORT_SYMBOL has been deprecated.

NACK.  Again a simple s/kernel_thread/kthread_run/ is not what we
need, you need to rething whats going on.  And the thread usage in
lcs is really bad :)

I'm not even sure why it creates all these short-lived threads,
but to fix this mess we might need a new function in kthread.c
that start a thread asynchronously so we can kill all the
workqueue mess in the various s390 net drivers and some other
places.

I'd suggest to start with getting a coherent description of what
those threads actually try to solve from the driver maintainer.
