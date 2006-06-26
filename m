Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933252AbWFZXb1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933252AbWFZXb1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 19:31:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933283AbWFZXbF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 19:31:05 -0400
Received: from dh134.citi.umich.edu ([141.211.133.134]:65211 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S933156AbWFZXaC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 19:30:02 -0400
From: Trond Myklebust <Trond.Myklebust@netapp.com>
Subject: [PATCH 0/5] Enable extra optimisations on fcntl(F_UNLCK) requests on NFS
Date: Mon, 26 Jun 2006 19:29:36 -0400
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, nfs@lists.sourceforge.net
Message-Id: <20060626232936.6059.50399.stgit@lade.trondhjem.org>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following set of patches enables the NFS client to determine more
accurately whether or not it needs to send an NLM/NFSv4 unlock request
if the process has outstanding posix or flock locks:
The current heuristic just assumes that if inode->i_flock is non-null, then
we should always spam the server with an unlock request upon close().

The patchset introduces a new flag to the posix_lock_file()/flock_lock_file()
interfaces that tells them to return -ENOENT if an F_UNLCK request results in
no action.

Cheers,
  Trond
