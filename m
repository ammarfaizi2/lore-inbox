Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263464AbTLJIrh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 03:47:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263472AbTLJIrh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 03:47:37 -0500
Received: from smithers.nildram.co.uk ([195.112.4.54]:8965 "EHLO
	smithers.nildram.co.uk") by vger.kernel.org with ESMTP
	id S263464AbTLJIrg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 03:47:36 -0500
Date: Wed, 10 Dec 2003 08:46:32 +0000
From: Joe Thornber <thornber@sistina.com>
To: Nathan Scott <nathans@sgi.com>
Cc: Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Patch 1/4] fs.h: b_journal_head
Message-ID: <20031210084632.GA476@reti>
References: <20031209115806.GA472@reti> <20031209122418.GC472@reti> <20031209234655.GF783@frodo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209234655.GF783@frodo>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 10:46:55AM +1100, Nathan Scott wrote:
> Could you explain a bit more about when b_private should and
> shouldn't be used with this change?

Once the io goes through generic_make_request() you shouldn't look at
bh->b_private until the io has completed.  At which point it will have
been correctly set back to the value it had when submitted.

The problem with jbd wasn't the fact that it used it, but the fact
that it peeked while the io was in flight.

This is ugly I know, much cleaner in 2.6 where there is a split
between bh and bio.

- Joe
