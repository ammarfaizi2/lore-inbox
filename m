Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267359AbUHEEVX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267359AbUHEEVX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 00:21:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267348AbUHEEVX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 00:21:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:64151 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267359AbUHEEVR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 00:21:17 -0400
Date: Wed, 4 Aug 2004 21:18:27 -0700
From: Andrew Morton <akpm@osdl.org>
To: Josh Aas <josha@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why hold bkl during do_coredump?
Message-Id: <20040804211827.7ace9325.akpm@osdl.org>
In-Reply-To: <410FDF04.9000609@sgi.com>
References: <410FDF04.9000609@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh Aas <josha@sgi.com> wrote:
>
> I'm looking at not holding the bkl during do_coredump, but I can't 
>  figure out why its being held in the first place. I can only think of 
>  the need to not mess with the current memory map, but mmap_sem is 
>  currently held as well. Anybody know what is going on here?

The only thing I can see in there which needs lock_kernel() is the access
to core_pattern - it's changed by sysctl, which also takes lock_kernel().

Probably, adding a lock_kernel() and a comment around the call to
format_corename() should suffice.  Please make format_corename() static
while you're there.

