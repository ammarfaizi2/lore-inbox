Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbTFYPlI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:41:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264592AbTFYPlI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:41:08 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:25862 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264582AbTFYPlH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:41:07 -0400
Date: Wed, 25 Jun 2003 16:55:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Lou Langholtz <ldl@aros.net>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org, pavel@ucw.cz
Subject: Re: [RFC][PATCH] nbd driver for 2.5+: fix locking issues with ioctl UI
Message-ID: <20030625165513.A20328@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Lou Langholtz <ldl@aros.net>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org, pavel@ucw.cz
References: <3EF94672.3030201@aros.net> <20030625001950.16bbb688.akpm@digeo.com> <3EF9C192.7000206@aros.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EF9C192.7000206@aros.net>; from ldl@aros.net on Wed, Jun 25, 2003 at 09:36:50AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 09:36:50AM -0600, Lou Langholtz wrote:
> I have also attached a patch to Pavel's nbd-2.0 release nbd tools that 
> updates the nbd-client to work with linux 2.5 as well as 2.5.74 
> (assuming the aforementioned patch 6.1 made it into 2.5.74). Handling is 
> switched at compile time however and uses <linux/version.h> to do the 
> switching. This will have problems of course if the builder doesn't pay 
> close attention to where there header file are coming from or tries to 
> run the same binary on a different kernel release. Etc.

That's broken.  You must make sure that a binary works with different
kernels or at least make it fail gracefully.  Using <linux/version.h>
from userspace is absolutely not acceptable, just don't use kernel headers
at all but a local copy of <linux/nbd.h>.

