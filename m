Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266531AbUHOHyS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266531AbUHOHyS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 03:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266535AbUHOHyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 03:54:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32220 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266531AbUHOHyR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 03:54:17 -0400
Date: Sun, 15 Aug 2004 08:54:16 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Sebastian =?iso-8859-1?Q?K=FCgler?= <sebas@vizZzion.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compile fixes for various fb drivers
Message-ID: <20040815075416.GC12308@parcelfarce.linux.theplanet.co.uk>
References: <200408150149.14663.sebas@vizZzion.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200408150149.14663.sebas@vizZzion.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 01:49:13AM +0200, Sebastian Kügler wrote:
> Hi,
> 
> fb_copy_cmap has changed in 2.6.8.1, but the change is not reflected in all 
> drivers, this updates the respective framebuffer drivers.
> 
> The patch is against vanilla 2.6.8.1.
> 
> Signed-off-by: Sebastian Kügler <sebas@vizZzion.org>

NAK.

First of all, that compile fix isn't - try to compile these drivers and see
if any got fixed by that.

While we are at it, if they would compile, you would have broken them.
Question: what do you think the argument in question was controlling
and why would "drop it silently" be a correct fix?

And finally, the reason why these drivers would fail to compile for quite
a while has a lot in common with the reason why they call fb_copy_cmap()
in the first place - they are trying to provide a method that doesn't exist
anymore and calls in question are from the instances of that method.  Fixing
that is going to remove these calls anyway.
