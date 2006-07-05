Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWGEFGw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWGEFGw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 01:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWGEFGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 01:06:52 -0400
Received: from relay2.beelinegprs.ru ([217.118.71.5]:47958 "EHLO
	relay1.beelinegprs.ru") by vger.kernel.org with ESMTP
	id S932455AbWGEFGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 01:06:51 -0400
From: Alexander Zarochentsev <zam@namesys.com>
Organization: namesys
To: reiserfs-dev@namesys.com
Subject: Re: [PATCH 1/2] batch-write.patch
Date: Wed, 5 Jul 2006 09:06:58 +0400
User-Agent: KMail/1.8.2
Cc: Christoph Hellwig <hch@infradead.org>,
       "Vladimir V. Saveliev" <vs@namesys.com>, Andrew Morton <akpm@osdl.org>,
       lkml <Linux-Kernel@vger.kernel.org>
References: <44A42750.5020807@namesys.com> <1152011576.6454.36.camel@tribesman.namesys.com> <20060704114836.GA1344@infradead.org>
In-Reply-To: <20060704114836.GA1344@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607050906.58879.zam@namesys.com>
X-SpamTest-Info: Profile: Formal (410/060703)
X-SpamTest-Info: Profile: Detect Hard No RBL (4/030526)
X-SpamTest-Info: Profile: SysLog
X-SpamTest-Info: Profile: Marking Spam - Subject (2/030321)
X-SpamTest-Status: Not detected
X-SpamTest-Version: SMTP-Filter Version 2.0.0 [0129], SpamtestISP/Release
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 July 2006 15:48, Christoph Hellwig wrote:
> On Tue, Jul 04, 2006 at 03:12:56PM +0400, Vladimir V. Saveliev wrote:
> > > Should this be an address_space_operation or a file_operation?
> >
> > I was seeking to be minimal in my changes to the philosophy of the
> > code. So, it was an address_space operation. Now it is a file
> > operation.
>
> It definitly should not be a file_operation! 
 
> It works at the 
> address_space 

generic_batch_write works with the page cache, another batch_write 
implementation may not.

Except the cached_page and pagevec which are generic_batch_write 
context, the batch_write switch leaves file stuff _before_ the switch 
and using of the page cache _after_ the switch.  It gives much 
flexibility to a file system to choose between simple page cache 
buffered write, batch version of page cache write or even not a 
page-oriented write method like reiser4 write method for packed (tails 
only) files.  address space op which does not use the page cache looks 
better as a file op.

> not the much higher file level.

> Maybe all three should 
> become callbacks for the generic write routines, but that's left for
> the future.

Thanks,
Alex.

