Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262933AbTEGGnH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 02:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbTEGGnH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 02:43:07 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:26377 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262933AbTEGGnG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 02:43:06 -0400
Date: Wed, 7 May 2003 07:55:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "David S. Miller" <davem@redhat.com>
Cc: thomas@horsten.com, voidcartman@yahoo.com, marcelo@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.21-rc1: byteorder.h breaks with __STRICT_ANSI__ defined (trivial)
Message-ID: <20030507075536.A9467@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"David S. Miller" <davem@redhat.com>, thomas@horsten.com,
	voidcartman@yahoo.com, marcelo@conectiva.com.br,
	linux-kernel@vger.kernel.org
References: <200305070850.59912.voidcartman@yahoo.com> <200305070744.27207.thomas@horsten.com> <20030507074557.A9197@infradead.org> <20030506.224405.26296708.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030506.224405.26296708.davem@redhat.com>; from davem@redhat.com on Tue, May 06, 2003 at 10:44:05PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 10:44:05PM -0700, David S. Miller wrote:
>    That's highly broken because his libc was compiled against 2.2
>    headers.  You must never use different headers in
>    /usr/include/Pasm,linux} then those your libc was compiled against.
>    
> While I understand this problem, this line of reasoning simply does
> not apply for headers that libc/glibc/whatever are agnostic about.

That's how it should be.  We had tons of problems due to mismatchig
headers (usually it was "just" compile breakage because older libc
headers / compilers couldn't cope with constructs used in new kernel
headers) in the past and the only way to fix this is really don't 
ever use mismatching headers.  This is not just related to kernels,
for example Oracle ()at least up to 8i) ships .o files for their product
that were compiled on some development box but then link them at
installation time to the user's system libc.  You can guess how this
breaks :)
