Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264665AbUFPTie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264665AbUFPTie (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 15:38:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264692AbUFPTid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 15:38:33 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:38417 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S264665AbUFPTiW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 15:38:22 -0400
Message-ID: <40D0A5B4.7060007@techsource.com>
Date: Wed, 16 Jun 2004 15:55:32 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: David Eger <eger@havoc.gtf.org>
CC: Jurriaan <thunder7@xs4all.nl>, linux-fbdev-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] accelerated radeonfb produces artifacts on
 scrolling in 2.6.7
References: <20040616182415.GA8286@middle.of.nowhere> <20040616184145.GA12673@havoc.gtf.org>
In-Reply-To: <20040616184145.GA12673@havoc.gtf.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



David Eger wrote:
> On Wed, Jun 16, 2004 at 08:24:15PM +0200, Jurriaan wrote:
> 
>>The radeonfb driver in 2.6.7 produces some interesting artifacts on
>>scrolling, both scrolling horizontally and vertically.
> 
> 
> The corruption you are talking about is, I believe, caused by a couple of things:
> 
> (1) we're not issuing enough fifo_wait()'s around our accel engine
>     and pan register writes.
> (2) there's some disconnect between writing to fb memory, panning, and
>     copyarea()/fillrect() calls
> 
> I sent a hack of a fix for this to Ben a week ago, adding a call to radeonfb_sync()
> at the end of radeonfb_copyarea() and radeonfb_fillrect().  This seems to fix the
> problem for me, but you *shouldn't* have to do this.  
> 
> I haven't tracked it any further than this.  My next guess would be auditing register 
> writes and making sure there are enough fifo_wait()'s...


Is this the case even with the off-by-one error in the bitblt code 
fixed?  In the 2.4 kernel, I got rid of all artifacts by fixing the 
off-by-one error.

In case, you don't know what I'm talking about, when you bitblt up or to 
the left on Radeon, x and y need to be adjusted by (w-1) and/or (h-1), 
respectively.  The code there, however, adjusted by w and/or h, which is 
off-by-one.

