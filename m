Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269538AbUJFW2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269538AbUJFW2a (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 18:28:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269419AbUJFWYm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 18:24:42 -0400
Received: from fw.osdl.org ([65.172.181.6]:61587 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269531AbUJFWVn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 18:21:43 -0400
Date: Wed, 6 Oct 2004 15:25:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: Pavel Machek <pavel@suse.cz>
Cc: rjw@sisk.pl, linux-kernel@vger.kernel.org, akpm@zip.com.au, agruen@suse.de
Subject: Re: Fix random crashes in x86-64 swsusp
Message-Id: <20041006152533.514fb51b.akpm@osdl.org>
In-Reply-To: <20041006220600.GB25059@elf.ucw.cz>
References: <200410052314.25253.rjw@sisk.pl>
	<200410061206.56025.rjw@sisk.pl>
	<20041006101238.GD1255@elf.ucw.cz>
	<200410062346.29489.rjw@sisk.pl>
	<20041006220600.GB25059@elf.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek <pavel@suse.cz> wrote:
>
> Maybe we should memset freed memory to zero so such bugs are
> prevented?

It would make sense to poison these pages, yes.  Zero would not be a good
choice of value, actually - something like 0xbb would cause nice oopses if
someone used a pointer which was backed by __init memory.

CONFIG_DEBUG_PAGEALLOC will pick up this sort of bug, but that's i386-only.
