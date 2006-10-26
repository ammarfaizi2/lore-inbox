Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161398AbWJZOJF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161398AbWJZOJF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 10:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161399AbWJZOJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 10:09:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27802 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161398AbWJZOJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 10:09:04 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <4540BEFC.4080502@sw.ru> 
References: <4540BEFC.4080502@sw.ru>  <4540A0C5.60700@sw.ru> <453F58FB.4050407@sw.ru> <19857.1161869015@redhat.com> 
To: Vasily Averin <vvs@sw.ru>
Cc: aviro@redhat.com, Neil Brown <neilb@suse.de>, Jan Blunck <jblunck@suse.de>,
       Olaf Hering <olh@suse.de>, Balbir Singh <balbir@in.ibm.com>,
       Kirill Korotaev <dev@openvz.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       devel@openvz.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [Q] missing unused dentry in prune_dcache()? 
X-Mailer: MH-E 8.0; nmh 1.1; GNU Emacs 22.0.50
Date: Thu, 26 Oct 2006 15:07:32 +0100
Message-ID: <20675.1161871652@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vasily Averin <vvs@sw.ru> wrote:

> I would note that in first two hunks you have decremented
> dentry_stat.nr_unused correctly, under dcache_lock. Probably it's better to
> count freed dentries only in third case and corrects dentry_stat.nr_unused
> value inside shrink_dcache_for_umount_subtree() function before return.

Maybe, maybe not.  This way we only touch the dentry_stat cacheline once, if
at all.  I'm not sure it'd make much difference though.

David
