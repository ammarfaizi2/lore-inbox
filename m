Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272536AbTGaPm5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272529AbTGaPld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:41:33 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:38528 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272536AbTGaPlE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:41:04 -0400
Date: Thu, 31 Jul 2003 16:40:44 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Oliver Neukum <oliver@neukum.org>
Cc: Con Kolivas <kernel@kolivas.org>, Nick Piggin <piggin@cyberone.com.au>,
       Andrew Morton <akpm@osdl.org>, Johoho <johoho@hojo-net.de>,
       wodecki@gmx.de, Valdis.Kletnieks@vt.edu, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O10int for interactivity
Message-ID: <20030731154044.GB6658@mail.jlokier.co.uk>
References: <200307280112.16043.kernel@kolivas.org> <200307311743.17370.kernel@kolivas.org> <20030731145937.GD6410@mail.jlokier.co.uk> <200307311724.12738.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307311724.12738.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Neukum wrote:
> > Although this would not always be optimal, for many cases the point of
> > AS is that the process is continuing to run, not sleeping, and will
> > issue another request shortly.
> 
> How do you tell which task dirtied the page?

No idea :)

It may be easier to tell which task is _waiting_ on the page when an
I/O completes, as that is the task you are hoping will issue another
I/O to a similar place on the disk soon.

> Wouldn't giving a bonus to tasks doing file io achieve the same purpose?
> Also, isn't quickly waking up tasks more important?

I am not sure, these as just off the cuff ideas :)

That's a policy decision.  Waking up such tasks _may_ be important, on
the other hand if their dynamic priority is so low that they are
sleeping because of that, it means they have used more than their fair
share of CPU recently already, then they should be woken but not run immediately.

If you can figure out in advance that they wouldn't be run immediately
(e.g. due to a dynamic priority test from the task scheduler), that
would tell AS not to bother waiting.

-- Jamie
