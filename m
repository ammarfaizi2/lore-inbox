Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264419AbUFPSl5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbUFPSl5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jun 2004 14:41:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUFPSl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jun 2004 14:41:57 -0400
Received: from havoc.gtf.org ([216.162.42.101]:56268 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S264419AbUFPSls (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jun 2004 14:41:48 -0400
Date: Wed, 16 Jun 2004 14:41:45 -0400
From: David Eger <eger@havoc.gtf.org>
To: Jurriaan <thunder7@xs4all.nl>
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Linux-fbdev-devel] accelerated radeonfb produces artifacts on scrolling in 2.6.7
Message-ID: <20040616184145.GA12673@havoc.gtf.org>
References: <20040616182415.GA8286@middle.of.nowhere>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040616182415.GA8286@middle.of.nowhere>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 16, 2004 at 08:24:15PM +0200, Jurriaan wrote:
> The radeonfb driver in 2.6.7 produces some interesting artifacts on
> scrolling, both scrolling horizontally and vertically.

The corruption you are talking about is, I believe, caused by a couple of things:

(1) we're not issuing enough fifo_wait()'s around our accel engine
    and pan register writes.
(2) there's some disconnect between writing to fb memory, panning, and
    copyarea()/fillrect() calls

I sent a hack of a fix for this to Ben a week ago, adding a call to radeonfb_sync()
at the end of radeonfb_copyarea() and radeonfb_fillrect().  This seems to fix the
problem for me, but you *shouldn't* have to do this.  

I haven't tracked it any further than this.  My next guess would be auditing register 
writes and making sure there are enough fifo_wait()'s...

-dte
