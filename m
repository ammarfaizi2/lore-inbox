Return-Path: <linux-kernel-owner+w=401wt.eu-S1751334AbXAIKxI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbXAIKxI (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 05:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751335AbXAIKxI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 05:53:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:41803 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751334AbXAIKxG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 05:53:06 -0500
Date: Tue, 9 Jan 2007 10:53:05 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: viro@ftp.linux.org.uk, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] r/o bind mounts: add vfsmount and superblock writer counts
Message-ID: <20070109105305.GA22984@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Hansen <haveblue@us.ibm.com>, viro@ftp.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20070108183445.9472D522@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20070108183445.9472D522@localhost.localdomain>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 08, 2007 at 10:34:45AM -0800, Dave Hansen wrote:
> Removing it had a few side-effects.  First of all, it made me move
> all of the operations on the counts of writers to underneath the
> spinlock that was already there.  I guess this could be a cause
> for potential contention because there _are_ locks in the common
> code paths now.  But, I do agree with Christoph that it would be
> awfully hard to get it contended.
> 
> The other side-effect is that we can't have the bit in mnt_flags
> to be a shortcut to the superblock's writeable state since we
> don't have a way to go find the mounts and that bit when a fs
> changes writeable state.  This causes a potential cache miss
> when we have to check the superblock directly during the
> relatively common __mnt_is_readonly() function.

Why? We _only_ need to check the vfsmount flag.  vfsmount can
become r/w if the superblock is marked r/o which means the
underlying (block/network/etc) device is fundamentally not writeable.

