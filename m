Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263939AbUDNH7W (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 03:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263948AbUDNH7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 03:59:22 -0400
Received: from fw.osdl.org ([65.172.181.6]:8068 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263939AbUDNH7S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 03:59:18 -0400
Date: Wed, 14 Apr 2004 00:58:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] conditionalize some boring buffer_head checks
Message-Id: <20040414005832.083de325.akpm@osdl.org>
In-Reply-To: <407CEB91.1080503@pobox.com>
References: <407CEB91.1080503@pobox.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@pobox.com> wrote:
>
> 
> These checks are executed billions of times per day, with no stack dump 
> bug reports sent to lkml.  Arguably, they will only trigger on buggy 
> filesystems (programmer error), and thus IMO shouldn't even be executed 
> in a non-debug kernel.
> 
> Even though BUG_ON() includes unlikely(), I think this patch -- or 
> something like it -- is preferable.  The buffer_error() checks aren't 
> even marked unlikely().
> 
> This is a micro-optimization on a key kernel fast path.
> 

buffer_error() was always supposed to be temporary.  Once per month someone
reports the one in __find_get_block_slow(), but that's all.  The only
reason for keeping it around is as a debug aid to filesystem developers.

We could make it a no-op if !CONFIG_BUFFER_DEBUG.
