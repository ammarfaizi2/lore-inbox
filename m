Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264257AbTFPUW1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 16:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTFPUW1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 16:22:27 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:55561 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264257AbTFPUW0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 16:22:26 -0400
Date: Mon, 16 Jun 2003 21:36:17 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
cc: Flameeyes <daps_mls@libero.it>, <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.71, fbconsole: No boot logo?
In-Reply-To: <49AA33D2A8D@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44.0306162133520.12997-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It is probably some uninitialized value or something like that.
> 
> At work I have no logo, while at home I have logo (both 2.5.71 from
> yesterday), both with matroxfb... Only significant difference I know
> is that at home I have UP kernel, while at work I have SMP. But it should 
> not matter, yes?

Its a bug in cfbimgblt.c. In cfb_imageblit you have a test 

} else if (image->depth == bpp)

Its should be 

} else if (image->depth <= bpp)

instead. At present the logo will only show up when the framebuffer depth 
matches the image's depth. cfb_imageblit supports displaying images of 
equal or lesser depths than the framebuffer.


