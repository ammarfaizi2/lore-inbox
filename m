Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264946AbUGZHEn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264946AbUGZHEn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 03:04:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264953AbUGZHEn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 03:04:43 -0400
Received: from fw.osdl.org ([65.172.181.6]:23208 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264946AbUGZHEl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 03:04:41 -0400
Date: Mon, 26 Jul 2004 00:03:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 and SPEC SFS Run rules.
Message-Id: <20040726000313.3fbf8403.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0407221933520.2152-100000@einstein.homenet>
References: <Pine.LNX.4.44.0407221933520.2152-100000@einstein.homenet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tigran Aivazian <tigran@aivazian.fsnet.co.uk> wrote:
>
> I have a simple question --- does ext3 conform to the SPEC SFS Run rules 
>  with default mount options or does one need to force the correct 
>  behaviour by mounting in some "special" way?. Here is the URL for the 
>  rules:
> 
>    http://www.spec.org/sfs97r1/docs/runrules.html
> 
>  In particular, the bit that is worrying me is:
> 
>    For NFS Version 3, the server adheres to the protocol specification. In 
>    particular the requirement that for STABLE write requests and COMMIT 
>    operations the NFS server must not reply to the NFS client before any 
>    modified file system data or metadata, with the exception of access times, 
>    are written to stable storage for that specific or related operation. 
>    See RFC 1813, NFSv3 protocol specification for a definition of STABLE 
>    and COMMIT for NFS write requests.
> 
>  As far as I can see from nfsd source this means:
> 
>  a) write with 'stable' flag set does a f_op->write() with O_SYNC.
> 
>  b) COMMIT3 just means f_op->fsync().
> 
>  So, the question is really --- do ext3 O_SYNC write and fsync require some 
>  special mount options to work _properly_ or are they fine by default?
> 
>  Looking at ext3_sync_file() it seems OK by default.
> 
>  However, looking at ext3 ->write() operation it seems to forcibly commit 
>  only if it is mounted with EXT3_MOUNT_JOURNAL_DATA option (or if it is not 
>  a regular file or if EXT3_JOURNAL_DATA_FL inode flag is set).

ext3 should be fully syncing data and metadata for both fsync() and O_SYNC
writes in all three journalling modes.  If not, that's a big bug.
