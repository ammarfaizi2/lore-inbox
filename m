Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVERDKk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVERDKk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 23:10:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVERDKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 23:10:40 -0400
Received: from nevyn.them.org ([66.93.172.17]:49831 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S262073AbVERDKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 23:10:33 -0400
Date: Tue, 17 May 2005 23:10:30 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul LeoNerd Evans <leonerd@leonerd.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix to virtual terminal UTF-8 mode handling
Message-ID: <20050518031030.GA20086@nevyn.them.org>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	Paul LeoNerd Evans <leonerd@leonerd.org.uk>,
	linux-kernel@vger.kernel.org
References: <20050518030513.7fe55ef1@nim.leo> <20050517195848.4a09318d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050517195848.4a09318d.akpm@osdl.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 07:58:48PM -0700, Andrew Morton wrote:
> Paul LeoNerd Evans <leonerd@leonerd.org.uk> wrote:
> >
> >  This patch fixes a bug in the virtual terminal driver, whereby the UTF-8
> >  mode is reset to "off" following a console reset, such as might be
> >  delivered by mingetty, screen, vim, etc...
> 
> Is it a bug?  What did earlier kernels do?  2.4.x?

I'd be inclined to think that this is more of a terminfo issue.  If you
want your terminal to reset into UTF-8, use a terminfo entry with the
appropriate command string instead of the current one - this would be
the 'rs1' capability:

  rs1=\Ec\E]R

That's reset console to default, reset palette.

> Presumably userspace knows what mode the user wants the terminal to be
> using.  Shouldn't userspace be resetting that mode after a reset?

There's no standard way to represent this in userspace.  But yeah.

-- 
Daniel Jacobowitz
CodeSourcery, LLC
