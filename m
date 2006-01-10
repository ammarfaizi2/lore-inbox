Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750861AbWAJHfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbWAJHfG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 02:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbWAJHfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 02:35:05 -0500
Received: from dslsmtp.struer.net ([62.242.36.21]:31251 "EHLO
	dslsmtp.struer.net") by vger.kernel.org with ESMTP id S1750861AbWAJHfE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 02:35:04 -0500
Message-ID: <48011.194.237.142.7.1136878498.squirrel@194.237.142.7>
In-Reply-To: <20060109.220836.105435044.davem@davemloft.net>
References: <20060109.220836.105435044.davem@davemloft.net>
Date: Tue, 10 Jan 2006 08:34:58 +0100 (CET)
Subject: Re: CONFIG_LOCALVERSION_AUTO recently broken
From: sam@ravnborg.org
To: "David S. Miller" <davem@davemloft.net>
Cc: sam@mars.ravnborg.org, linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> For some reason it isn't post-pending the local GIT version
> string to the destination module directory so the modules
> get installed in the wrong place and upon reboot are not found.
>
> This started happening some time within the last 2 days.
>
> Any ideas? :-)
You do not have git installed so root can find them, and you install
modules as root - this causes the wrong KERNELRELEASE to be defined.
Obviously it is not the right fix to install git in a 'root' location so
I have implemented a solution in my tree where we only update
KERNELRELEASE when we build a kernel.
This solution required that "make install" do not try to update vmlinux -
so this dependency is now zapped.
I do not have access to my linux box atm, but you can find the patches in
lkml archieves and at:
git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

I've asked Linus to pull so we get this fix propagated soonish.

     Sam


