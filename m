Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUCaQi1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 11:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261852AbUCaQi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 11:38:26 -0500
Received: from dh132.citi.umich.edu ([141.211.133.132]:4739 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S261888AbUCaQiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 11:38:21 -0500
Subject: Re: NFS ENOLCK problem with CONFIG_SECURITY=n
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Roland Dreier <roland@topspin.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <527jx1atuu.fsf@topspin.com>
References: <527jx1atuu.fsf@topspin.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1080751099.4194.23.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 31 Mar 2004 11:38:19 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-31 at 11:01, Roland Dreier wrote:
> I'm having problems with lockf returning ENOLCK on an NFS directory.
> I also see messages like
> 
>     nsm_mon_unmon: rpc failed, status=-13
>     lockd: cannot monitor 10.0.0.5
>     lockd: failed to monitor 10.0.0.5
> 
> The system is an IA64 system running Debian testing with kernel 2.6.4.
> I found previous reports of a similar problem, but the solution was to
> set CONFIG_SECURITY to n (or add CONFIG_SECURITY_CAPABILITIES).
> However, I already have CONFIG_SECURITY off:
> 
>     $ zgrep CONFIG_SECURITY /proc/config.gz
>     # CONFIG_SECURITY is not set
> 
> Am I missing something?

Error 13 == EPERM means "permission denied". Check that you haven't
misconfigured your /etc/hosts.deny file to deny access to
portmap/rpc.statd from localhost/your client on your server/your server
on your client...

Cheers,
  Trond

-- 
Trond Myklebust <trond.myklebust@fys.uio.no>
