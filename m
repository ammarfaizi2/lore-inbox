Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266176AbUGARHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUGARHL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 13:07:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266194AbUGARHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 13:07:10 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:18050 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S266176AbUGARG6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 13:06:58 -0400
Subject: Re: machine hangs - SLES9/NFS
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: shylendra.bhat@hp.com
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1088683221.3552.15.camel@nt2624.india.hp.com>
References: <1088683221.3552.15.camel@nt2624.india.hp.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1088701615.4349.26.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 01 Jul 2004 13:06:55 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På to , 01/07/2004 klokka 08:00, skreiv Shylendra Bhat:
> Hello,
> 
> I am looking answers for the following questions.
> 
> Is nfs file lock acquired by client, persistent across the nfs server
> reboot?
> I know that this feature was not there in NFSv3. Does NFSv4 supports
> this?

FUD. The lock manager for NFSv3 does reclaim locks if the server
reboots.

> After the nfs service restart, the client fails to release the lock and
> is in a hung state. If the mount directory is listed, it shows
> 
> "bash: cd: /export: Stale NFS file handle"

Which means that the server is screwed up. Two possibilities: either

        1) you have a fibrechannel back end or something like that which
        doesn't have a fixed device number: you can fix that by using
        the "fsid" export option.

        2) The filesystem you are exporting is using non-permanent inode
        numbers (FAT filesystems are a prime example). Sorry: no
        workaround for this other than converting to another filesystem.

Cheers,
  Trond
