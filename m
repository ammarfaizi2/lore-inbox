Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262424AbUCLU0x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 15:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262345AbUCLUX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 15:23:29 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:13573 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262497AbUCLUTi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 15:19:38 -0500
Date: Fri, 12 Mar 2004 20:19:33 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (8/10): zfcp fixes.
Message-ID: <20040312201933.A19244@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, akpm@osdl.org,
	linux-kernel@vger.kernel.org
References: <20040312193816.GI2757@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040312193816.GI2757@mschwid3.boeblingen.de.ibm.com>; from schwidefsky@de.ibm.com on Fri, Mar 12, 2004 at 08:38:16PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2004 at 08:38:16PM +0100, Martin Schwidefsky wrote:
>  - Replace release function for device structures by kfree. Move struct
>    device to the start of struct zfcp_port/zfcp_unit to make it work.

That's ugly as hell.  Actually even more ugly.  It's not that ->release
is such a performance critical path that you absolutely need to avoid one
level of function calls.  So please put a simple wrapper back instead of
the horrible casts and suddenly the silly placement restrictions are gone,
too.

And *please* send any scsi driver changes to linux-scsi@vger.kernel.org.

While we're at it, what's the reason zfcp isn't in drivers/scsi/?

