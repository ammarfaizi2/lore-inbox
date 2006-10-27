Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750814AbWJ0LvJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814AbWJ0LvJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 07:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751776AbWJ0LvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 07:51:09 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:59326 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1750814AbWJ0LvI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 07:51:08 -0400
Message-ID: <4541F2A3.8050004@sw.ru>
Date: Fri, 27 Oct 2006 15:50:59 +0400
From: Vasily Averin <vvs@sw.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: David Howells <dhowells@redhat.com>
CC: Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()?
References: <4541BDE2.6050703@sw.ru>  <45409DD5.7050306@sw.ru> <453F6D90.4060106@sw.ru> <453F58FB.4050407@sw.ru> <20792.1161784264@redhat.com> <21393.1161786209@redhat.com> <19898.1161869129@redhat.com> <22562.1161945769@redhat.com>
In-Reply-To: <22562.1161945769@redhat.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

David Howells wrote:
> Vasily Averin <vvs@sw.ru> wrote:
>> Therefore I believe that my patch is optimal solution.
> I'm not sure that prune_dcache() is particularly optimal.

I means that my patch is optimal for problem in subject. I would like to ask you
to approve it and we will go to next issue.

> If we're looking to
> prune for a specific superblock, it may scan most of the dentry_unused list
> several times, once for each dentry it eliminates.
> 
> Imagine the list with a million dentries on it.  Imagine further that all the
> dentries you're trying to eliminate are up near the head end: you're going to
> have to scan most of the list several times unnecessarily; if you're asked to
> kill 128 dentries, you might wind up examining on the order of 100,000,000
> dentries, 99% of which you scan 128 times.

I would note that we (Virtuozzo/OpenVZ team) have seen similar issue on praxis.
We have kernel that handles a few dozens Virtual servers, and each of them have
the several isolated filesystems. We have seen that umount (and remount) can
work very slowly, it was cycled inside shrink_dcache_sb() up to several hours
with taken s_umount semaphore.

We are trying to resolve this issue by using per-sb lru list. I'm preparing the
patch for 2.6.19-rc3 right now and going to send it soon.

thank you,
	Vasily Averin
