Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267873AbUHNBpQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267873AbUHNBpQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 21:45:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267881AbUHNBpQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 21:45:16 -0400
Received: from dh138.citi.umich.edu ([141.211.133.138]:31385 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S267873AbUHNBpM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 21:45:12 -0400
Subject: Re: [2.6.8-rc4-bk] NFS oops on x86-64
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <411D65B4.4030208@pobox.com>
References: <411D65B4.4030208@pobox.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1092447909.4078.18.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 13 Aug 2004 21:45:09 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

På fr , 13/08/2004 klokka 21:07, skreiv Jeff Garzik:
> See attached...   oops in BK-latest NFS client on x86-64.  The oops is 
> 100% reproducible, and occurs immediately (as soon as I access any 
> portion of the mounted NFS filesystem; the mount itself succeeds).
> 

Does reverting Willy's borken patch fix it? That patch was clearly never
actually tested before Linus applied it.

I can see 2 problems in the NFS code alone:

  1) Replacing a test for whether or not O_APPEND and O_DIRECT are
*both* set with one that checks whether either is set.
  2) Adding a wonderful check in nfs_open() that causes it to return
immediately if this new nfs_check_flags() returns 0 (i.e. OK).

GRRRR


   Trond
