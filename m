Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264242AbTGGTFQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 15:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264246AbTGGTFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 15:05:16 -0400
Received: from air-2.osdl.org ([65.172.181.6]:48309 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264242AbTGGTFM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 15:05:12 -0400
Date: Mon, 7 Jul 2003 12:18:59 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chris Mason <mason@suse.com>
Cc: schlicht@uni-mannheim.de, green@namesys.com, barryn@pobox.com,
       piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: [BUG] heavy disk access sometimes freezes 2.5.73-mm[123]
Message-Id: <20030707121859.5204703f.akpm@osdl.org>
In-Reply-To: <1057599193.20904.1352.camel@tiny.suse.com>
References: <20030703090541.GB5044@ip68-101-124-193.oc.oc.cox.net>
	<20030706193722.79352bc3.akpm@osdl.org>
	<20030707033058.GA2860@ip68-4-255-84.oc.oc.cox.net>
	<200307071758.45702.schlicht@uni-mannheim.de>
	<1057599193.20904.1352.camel@tiny.suse.com>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Mason <mason@suse.com> wrote:
>
> > diff -u linux-2.5.74-mm2/fs/reiserfs/tail_conversion.c.orig linux-2.5.74-mm2/fs/reiserfs/tail_conversion.c
>  > --- linux-2.5.74-mm2/fs/reiserfs/tail_conversion.c.orig	2003-06-23 09:26:10.000000000 -0700
>  > +++ linux-2.5.74-mm2/fs/reiserfs/tail_conversion.c	2003-06-23 09:26:10.000000000 -0700
>  > @@ -190,9 +190,6 @@ unmap_buffers(struct page *page, loff_t 
>  >          }
>  >  	bh = next ;
>  >        } while (bh != head) ;
>  > -      if ( PAGE_SIZE == bh->b_size ) {
>  > -	ClearPageDirty(page);
>  > -      }
>  >      }
>  >    } 
>  >  }
> 
>  Heh, you read my mind.  It makes more sense for this hunk to be causing
>  problems than the first one.  Still we should be allowed to clear the
>  dirty bit since we've cleaned all the buffers on the page.

But we need to tell the VFS that the page was cleaned.

Could someone please make that clear_page_dirty() and retest?


