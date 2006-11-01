Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946720AbWKAJU2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946720AbWKAJU2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 04:20:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946721AbWKAJU2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 04:20:28 -0500
Received: from mx1.suse.de ([195.135.220.2]:21941 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1946720AbWKAJU1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 04:20:27 -0500
From: Neil Brown <neilb@suse.de>
To: David Howells <dhowells@redhat.com>
Date: Wed, 1 Nov 2006 17:32:54 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17736.16278.85405.497875@cse.unsw.edu.au>
Cc: Kirill Korotaev <dev@sw.ru>, devel@openvz.org, Vasily Averin <vvs@sw.ru>,
       Andrew Morton <akpm@osdl.org>, Kirill Korotaev <dev@openvz.org>,
       Balbir Singh <balbir@in.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Olaf Hering <olh@suse.de>, Jan Blunck <jblunck@suse.de>
Subject: Re: [Devel] Re: [PATCH 2.6.19-rc3] VFS: per-sb dentry lru list 
In-Reply-To: message from David Howells on Tuesday October 31
References: <17734.54114.192151.271984@cse.unsw.edu.au>
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
	<20061030042419.GW8394166@melbourne.sgi.com>
	<45459B92.400@sw.ru>
	<25762.1162291214@redhat.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday October 31, dhowells@redhat.com wrote:
> Neil Brown <neilb@suse.de> wrote:
> 
> > When we unmount a filesystem we need to release all dentries.
> > We currently
> >   - move a collection of dentries to the end of the dentry_unused list
> >   - call prune_dcache to prune that number of dentries.
> 
> This is not true anymore.

True.  That should read:


 When we remount a filesystem or invalidate a block device which has a
 mounted filesystem we call shrink dcache_sb which currently:
     - moves a collection of dentries to the end of the dentry_unused list
     - calls prune_dcache to prune that number of dentries.

but the patch is still valid.

Any objections to it going in to -mm  and maybe .20 ??

Thanks,
NeilBrown
