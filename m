Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964984AbVITMQ6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964984AbVITMQ6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 08:16:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964985AbVITMQ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 08:16:58 -0400
Received: from H190.C26.B96.tor.eicat.ca ([66.96.26.190]:26830 "EHLO
	moraine.clusterfs.com") by vger.kernel.org with ESMTP
	id S964984AbVITMQ5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 08:16:57 -0400
Date: Tue, 20 Sep 2005 06:11:57 -0600
From: Andreas Dilger <adilger@clusterfs.com>
To: Steve French <smfrench@austin.rr.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       samba-technical@lists.samba.org
Subject: Re: ctime set by truncate even if NOCMTIME requested
Message-ID: <20050920121157.GG12946@schatzie.adilger.int>
Mail-Followup-To: Steve French <smfrench@austin.rr.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	samba-technical@lists.samba.org
References: <432EFAB1.4080406@austin.rr.com> <1127156303.8519.29.camel@lade.trondhjem.org> <432F2684.4040300@austin.rr.com> <1127165311.8519.39.camel@lade.trondhjem.org> <432F5968.1020106@austin.rr.com> <1127180199.26459.17.camel@lade.trondhjem.org> <432F70EF.9010100@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <432F70EF.9010100@austin.rr.com>
User-Agent: Mutt/1.4.1i
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 19, 2005  21:16 -0500, Steve French wrote:
> It does seem like
>    utime(filename, timeval)
> may be the only time we want to send time changes to the server but I am 
> not certain how risky such an approach  is even after scanning fs/open.c 
> to ignore time changes except when both ATIME/MTIME/CTIME are set at the 
> same time (as they are in sys_utime and do_utimes).   Most people 
> probably don't care if the server and client clocks are not too far off, 
> but it does affect performance (presumably even noticeable on something 
> like fsx test)

For Lustre (since we are patching the VFS anyways) we have added an
ATTR_CTIME_SET flag to distinguish whether the client has explicitly
set the ia_ctime field, or if it is an implicit update.

Cheers, Andreas
--
Andreas Dilger
Principal Software Engineer
Cluster File Systems, Inc.

