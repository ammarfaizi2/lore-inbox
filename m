Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261715AbUKXDRw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261715AbUKXDRw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 22:17:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261717AbUKXDRw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 22:17:52 -0500
Received: from waste.org ([209.173.204.2]:38272 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S261715AbUKXDRu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 22:17:50 -0500
Date: Tue, 23 Nov 2004 19:17:26 -0800
From: Matt Mackall <mpm@selenic.com>
To: Colin Leroy <colin@colino.net>
Cc: linux-kernel@vger.kernel.org, hirofumi@mail.parknet.co.jp
Subject: Re: [PATCH] let fat handle MS_SYNCHRONOUS flag
Message-ID: <20041124031726.GF8040@waste.org>
References: <20041118194959.3f1a3c8e.colin@colino.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118194959.3f1a3c8e.colin@colino.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 07:49:59PM +0100, Colin Leroy wrote:
> Hi,
> 
> this patch is an RFC patch not to be applied.
> It adds MS_SYNCHRONOUS support to FAT filesystem, so that less
> filesystem breakage happen when disconnecting an USB key, for 
> example. I'd like to have comments about it, because as it 
> seems to work fine here, I'm not used to fs drivers and could
> have made mistakes.
> Thanks,
> 
> +			if (bh != NULL) {
> +				sync_dirty_buffer(bh);
> +				brelse(bh);
> +			} else {
> +				BUG_ON(1);

This construct is really weird.

How about:

BUG_ON(!bh);
sync_dirty_buffer(bh);
brelse(bh);

Concept seems good, and the implementation otherwise looks good at
first glance.

-- 
Mathematics is the supreme nostalgia of our time.
