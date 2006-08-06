Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751687AbWHFTsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751687AbWHFTsc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 15:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751689AbWHFTsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 15:48:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11941 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751685AbWHFTsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 15:48:31 -0400
Date: Sun, 6 Aug 2006 12:48:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Proposed update to the kernel kmap/kunmap API
Message-Id: <20060806124827.7f0e1993.akpm@osdl.org>
In-Reply-To: <1154876516.3683.201.camel@mulgrave.il.steeleye.com>
References: <1154876516.3683.201.camel@mulgrave.il.steeleye.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.17; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 06 Aug 2006 10:01:55 -0500
James Bottomley <James.Bottomley@SteelEye.com> wrote:

> The simple part of the proposal is to give non-highmem architectures
> access to the kmap API for the purposes of overriding (this is what the
> attached patch does).
> 
> The more controversial part of the proposal is that we should now
> require all architectures with coherence issues to manage data coherence
> via the kmap/kunmap API.  Thus driver writers never have to write code
> like

kmap() is a nasty thing.  It has theoretical deadlock problems (which used
to be real ones back in the 2.4 days) and the present implementation uses a
kernel-wide lock.

We've been gradually and sporadically working to make kmap() go away, so
please let's not do anything which encourages its use.

kmap_atomic() is much preferred.  Can this initiative be recast around
kmap_atomic()?
