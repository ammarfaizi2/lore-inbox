Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262580AbUKLQs4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262580AbUKLQs4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 11:48:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262578AbUKLQrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 11:47:32 -0500
Received: from phoenix.infradead.org ([81.187.226.98]:27661 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262579AbUKLQpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 11:45:34 -0500
Date: Fri, 12 Nov 2004 16:45:29 +0000
From: Christoph Hellwig <hch@infradead.org>
To: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@osdl.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix SHMEM options
Message-ID: <20041112164529.GA7308@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	David Howells <dhowells@redhat.com>, Andrew Morton <akpm@osdl.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel@vger.kernel.org
References: <20041111144153.588094d2.akpm@osdl.org> <20041111012333.1b529478.akpm@osdl.org> <20041111030837.12a2090b.akpm@osdl.org> <111920000.1100210158@flay> <20652.1100256658@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20652.1100256658@redhat.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by phoenix.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 12, 2004 at 10:50:58AM +0000, David Howells wrote:
> 
> > This change permits CONFIG_SHMEM=n on !CONFIG_MMU, even if !EMBEDDED.  Or
> > something.  I'm not really sure what it's trying to do, nor am I clear on
> > what semantics we wanted to have for CONFIG_SHMEM on CONFIG_MMU machines.
> > 
> > I think the semantics we want are: you always get shmem, unless you
> > selected EMBEDDED.  So perhaps we want:
> 
> It boils down to:
> 
>  (1) You can't use full shmem if !MMU. You have to use tinyshmem instead.
> 
>  (2) On an embedded system, you might want to drop shmem because you don't
>      have much flash in which to store your kernel.
> 
> This seems to have the desired effect:

Note that tiny-shmem really only makes sense for MMU if SWAP is not set.

