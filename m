Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262379AbTEFEu7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 00:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262382AbTEFEu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 00:50:59 -0400
Received: from rth.ninka.net ([216.101.162.244]:50869 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S262379AbTEFEu4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 00:50:56 -0400
Subject: Re: [patch] Re: Bug 619 - sched_best_cpu does not pick best cpu
	(2/2)
From: "David S. Miller" <davem@redhat.com>
To: colpatch@us.ibm.com
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Dave Hansen <haveblue@us.ibm.com>,
       Bill Hartner <bhartner@us.ibm.com>,
       Andrew Theurer <habanero@us.ibm.com>, Andrew Morton <akpm@zip.com.au>,
       Robert Love <rml@tech9.net>, linux-kernel@vger.kernel.org
In-Reply-To: <3EB70FC2.1010903@us.ibm.com>
References: <3EB70EEC.9040004@us.ibm.com>  <3EB70FC2.1010903@us.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052186950.983.3.camel@rth.ninka.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 05 May 2003 19:09:10 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-05-05 at 18:28, Matthew Dobson wrote:
> +#if (BITS_PER_LONG == 64)
> +
> +static inline unsigned int generic_hweight64(unsigned int w)
> +{
> +        unsigned int res = (w & 0x5555555555555555) + ((w >> 1) & 0x5555555555555555);

First, there is no way this works.  unsigned int doesn't
hold 64-bit values on any platform I know of. :-)

The best fix is to use 'u64' here and also to remove the silly
BITS_PER_LONG ifdef, it should always be available even on 32-bit
platforms.

-- 
David S. Miller <davem@redhat.com>
