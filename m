Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTENLhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 07:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261871AbTENLhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 07:37:13 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:47560 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261861AbTENLhH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 07:37:07 -0400
Date: Wed, 14 May 2003 12:49:53 +0100
From: Matthew Wilcox <willy@debian.org>
To: David Howells <dhowells@redhat.com>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, openafs-devel@openafs.org
Subject: Re: [PATCH] PAG support, try #2
Message-ID: <20030514114953.GS29534@parcelfarce.linux.theplanet.co.uk>
References: <24225.1052909011@warthog.warthog>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24225.1052909011@warthog.warthog>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 11:43:31AM +0100, David Howells wrote:
> +typedef int		__kernel_pag_t;

> +typedef __kernel_pag_t		pag_t;

> +static pag_t vfs_pag_next = 1;

> +	vfspag->pag = vfs_pag_next++;
> +	if (vfspag->pag < 1)
> +		vfspag->pag = 1;

Is there a reason pag_t isn't an unsigned int?  Seems to me you'll have
2^31 good times followed by 2^31 bad times.  Also, isn't signed overflow
one of these undefined things?  I wouldn't mention it except that gcc
seem to be more and more fond of obeying the letter of the standard
rather than doing useful stuff.

-- 
"It's not Hollywood.  War is real, war is primarily not about defeat or
victory, it is about death.  I've seen thousands and thousands of dead bodies.
Do you think I want to have an academic debate on this subject?" -- Robert Fisk
