Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWJ3PG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWJ3PG0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 10:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964998AbWJ3PG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 10:06:26 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:2431 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S964990AbWJ3PGZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 10:06:25 -0500
Message-ID: <454616BE.7040900@sw.ru>
Date: Mon, 30 Oct 2006 18:14:06 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Vasily Averin <vvs@sw.ru>, David Howells <dhowells@redhat.com>,
       Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org
Subject: Re: [PATCH 2.6.19-rc3] VFS: per-sb dentry lru list
References: <4541F2A3.8050004@sw.ru>	<4541BDE2.6050703@sw.ru>	<45409DD5.7050306@sw.ru>	<453F6D90.4060106@sw.ru>	<453F58FB.4050407@sw.ru>	<20792.1161784264@redhat.com>	<21393.1161786209@redhat.com>	<19898.1161869129@redhat.com>	<22562.1161945769@redhat.com>	<24249.1161951081@redhat.com>	<4542123E.4030309@sw.ru> <20061027110645.b906839f.akpm@osdl.org>
In-Reply-To: <20061027110645.b906839f.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

>>Virtuozzo/OpenVZ linux kernel team has discovered that umount/remount can last
>>for hours looping in shrink_dcache_sb() without much successes. Since during
>>shrinking s_umount semaphore is taken lots of other unrelated operations like
>>sync can stop working until shrink finished.
> 
> 
> Did you consider altering shrink_dcache_sb() so that it holds onto
> dcache_lock and moves all the to-be-pruned dentries onto a private list in
> a single pass, then prunes them all outside the lock?

moving dentries from global list to the local one can take arbitrary number
of milliseconds (with huge amount of memory), so nothing good here from latency
view point.

Thanks,
Kirill

