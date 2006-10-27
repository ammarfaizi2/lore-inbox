Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752313AbWJ0SHx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbWJ0SHx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 14:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752376AbWJ0SHx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 14:07:53 -0400
Received: from smtp.osdl.org ([65.172.181.4]:64391 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1752298AbWJ0SHw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 14:07:52 -0400
Date: Fri, 27 Oct 2006 11:06:45 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vasily Averin <vvs@sw.ru>
Cc: David Howells <dhowells@redhat.com>, Neil Brown <neilb@suse.de>,
       Jan Blunck <jblunck@suse.de>, Olaf Hering <olh@suse.de>,
       Balbir Singh <balbir@in.ibm.com>, Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [PATCH 2.6.19-rc3] VFS: per-sb dentry lru list
Message-Id: <20061027110645.b906839f.akpm@osdl.org>
In-Reply-To: <4542123E.4030309@sw.ru>
References: <4541F2A3.8050004@sw.ru>
	<4541BDE2.6050703@sw.ru>
	<45409DD5.7050306@sw.ru>
	<453F6D90.4060106@sw.ru>
	<453F58FB.4050407@sw.ru>
	<20792.1161784264@redhat.com>
	<21393.1161786209@redhat.com>
	<19898.1161869129@redhat.com>
	<22562.1161945769@redhat.com>
	<24249.1161951081@redhat.com>
	<4542123E.4030309@sw.ru>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Oct 2006 18:05:50 +0400
Vasily Averin <vvs@sw.ru> wrote:

> Virtuozzo/OpenVZ linux kernel team has discovered that umount/remount can last
> for hours looping in shrink_dcache_sb() without much successes. Since during
> shrinking s_umount semaphore is taken lots of other unrelated operations like
> sync can stop working until shrink finished.

Did you consider altering shrink_dcache_sb() so that it holds onto
dcache_lock and moves all the to-be-pruned dentries onto a private list in
a single pass, then prunes them all outside the lock?

