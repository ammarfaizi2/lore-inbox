Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVCYOIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVCYOIG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 09:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbVCYOIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 09:08:06 -0500
Received: from mail.dif.dk ([193.138.115.101]:30340 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261617AbVCYOH6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 09:07:58 -0500
Date: Fri, 25 Mar 2005 15:09:53 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: David Howells <dhowells@redhat.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: security/keys/key.c broken with defconfig 
In-Reply-To: <24082.1111664764@redhat.com>
Message-ID: <Pine.LNX.4.62.0503251504220.2498@dragon.hyggekrogen.localhost>
References: <Pine.LNX.4.62.0503222223180.2683@dragon.hyggekrogen.localhost>
  <24082.1111664764@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Mar 2005, David Howells wrote:

> Jesper Juhl <juhl-lkml@dif.dk> wrote:
> 
> > If I just do a 'make defconfig' and then try to build security/keys/ the 
> > build breaks.  Doing 'make allyesconfig' fixes it by defining CONFIG_KEYS 
> > which makes include/linux/key-ui.h include the full struct key definition.
> > 
> > I've not attempted to fix this yet, but thought I'd at least report it.
> > 
> > 
> > juhl@dragon:~/download/kernel/linux-2.6.12-rc1-mm1$ make defconfig
> > juhl@dragon:~/download/kernel/linux-2.6.12-rc1-mm1$ make security/keys/
> 
> Ah. Why would you do that last command at all?
> 
I had made a few small changes in there and wanted to see if they compiled 
cleanly, but I didn't want to build cleanly and assumed that the build 
system would figure out any dependencies. Obviously I forgot to enable 
CONFIG_KEYS and thus the stuff in security/keys/ is not happy.

> If you look in security/Makefile, you'll see that the security/keys/ directory
> is only entered if CONFIG_KEYS is defined; which in your config it isn't.
> 
You are right. I had not looked into it that much, had I just tried to 
"make security/" I'd have seen that the stuff in security/keys/ did not 
build at all and would have realized my mistake. if the Makefile in 
security/keys/ also checked for CONFIG_KEYS it would have been even more 
obvious, but I guess that would just be bloat..?

In any case, there's no problem except for user error on my part.


--
Jesper Juhl




