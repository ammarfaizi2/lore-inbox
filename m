Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964959AbWH2Lur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbWH2Lur (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 07:50:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964957AbWH2Lur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 07:50:47 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:60129 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964959AbWH2Luq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 07:50:46 -0400
Date: Tue, 29 Aug 2006 12:50:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Cedric Le Goater <clg@fr.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Neil Brown <neilb@suse.de>, nfs@lists.sourceforge.net
Subject: Re: [NFS] kthread: update lockd to use kthread
Message-ID: <20060829115044.GA26794@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Cedric Le Goater <clg@fr.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Neil Brown <neilb@suse.de>, nfs@lists.sourceforge.net
References: <44EEA5E5.6000509@fr.ibm.com> <20060825135824.GA10659@infradead.org> <44EF2E6F.1040905@fr.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44EF2E6F.1040905@fr.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2006 at 07:07:59PM +0200, Cedric Le Goater wrote:
> This kernel thread is a sub thread of the lockd thread. It's a bit more
> simple and does not require as much modification. It still depends on the
> way its parent is killed and it will require some more work when the sunrpc
> thread are fixed.

Yes, the whole sunrpc/nfs thread situation is rather difficult.

> The SIGKILL used to terminate the threads is a challenge ... it propagates
> to sub threads. Some other stuff that bother me in using the kthread api in
> sunrpc : nfs_callback_down() uses a wait on a completion with a timeout.
> This is not possible with the kthread but might not be really useful. dunno.

The usage look buggy to me because we can't guarantee thread exit.  But
I really don't even understand the requirements for those threads yet,
I wish someone could write up a coherent description.

