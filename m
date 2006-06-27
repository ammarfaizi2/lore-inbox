Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161036AbWF0Huk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161036AbWF0Huk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 03:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030725AbWF0Huk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 03:50:40 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:33950 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030302AbWF0Huj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 03:50:39 -0400
Date: Tue, 27 Jun 2006 08:50:33 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Christoph Hellwig <hch@infradead.org>,
       Steven Whitehouse <swhiteho@redhat.com>,
       Linus Torvalds <torvalds@osdl.org>,
       David Teigland <teigland@redhat.com>,
       Patrick Caulfield <pcaulfie@redhat.com>,
       Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: GFS2 and DLM
Message-ID: <20060627075033.GA21066@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ingo Molnar <mingo@elte.hu>,
	Steven Whitehouse <swhiteho@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>,
	David Teigland <teigland@redhat.com>,
	Patrick Caulfield <pcaulfie@redhat.com>,
	Kevin Anderson <kanderso@redhat.com>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org
References: <1150805833.3856.1356.camel@quoit.chygwyn.com> <20060623150040.GA1197@infradead.org> <1151080174.3856.1606.camel@quoit.chygwyn.com> <20060623164823.GA12480@infradead.org> <20060626205824.GA16661@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060626205824.GA16661@elte.hu>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 10:58:24PM +0200, Ingo Molnar wrote:
> i think you might be missing that GFS does cross-node locking in 
> readlink too. (OCFS2 does not do it because it apparently does not care 
> about cross-node atime correctness here it seems.) So GFS simply cannot 
> use generic_readlink()!

Please read the code before giving such useless comments.  ->follow_link
needs exactly the same locking as ->readlink.  The whole point of
using generic_readlink is to avoid having the filesystem reimplement
almost the same code twice, once copying to a kernel buffer and once to
a user buffer.

