Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161130AbWJ3GU4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161130AbWJ3GU4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Oct 2006 01:20:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161134AbWJ3GU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Oct 2006 01:20:56 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:7294 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1161130AbWJ3GUz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Oct 2006 01:20:55 -0500
Message-ID: <45459B92.400@sw.ru>
Date: Mon, 30 Oct 2006 09:28:34 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: devel@openvz.org
CC: Vasily Averin <vvs@sw.ru>, Andrew Morton <akpm@osdl.org>,
       Kirill Korotaev <dev@openvz.org>, Neil Brown <neilb@suse.de>,
       Balbir Singh <balbir@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       David Howells <dhowells@redhat.com>, Olaf Hering <olh@suse.de>,
       Jan Blunck <jblunck@suse.de>
Subject: Re: [Devel] Re: [PATCH 2.6.19-rc3] VFS: per-sb dentry lru list
References: <4541BDE2.6050703@sw.ru> <45409DD5.7050306@sw.ru>	<453F6D90.4060106@sw.ru> <453F58FB.4050407@sw.ru>	<20792.1161784264@redhat.com> <21393.1161786209@redhat.com>	<19898.1161869129@redhat.com> <22562.1161945769@redhat.com>	<24249.1161951081@redhat.com> <4542123E.4030309@sw.ru> <20061030042419.GW8394166@melbourne.sgi.com>
In-Reply-To: <20061030042419.GW8394166@melbourne.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David,

>>The proposed fix prevents this issue by using per-sb dentry LRU list. It
>>provides very quickly search for the unused dentries for given super block thus
>>forcing shrinking always making good progress.
> 
> 
> We've been down this path before:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=114861109717260&w=2
> 
> A lot of comments on per-sb unused dentry lists were made in
> the threads associated with the above. other solutions were
> found to the problem that the above patch addressed, but I don't
> think any of them have made it to mainline yet. You might want
> to have a bit of a read of these threads first...
The major difference between our patch and the one discussed in the link
it that we keep both global and per-sb dentry LRU lists.
Thus, when needed normal LRU is used and prune logic is unchanged,
while umount/remount use per-sb list and do its job faster.

Thanks,
Kirill
