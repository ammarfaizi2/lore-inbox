Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261892AbUJYPOm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261892AbUJYPOm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Oct 2004 11:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbUJYPNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Oct 2004 11:13:44 -0400
Received: from phoenix.infradead.org ([81.187.226.98]:54540 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261892AbUJYO7Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Oct 2004 10:59:24 -0400
Date: Mon, 25 Oct 2004 15:59:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Mike Waychison <michael.waychison@sun.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       raven@themaw.net
Subject: Re: [PATCH 3/28] VFS: Move expiry into vfs
Message-ID: <20041025145917.GA1492@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Mike Waychison <michael.waychison@sun.com>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	raven@themaw.net
References: <10987151702831@sun.com> <10987152003432@sun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10987152003432@sun.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 25, 2004 at 10:40:00AM -0400, Mike Waychison wrote:
> This patch moves the recently added expiry functionality directly into the
> VFS layer.  Doing this gives us a couple advantages:
> 
>   - Allows for configurable timeouts using a single consolidated timer
>   - Keeps filesystems from having to each implement their own expiry logic
>   - Provides a generic interface that can be used for _any_ filesystem, as
>     desired by user applications and/or the system admninistrator.
> 
> This patch implements expiry by having the VFS recursively register work to
> do.  Checks are done for expiry every 1 second, so expiry is configurable to
> that granularity.

The expiry timer should only run as long as there are filesystems registered
for expiry.

