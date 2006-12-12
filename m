Return-Path: <linux-kernel-owner+w=401wt.eu-S932179AbWLLJyQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWLLJyQ (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 04:54:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932181AbWLLJyQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 04:54:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43906 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932179AbWLLJyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 04:54:15 -0500
Subject: Re: 2.6.19.1 GFS2_FS_LOCKING_DLM bug still lurking
From: Steven Whitehouse <swhiteho@redhat.com>
To: Chris Zubrzycki <chris@middle--earth.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <FCD18869-724B-4E5B-B682-2E39578C36B4@middle--earth.org>
References: <FCD18869-724B-4E5B-B682-2E39578C36B4@middle--earth.org>
Content-Type: text/plain
Organization: Red Hat (UK) Ltd
Date: Tue, 12 Dec 2006 09:59:26 +0000
Message-Id: <1165917566.3752.1056.camel@quoit.chygwyn.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 2006-12-12 at 00:10 -0500, Chris Zubrzycki wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> I tried building the new kernel and ran into this bug:
> 
> WARNING: "kernel_sendmsg" [fs/dlm/dlm.ko] undefined!
> WARNING: "sock_release" [fs/dlm/dlm.ko] undefined!
> WARNING: "config_item_put" [fs/dlm/dlm.ko] undefined!
> WARNING: "sock_create_kern" [fs/dlm/dlm.ko] undefined!
> WARNING: "config_item_init_type_name" [fs/dlm/dlm.ko] undefined!
> WARNING: "config_group_init_type_name" [fs/dlm/dlm.ko] undefined!
> WARNING: "configfs_register_subsystem" [fs/dlm/dlm.ko] undefined!
> WARNING: "config_group_find_obj" [fs/dlm/dlm.ko] undefined!
> WARNING: "configfs_unregister_subsystem" [fs/dlm/dlm.ko] undefined!
> WARNING: "kernel_recvmsg" [fs/dlm/dlm.ko] undefined!
> WARNING: "config_item_get" [fs/dlm/dlm.ko] undefined!
> WARNING: "config_group_init" [fs/dlm/dlm.ko] undefined!
> make[1]: *** [__modpost] Error 1
> make: *** [modules] Error 2
> 
> 
> 
> I found the solution here: http://www.spinics.net/lists/kernel/ 
> msg535532.html
> I only changed the one file, fs/gfs2/Kconfig, and added
> 
> +	depends on GFS2_FS && INET && (IPV6 || IPV6=n)
> +	select IP_SCTP if DLM_SCTP
> +	select CONFIGFS_FS
> 
> It seems to work fine now. Please CC me on any replies, thank you.
> 
Ok. I'll make a proper patch now and get that added to the git tree.
Thanks,

Steve.


