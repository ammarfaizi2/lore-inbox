Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUAEPZi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jan 2004 10:25:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265168AbUAEPZh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jan 2004 10:25:37 -0500
Received: from hirsch.in-berlin.de ([192.109.42.6]:4250 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP id S265161AbUAEPZf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jan 2004 10:25:35 -0500
X-Envelope-From: kraxel@bytesex.org
Date: Mon, 5 Jan 2004 11:59:15 +0100
From: Gerd Knorr <kraxel@bytesex.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: caszonyi@rdslink.ro, linux-kernel@vger.kernel.org
Subject: Re: your mail
Message-ID: <20040105105915.GU15106@bytesex.org>
References: <Pine.LNX.4.53.0312262105560.537@grinch.ro> <Pine.LNX.4.58.0312261419230.14874@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312261419230.14874@home.osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 		....
>                         while (voffset >= sg_dma_len(vsg)) {
>                                 voffset -= sg_dma_len(vsg);
>                                 vsg++;
>                         }
> 		....

> I suspect the problem is that 
> 
> 	"voffset >= sg_dma_len(vsg)"
> 
> test: if "voffset" is _exactly_ the same as sg_dma_len(), then we will 
> test one more iteration (when "voffset" is 0), and that iteration may be 
> past the end of the "vsg" array.

That certainly makes sense, the 'v' plane is the last one in the memory
block for the video frame to be captured, so voffset / vsg will walk to
the last sg entry and may overrun described.  Good catch, I'm impressed.

> I suspect the fix might be to change the test to
> 
> 	"voffset && voffset >= sg_dma_len(vsg)"

Merged into my tree, thanks.

still busy with the xmas mail backlog,

  Gerd

