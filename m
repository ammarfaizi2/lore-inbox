Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030262AbWBYOyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030262AbWBYOyJ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 09:54:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030263AbWBYOyJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 09:54:09 -0500
Received: from dsl093-016-182.msp1.dsl.speakeasy.net ([66.93.16.182]:19642
	"EHLO cinder.waste.org") by vger.kernel.org with ESMTP
	id S1030262AbWBYOyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 09:54:08 -0500
Date: Sat, 25 Feb 2006 08:54:12 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] inflate pt1: clean up input logic
Message-ID: <20060225145412.GI13116@waste.org>
References: <0.399206195@selenic.com> <4.399206195@selenic.com> <20060224221909.GD28855@flint.arm.linux.org.uk> <20060225065136.GH13116@waste.org> <20060225084955.GA27538@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060225084955.GA27538@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 25, 2006 at 08:49:55AM +0000, Russell King wrote:
> On Sat, Feb 25, 2006 at 12:51:36AM -0600, Matt Mackall wrote:
> > On Fri, Feb 24, 2006 at 10:19:09PM +0000, Russell King wrote:
> > > How does this change handle the case where we run out of input data?
> > > This condition needs to be handled explicitly because the inflate
> > > functions can infinitely loop.
> > 
> > And if you look at the current users, you'll see that only two of 15
> > actually use it.
> 
> Sorry, I don't understand the relevance of your comment.

The other 13 did the right thing, namely halt in get_byte. Without
adding a magic goto inside of a macro.

> Please do not back out this fix.

The backing out is only temporary, as I stated in my message. That
said, it should have never gone in.
 
> > > Relying on a bit pattern returned by get_byte() is how this code
> > > pre-fix used to work, and it caused several confused bug reports.
> > 
> > Just about everywhere, get_byte prints an error message and halts.
> 
> And the cases where it doesn't halt is the important case.

Again, current state of things. Did you read the rest of my message?

The end result is that it will halt in all cases. This code _will_not_
infinitely loop. Instead, it will dereference null or print a
diagnostic. I can add another patch to make sure it prints a nice
diagnostic in all cases if you care, but I don't think it's terribly
important.

-- 
Mathematics is the supreme nostalgia of our time.
