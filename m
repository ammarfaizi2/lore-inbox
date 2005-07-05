Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261686AbVGET7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261686AbVGET7i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 15:59:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261735AbVGET7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 15:59:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28348 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261686AbVGET7f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 15:59:35 -0400
Message-ID: <42CAE6A6.8030100@RedHat.com>
Date: Tue, 05 Jul 2005 15:59:34 -0400
From: Steve Dickson <SteveD@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.7) Gecko/20050417 Fedora/1.7.7-1.3.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Xin Zhao <uszhaoxin@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: kernel 2.6: NFS problem---cannot rmmod nfsd
References: <mailman.1120585560.25519.linux-kernel2news@redhat.com>
In-Reply-To: <mailman.1120585560.25519.linux-kernel2news@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xin Zhao wrote:
> I compile kernel 2.6.11.10 and configure both nfs client and server as
> kernel modules.  But after I reboot the machine and did
> "/etc/init.d/nfs start", the nfsd module is inserted. But when I tried
> to rmmod this module either with "/etc/init.d/nfs stop" or "umount
> /proc/fs/nfsd; rmmod nfsd",  the nfsd reference count is always 1 and
> cannot be removed.  Why?
Because you need to umount /proc/fs/nfsd.
Note: you'll also need to restart rpc.idmapd.

Try the following:

service nfs start # which load everything that's needed

service nfs stop
service rpcidmapd stop
umount /proc/fs/nfsd
rmmod nfsd

Then to (safely) reinstall the module

insmod /tmp/nfsd.ko
mount -t nfsd nfsd /proc/fs/nfsd
service nfs start (which also will start rpcidmapd on FC boxes)

steved.
