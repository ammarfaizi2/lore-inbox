Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263736AbUEDJxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263736AbUEDJxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 05:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264298AbUEDJxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 05:53:32 -0400
Received: from usergc137.dsl.pipex.com ([62.190.170.137]:2570 "EHLO
	gateway.office.e-tv-interactive.com") by vger.kernel.org with ESMTP
	id S263736AbUEDJxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 05:53:15 -0400
Subject: Re: Possible permissions bug on NFSv3 kernel client
From: Colin Paton <colin.paton@etvinteractive.com>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1083357597.13656.37.camel@lade.trondhjem.org>
References: <1QqNJ-4QH-37@gated-at.bofh.it> <1QqNJ-4QH-39@gated-at.bofh.it>
	 <1QqNJ-4QH-35@gated-at.bofh.it> <1Qrhg-5hH-29@gated-at.bofh.it>
	 <E1BJeSB-0000Gk-V2@localhost>
	 <1083357597.13656.37.camel@lade.trondhjem.org>
Content-Type: text/plain
Organization: eTV Interactive Ltd
Message-Id: <1083664520.4538.42.camel@colinp>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Tue, 04 May 2004 10:55:20 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> So why do you think that is inconsistent with my statement: "the
> permissions checking has to be done by the server, period"?

I agree that permission checking should be done by the server. However,
I believe that in this case the client is requesting the wrong
permissions. As writing to a char/block device does not perform a write
operation *on the server* then the client should not be asking the
server for modify/extend permission in the case of char/block devices.

> The read-only mount option does *not apply* to char/block devices such
> as /dev/hd[a-z]*, /dev/tty*. Permission checks on open() for those
> devices are done on the server *only* via the ACCESS rpc call.

Should vfs_permission() (as called from nfs_permission) be sufficient to
perform this check?

> 
> This should be entirely consistent with local file behaviour.

I don't believe that it is... it is possible to write to a block device
on a filesystem that is mounted read-only, but not to write to a block
device on an NFS filesystem that is *exported* read-only. 

I think that nfs_permission() may do sufficient checking - I believe the
problem is in nfs3_proc_access() - where the client is asking the server
for more permissions than it needs.

Colin


