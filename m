Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWHYOKS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWHYOKS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 10:10:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWHYOKR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 10:10:17 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7882 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751171AbWHYOKP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 10:10:15 -0400
Date: Fri, 25 Aug 2006 15:10:14 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/17] BLOCK: Stop fallback_migrate_page() from using page_has_buffers() [try #2]
Message-ID: <20060825141014.GD10659@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <20060824213252.21323.18226.stgit@warthog.cambridge.redhat.com> <20060824213258.21323.94502.stgit@warthog.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060824213258.21323.94502.stgit@warthog.cambridge.redhat.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2006 at 10:32:58PM +0100, David Howells wrote:
> From: David Howells <dhowells@redhat.com>
> 
> Stop fallback_migrate_page() from using page_has_buffers() since that might not
> be available.  Use PagePrivate() instead since that's more general.

We should document somewhere where to use which of those functions,
especially as they are currently 100% functionally identical.

Also if we ever get private data for anything but buffers these kinds of
checks in generic code will cause problems.  Maybe we should just
kill the default fallback in this case?

