Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271399AbTGQK2e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 06:28:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271401AbTGQK2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 06:28:34 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:43787 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271399AbTGQK2a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 06:28:30 -0400
Date: Thu, 17 Jul 2003 12:43:23 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Andries Brouwer <aebr@win.tue.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030717124323.B2302@pclin040.win.tue.nl>
References: <20030716184609.GA1913@kroah.com> <20030716213451.GA1964@win.tue.nl> <20030716143902.4b26be70.akpm@osdl.org> <20030716222015.GB1964@win.tue.nl> <200307170300.UAA24096@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200307170300.UAA24096@cesium.transmeta.com>; from hpa@zytor.com on Wed, Jul 16, 2003 at 07:54:36PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 07:54:36PM -0700, H. Peter Anvin wrote:

> > 16-bit only: 8:8, otherwise 32-bit only: 16:16, otherwise 32:32.
> 
> I would still recommend the arrangement for 64-bit dev_t that I posted
> a while ago:
> 
> dev_t<63:40> := major<31:8>
> dev_t<39:16> := minor<31:8>
> dev_t<15:8>  := major<7:0>
> dev_t<7:0>   := minor<7:0>

Yes, but we we also need to handle 32-bit dev_t incarnations.

> If you want, you can even make it 32-bit-friendly, although it makes
> it more complex; for example, this version would implement 32-bit with
> a 12:20 split:
> 
> dev_t<63:44> := major<31:12>
> dev_t<43:32> := minor<31:20>
> dev_t<31:28> := major<11:8>
> dev_t<27:16> := minor<19:8>
> dev_t<15:8>  := major<7:0>
> dev_t<7:0>   := minor<7:0>

Too messy. But you are right - no conditionals involved.

