Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271147AbTGPWKQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 18:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271163AbTGPWIL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 18:08:11 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:16907 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S271147AbTGPWFY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 18:05:24 -0400
Date: Thu, 17 Jul 2003 00:20:15 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] print_dev_t for 2.6.0-test1-mm
Message-ID: <20030716222015.GB1964@win.tue.nl>
References: <20030716184609.GA1913@kroah.com> <20030716130915.035a13ca.akpm@osdl.org> <20030716210253.GD2279@kroah.com> <20030716141320.5bd2a8b3.akpm@osdl.org> <20030716213451.GA1964@win.tue.nl> <20030716143902.4b26be70.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030716143902.4b26be70.akpm@osdl.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 16, 2003 at 02:39:02PM -0700, Andrew Morton wrote:
> Andries Brouwer <aebr@win.tue.nl> wrote:
> >
> > On Wed, Jul 16, 2003 at 02:13:20PM -0700, Andrew Morton wrote:
> > 
> > > The new dev_t encoding is a bit weird because we of course continue to
> > > support the old 8:8 encoding.  I think the rule is: "if the top 32-bits are
> > > zero, it is 8:8, otherwise 32:32".  We can express this nicely with
> > > "%u:%u".
> > 
> > 16-bit only: 8:8, otherwise 32-bit only: 16:16, otherwise 32:32.

> Why do we need the 16:16 option?

It is not very important, but major 0 is reserved, so if userspace
(or a filesystem) hands us a 32-bit device number, we have to
split that in some way, not 0+32. Life is easiest with 16+16.
(Now the major is nonzero, otherwise we had 8+8.)
Other choices lead to slightly more complicated code.

Andries

