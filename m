Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266511AbUIOUsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266511AbUIOUsX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUIOUpN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:45:13 -0400
Received: from [69.25.196.29] ([69.25.196.29]:7105 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S266511AbUIOUom (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:44:42 -0400
Date: Wed, 15 Sep 2004 16:41:07 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] hvc_console fix to protect hvc_write against ldisc write after hvc_close
Message-ID: <20040915204107.GA26776@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	Ryan Arnold <rsa@us.ibm.com>, Andrew Morton <akpm@osdl.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <1095273835.3294.278.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095273835.3294.278.camel@localhost>
User-Agent: Mutt/1.5.6+20040818i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 15, 2004 at 01:43:55PM -0500, Ryan Arnold wrote:
> Andrew,
> 
> Due to the tty ldisc code not stopping write operations against a driver
> even after a tty has been closed I added a mechanism to hvc_console in
> my previous patch to prevent this by nulling out the tty->driver_data in
> hvc_close() but I forgot to check tty->driver_data in hvc_write(). 
> Anton Blanchard got several oops'es from hvc_write() accessing NULL as
> if it were a pointer to an hvc_struct usually stored in
> tty->driver_data.
> 
> So this patch checks tty->driver_data in hvc_write() before it is used. 
> Hopefully once Alan Cox's patch is checked in ldisc writes won't
> continue to happen after tty closes.

The current (I can't speak to what Alan Cox is going to change) rules
with tty drivers is that tty drivers are supposed to close the line
discpline in their close routines.  That's the much safer and cleaner
way of fixing this problem, and it is in line with what most of the
other tty drivers are doing.

					- Ted
