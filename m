Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750785AbWDQNDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWDQNDW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 09:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWDQNDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 09:03:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:3237 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S1750785AbWDQNDW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 09:03:22 -0400
Date: Mon, 17 Apr 2006 15:03:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Adrian Bunk <bunk@stusta.de>
Subject: Re: [PATCH][urgent fix] swsusp: prevent possible image corruption on resume
Message-ID: <20060417130307.GC1886@elf.ucw.cz>
References: <200604171449.24548.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200604171449.24548.rjw@sisk.pl>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The function free_pagedir() used by swsusp for freeing its internal data
> structures clears the PG_nosave and PG_nosave_free flags for each page being
> freed.  However, during resume PG_nosave_free set means that the page
> in question is "unsafe" (ie. it will be overwritten in the process of restoring the
> saved system state from the image), so it should not be used for the image
> data.  Therefore free_pagedir() should not clear PG_nosave_free if it's
> called during resume (otherwise "unsafe" pages freed by it may be used for
> storing the image data and the data may get corrupted later on).

Okay with me.
								Pavel

-- 
Thanks for all the (sleeping) penguins.
