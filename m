Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265092AbTIDP2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Sep 2003 11:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265097AbTIDP2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Sep 2003 11:28:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:34524 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265092AbTIDP2N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Sep 2003 11:28:13 -0400
Date: Thu, 4 Sep 2003 08:25:38 -0700 (PDT)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: Pavel Machek <pavel@suse.cz>
cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp: revert to 2.6.0-test3 state
In-Reply-To: <20030904115824.GD24015@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0309040820520.940-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I'm doing return -EAGAIN so I can call driver model myself, and so
> that your code does not proceed with stopping tasks/etc after I've
> done full suspend/resume cycle.
> 
> I see your point about S4. I want to use as little as power/main.c
> infrastructure as possible for now, and this seems like the way to do
> it.
> 
> Okay, it seems that I can move this to pm_suspend, and it will look better.

No, you have to understand that I don't want to call software_suspend() at 
all. You've made the choice not to accept the swsusp changes, so we're 
forking the code. We will have competing implementations of 
suspend-to-disk in the kernel. 

You may keep the interfaces that you had to reach software_suspend(), but
you may not modify the semantics of my code to call it. At some point, you 
may choose to add hooks to swsusp that abide by the calling semantics of 
the PM core, so that you may use the same infrastructure.

Please send a patch that only removes the calls to swsusp_* from 
pm_{suspend,resume}. That would be a minimal patch. 

Thanks,


	Pat

