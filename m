Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262261AbTIHMjK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Sep 2003 08:39:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262275AbTIHMjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Sep 2003 08:39:09 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:38664 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262261AbTIHMjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Sep 2003 08:39:06 -0400
Date: Mon, 8 Sep 2003 14:38:46 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Matthew Wilcox <willy@debian.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use size_t for the broken ioctl numbers
Message-ID: <20030908123846.GA15553@win.tue.nl>
References: <20030907062248.GX18654@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030907062248.GX18654@parcelfarce.linux.theplanet.co.uk>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 07, 2003 at 07:22:48AM +0100, Matthew Wilcox wrote:

> Clearly it's too late to change the ioctl definitions, but we can at
> least stop people from copying them and making the same mistake.

> -#define BLKELVSET  _IOW(0x12,107,sizeof(blkelv_ioctl_arg_t))/* elevator set */
> +#define BLKELVSET  _IOW(0x12,107,size_t)/* elevator set */

Here we lose information - I don't like that.
Often it is important to know what kind of argument an ioctl has,
and that info should be easy to find.

I see other parts of this thread discuss the question on how to force people
to do things right in new cases. For old cases, instead of throwing out
the information that a blkelv_ioctl_arg_t is involved, I would like to write

#define BLKELVSET  _IOW_BAD(0x12,107,blkelv_ioctl_arg_t)

with

#define _IOW_BAD( ... ) _IOW(..., sizeof(...))

(with s/_IOW/_IOW_NOCK/ in case _IOW is changed so as to check).

Andries

