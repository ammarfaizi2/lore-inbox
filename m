Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbVKESk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbVKESk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:40:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbVKESk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:40:57 -0500
Received: from smtp.mailbox.co.uk ([195.82.125.32]:29322 "EHLO
	smtp.mailbox.co.uk") by vger.kernel.org with ESMTP id S932189AbVKESk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:40:56 -0500
Date: Sat, 5 Nov 2005 18:40:28 +0000
From: Jon Masters <jonathan@jonmasters.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jon Masters <jonathan@jonmasters.org>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: fix-readonly-policy-use-and-floppy-ro-rw-status
Message-ID: <20051105184028.GD27767@apogee.jonmasters.org>
References: <20051105182728.GB27767@apogee.jonmasters.org> <20051105103358.2e61687f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105103358.2e61687f.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 10:33:58AM -0800, Andrew Morton wrote:

> Jon Masters <jonathan@jonmasters.org> wrote:
> >
> > [PATCH]: This modifies the gendisk and hd_struct structs to replace "policy"
> >  with "readonly" (as that's the only use for this field). It also introduces a
> >  new function disk_read_only, which behaves like the corresponding device
> >  functions do. I've also replaced direct usage of the old policy fields with
> >  calls to the appropriate function.
> 
> These are separate things and should be done in separate patches, please.

I'm following up with another patch that just has the first bit (floppy)
removed.

> Because, for exmaple, we may decide to revert the floppy change only. 
> Because, as I said off-list, being able to do `remount,rw' of a floppy after
> having flipped its switch is useful.

And as I said, the situation as it stands leads to potential data
corruption but I agree with you - we need a VFS callback to handle
readwrite/readonly change on remount I think. Comments?

Jon.
