Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965333AbVKHHAF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965333AbVKHHAF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 02:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965315AbVKHHAF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 02:00:05 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:59149 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S964954AbVKHHAE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 02:00:04 -0500
To: viro@ftp.linux.org.uk
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, linuxram@us.ibm.com
In-reply-to: <E1EZInj-0001Ef-9Z@ZenIV.linux.org.uk> (message from Al Viro on
	Tue, 08 Nov 2005 02:01:31 +0000)
Subject: Re: [PATCH 2/18] cleanups and bug fix in do_loopback()
References: <E1EZInj-0001Ef-9Z@ZenIV.linux.org.uk>
Message-Id: <E1EZNRz-0007EM-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 08 Nov 2005 07:59:23 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> - check_mnt() on the source of binding should've been unconditional from
> the very beginning.  My fault - as far I could've trace it, that's an
> old thinko made back in 2001.  Kudos to Miklos for spotting it...
> Fixed.
> - code cleaned up.

Can you please explain what purpose does this serve?

AFAICS check_mnt() was there to ensure that operations are done under
the proper namespace semaphore.

Next in the series the namespace semaphore is made global, which
basically means, that most of the check_mnt() invocations become
useless.

The ones which as a side effect prevent grafting to a detached mount
can be changed to check for (mnt->mnt_namespace == NULL) instead of
check against current->namespace.

I see no other reason for wanting to prevent binds from detached
mounts or other namespaces.  It has been discussed that it would be a
good _controlled_ way to send/receive mounts from other namespace
without adding any complexity.  In fact it would only be removal of
complexity now.

Miklos
