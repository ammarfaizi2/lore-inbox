Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVKHJ33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVKHJ33 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 04:29:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965097AbVKHJ32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 04:29:28 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:36613 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S965014AbVKHJ30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 04:29:26 -0500
To: linuxram@us.ibm.com
CC: viro@ftp.linux.org.uk, torvalds@osdl.org, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
In-reply-to: <1131439567.5400.221.camel@localhost> (message from Ram Pai on
	Tue, 08 Nov 2005 00:46:07 -0800)
Subject: Re: [PATCH 2/18] cleanups and bug fix in do_loopback()
References: <E1EZInj-0001Ef-9Z@ZenIV.linux.org.uk>
	 <E1EZNRz-0007EM-00@dorka.pomaz.szeredi.hu> <1131439567.5400.221.camel@localhost>
Message-Id: <E1EZPm4-0007R7-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 08 Nov 2005 10:28:16 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I see no other reason for wanting to prevent binds from detached
> > mounts or other namespaces.  It has been discussed that it would be a
> > good _controlled_ way to send/receive mounts from other namespace
> > without adding any complexity.
> 
> AFAICT, the ability to bind across namespaces defeats the private-ness
> property of per-process-namespaces. 

No.  The privateness is guaranteed by proc_check_root(), which is
similar, but not the same as check_mnt(), and wich restrict _access_
to other namespaces.

check_mnt() restricts operations on other namespaces if you _already_
have access to said namespace.  For example via a file descriptor sent
between two processes in different namespaces.

Also with ptrace() you can still access other process's namespace, so
proc_check_root() is also too strict (or ptrace() too lax).

Miklos
