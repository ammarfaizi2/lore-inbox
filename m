Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030205AbWAIRZ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030205AbWAIRZ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 12:25:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030203AbWAIRZ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 12:25:58 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24980 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964883AbWAIRZ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 12:25:57 -0500
Date: Mon, 9 Jan 2006 17:25:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Mahoney <jeffm@suse.com>
Cc: linux-ia64@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ia64: including <asm/signal.h> alone causes compilation errors
Message-ID: <20060109172554.GA3026@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Mahoney <jeffm@suse.com>, linux-ia64@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20060109171514.GA25096@locomotive.unixthugs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060109171514.GA25096@locomotive.unixthugs.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 09, 2006 at 12:15:14PM -0500, Jeff Mahoney wrote:
> 
>  Including *just* <asm/signal.h> on ia64 will result in a compilation failure,
>  where it will succeed on every other architecture.
> 
>  Every other arch includes <linux/compiler.h> either directly or via
>  <linux/types.h> at the top of <asm-*/signal.h>. ia64 includes
>  <linux/types.h> after including <asm-generic/signal.h>, which causes
>  the __user in <asm-generic/signal.h> to get passed through untouched, causing
>  compilation errors.
> 
>  This patch moves the #include <linux/types.h> up to the beginning of signal.h,
>  as found on every other arch.
> 
>  A specific example of where this behavior is observed is the recent addition
>  of OCFS2. fs/ocfs2/cluster/userdlm.c seems alone in only including
>  <asm/signal.h>, which seems to be perfectly valid.

Generally you should only include <asm/signal.h> via <linux/signal.h>, which gets
<linux/compiler.h> via <linux/spinlock.h>

