Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751115AbWEPT2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751115AbWEPT2E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 15:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162AbWEPT2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 15:28:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:41106 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751115AbWEPT2D (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 15:28:03 -0400
Date: Tue, 16 May 2006 12:27:31 -0700
From: Andrew Morton <akpm@osdl.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] fs/jbd/journal.c: possible cleanups
Message-Id: <20060516122731.6ecbdeeb.akpm@osdl.org>
In-Reply-To: <20060516174413.GI10077@stusta.de>
References: <20060516174413.GI10077@stusta.de>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
>
> - remove the following unused EXPORT_SYMBOL's:
>   - journal_set_features
>   - journal_update_superblock

These might be used by lustre - dunno.

But I'm ducking all patches which alter exports, as usual.  If you can get
them through the subsystem maintainer then good luck.

I'd suggest that we pursue the approach of getting the module loader to
spit a warning when someone uses a going-away-soon export.

Arjan had a patch which did that, but he removed basically _every_
presently-unused export.  I don't think we should do that.  If we're
exporting, for example, the kthread API and we happen to notice that
kthread_bind() isn't presently used by any modules then I don't believe it
makes much sense to unexport kthread_bind().  It makes more sense to export
the kthread API as a whole.
