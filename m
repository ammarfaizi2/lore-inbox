Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031597AbWK3WkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031597AbWK3WkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 17:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031596AbWK3WkH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 17:40:07 -0500
Received: from smtp.osdl.org ([65.172.181.25]:22416 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1031595AbWK3WkG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 17:40:06 -0500
Date: Thu, 30 Nov 2006 14:39:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Ian Kent <raven@themaw.net>
Cc: Jiri Kosina <jkosina@suse.cz>, "H. Peter Anvin" <hpa@zytor.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] autofs: fix error code path in autofs_fill_sb()
Message-Id: <20061130143959.ca82ef57.akpm@osdl.org>
In-Reply-To: <1164863675.3127.4.camel@localhost>
References: <Pine.LNX.4.64.0611300123160.28502@twin.jikos.cz>
	<1164863675.3127.4.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2006 13:14:35 +0800
Ian Kent <raven@themaw.net> wrote:

> > The problem: autofs_fill_super() returns EINVAL to get_sb_nodev(), but before
> > that, it calls kill_anon_super() to destroy the superblock which won't be 
> > needed. This is however way too soon to call kill_anon_super(), because 
> > get_sb_nodev() has to perform its own cleanup of the superblock first
> > (deactivate_super(), etc.). The correct time to call kill_anon_super() is in
> > the autofs_kill_sb() callback, which is called by deactivate_super() at proper
> > time, when the superblock is ready to be killed.
> > 
> > I can see the same faulty codepath also in autofs4. This patch solves issues in
> > both filesystems in a same way - it postpones the kill_anon_super() until the 
> > proper time is signalized by deactivate_super() calling the kill_sb() callback.
> > 
> > Patch against 2.6.19-rc6-mm2.
> > 
> > Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> Acked-by: Ian Kent <raven@themaw.net>
> 
> It looks so obvious now.
> Updating the comment above would be a good idea also, see attached.


Thanks, Ian.

I've tagged these for 2.6.19.x also.  Please let me know if you think that's
inappropriate, unnecessary or too risky.
