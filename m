Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbVKGFAy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbVKGFAy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 00:00:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751294AbVKGFAy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 00:00:54 -0500
Received: from tetsuo.zabbo.net ([207.173.201.20]:50331 "EHLO tetsuo.zabbo.net")
	by vger.kernel.org with ESMTP id S1751293AbVKGFAx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 00:00:53 -0500
Message-ID: <436EDF82.8070402@oracle.com>
Date: Sun, 06 Nov 2005 21:00:50 -0800
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.4.1 (X11/20051006)
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org,
       Benjamin LaHaise <bcrl@kvack.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: [Patch] vectored aio: IO_CMD_P{READ,WRITE}V and fops->aio_{read,write}v
References: <20051102233020.27835.89951.sendpatchset@volauvent.pdx.zabbo.net> <20051105002406.GA11235@lst.de> <436C04FE.6000708@oracle.com> <20051107045300.GA17265@lst.de>
In-Reply-To: <20051107045300.GA17265@lst.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Nov 04, 2005 at 05:03:58PM -0800, Zach Brown wrote:

>> If we're going down this path, and find ourselves touching every vectored
>> implementation in the world, I wonder if we shouldn't consider that iovec
>> container.  The desire is to avoid the duplicated iovec walking that happens at
>> the various layers by storing the result of a single walk.  An ext3 O_DIRECT
>> write walks the iovec no fewer than 7 times:

> As we discussed a while ago adding some kinds of fs_iovec or kern_iovec
> structure that records useful addition information could help this.
> Would you mind prototyping it?

Yeah, I have a patch that I've been kicking around.  It's working out
pretty well, though there are some kinks to work around.  Nothing fatal
so far.  I realized when I finally sat down to it that we can just or
together the ptr/len bits and cache them in the structure to help lower
layers with the alignment checks they're currently doing.

> The nice part about the consolidation work I'm doing now is that we'd
> need to touch much fewer places for this than before.

Cool.

I'll try and send something out the next few days.

- z
