Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266187AbUG0AK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266187AbUG0AK1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 20:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266192AbUG0AK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 20:10:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:28591 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266187AbUG0AKZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 20:10:25 -0400
Date: Mon, 26 Jul 2004 17:08:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: miklos@szeredi.hu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix readahead breakage for sequential after random
 reads
Message-Id: <20040726170843.3fe5615c.akpm@osdl.org>
In-Reply-To: <1090886218.8416.3.camel@dyn319181.beaverton.ibm.com>
References: <E1BmKAd-0001hz-00@dorka.pomaz.szeredi.hu>
	<20040726162950.7f4a3cf4.akpm@osdl.org>
	<1090886218.8416.3.camel@dyn319181.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ram Pai <linuxram@us.ibm.com> wrote:
>
> Andrew,
> 	Yes the patch fixes a valid bug.
> 

Please don't top-post :(

> RP
> 
> On Mon, 2004-07-26 at 16:29, Andrew Morton wrote:
> > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > Current readahead logic is broken when a random read pattern is
> > >  followed by a long sequential read.  The cause is that on a window
> > >  miss ra->next_size is set to ra->average, but ra->average is only
> > >  updated at the end of a sequence, so window size will remain 1 until
> > >  the end of the sequential read.
> > > 
> > >  This patch fixes this by taking the current sequence length into
> > >  account (code taken from towards end of page_cache_readahead()), and
> > >  also setting ra->average to a decent value in handle_ra_miss() when
> > >  sequential access is detected.
> > 
> > Thanks.   Do you have any performance testing results from this patch?
> > 
> Ram Pai <linuxram@us.ibm.com> wrote:
>
> Andrew,
> 	Yes the patch fixes a valid bug.

Fine, but the readahead code is performance-sensitive, and it takes quite
some time for any regressions to be discovered.  So I'm going to need to
either sit on this patch for a very long time, or extensively test it
myself, or await convincing test results from someone else.

Can you help with that?
