Return-Path: <linux-kernel-owner+w=401wt.eu-S1751232AbXAIKE0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbXAIKE0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:04:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751248AbXAIKE0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:04:26 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37825 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751232AbXAIKEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:04:25 -0500
Date: Tue, 9 Jan 2007 10:04:20 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Eric Sandeen <sandeen@sandeen.net>, David Chinner <dgc@sgi.com>,
       linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
       xfs@oss.sgi.com
Subject: Re: bd_mount_mutex -> bd_mount_sem (was Re: xfs_file_ioctl / xfs_freeze: BUG: warning at kernel/mutex-debug.c:80/debug_mutex_unlock())
Message-ID: <20070109100420.GB14713@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Andrew Morton <akpm@osdl.org>, Eric Sandeen <sandeen@sandeen.net>,
	David Chinner <dgc@sgi.com>,
	linux-kernel Mailing List <linux-kernel@vger.kernel.org>,
	xfs@oss.sgi.com
References: <20070104001420.GA32440@m.safari.iki.fi> <20070107213734.GS44411608@melbourne.sgi.com> <20070108110323.GA3803@m.safari.iki.fi> <45A27416.8030600@sandeen.net> <20070108234728.GC33919298@melbourne.sgi.com> <20070108161917.73a4c2c6.akpm@osdl.org> <45A30828.6000508@sandeen.net> <20070108191800.9d83ff5e.akpm@osdl.org> <45A30E1D.4030401@sandeen.net> <20070108195127.67fe86b8.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108195127.67fe86b8.akpm@osdl.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 07:51:27PM -0800, Andrew Morton wrote:
> I don't even know what code we're talking about here...
> 
> I'm under the impression that XFS will return to userspace with a
> filesystem lock held, under the expectation (ie: requirement) that
> userspace will later come in and release that lock.
> 
> If that's not true, then what _is_ happening in there?
> 
> If that _is_ true then, well, that sucks a bit.

It's not a filesystem lock.  It's a per-blockdevice lock that prevents
multiple people from freezing the filesystem at the same time, aswell
as providing exclusion between a frozen filesystem an mount-related
activity.  It's a traditional text-box example for a semaphore.
