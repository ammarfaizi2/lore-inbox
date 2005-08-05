Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262964AbVHEK0l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbVHEK0l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 06:26:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262960AbVHEK0k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 06:26:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:17870 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262964AbVHEK0d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 06:26:33 -0400
Date: Fri, 5 Aug 2005 18:31:38 +0800
From: David Teigland <teigland@redhat.com>
To: J?rn Engel <joern@wohnheim.fh-wedel.de>
Cc: Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-cluster@redhat.com
Subject: Re: [PATCH 00/14] GFS
Message-ID: <20050805103138.GE14880@redhat.com>
References: <20050802071828.GA11217@redhat.com> <1122968724.3247.22.camel@laptopd505.fenrus.org> <20050805071415.GC14880@redhat.com> <1123227279.3239.1.camel@laptopd505.fenrus.org> <20050805094452.GD14880@redhat.com> <20050805100750.GA9818@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050805100750.GA9818@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 12:07:50PM +0200, J?rn Engel wrote:
> On Fri, 5 August 2005 17:44:52 +0800, David Teigland wrote:
> > Do we go a step beyond this and use say the crc32() function from
> > linux/crc32.h?  Is this _function_ as standard and unchanging as the table
> > of crcs?  In my tests it doesn't produce the same results as our
> > gfs2_disk_hash() function, even with both using the same crc table.  I
> > don't mind adopting a new function and just writing a user space
> > equivalent for the tools if it's a fixed standard.
> 
> The function is basically set in stone.  Variants exists depending on
> how it is called.  I know of four variants, but there may be more:
> 
> 1. Initial value is 0
> 2. Initial value is 0xffffffff
> a) Result is taken as-is
> b) Result is XORed with 0xffffffff
> 
> Maybe your code implements 1a, while you tried 2b with the lib/crc32.c
> function or something similar?

You're right, initial value 0xffffffff and xor result with 0xffffffff
matches the results from our function.  Great, we can get rid of
gfs2_disk_hash() and use crc32() directly.
Thanks,
Dave

