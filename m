Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVIGOZi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVIGOZi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 10:25:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751226AbVIGOZi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 10:25:38 -0400
Received: from dilbert.robsims.com ([209.120.158.98]:32007 "EHLO
	mail.robsims.com") by vger.kernel.org with ESMTP id S1751221AbVIGOZh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 10:25:37 -0400
Date: Wed, 7 Sep 2005 08:25:36 -0600
From: Rob Sims <lkml-z@robsims.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Change in NFS client behavior
Message-ID: <20050907142536.GA26255@robsims.com>
References: <20050831145545.GA8426@robsims.com> <1125617897.7627.14.camel@lade.trondhjem.org> <1125632597.8635.9.camel@lade.trondhjem.org> <20050901204520.58f07230.akpm@osdl.org> <1125633145.8635.11.camel@lade.trondhjem.org> <20050901210755.607f3e4d.akpm@osdl.org> <1125634523.8635.16.camel@lade.trondhjem.org> <1125634747.8635.17.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1125634747.8635.17.camel@lade.trondhjem.org>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 02, 2005 at 12:19:07AM -0400, Trond Myklebust wrote:
> fr den 02.09.2005 Klokka 00:15 (-0400) skreiv Trond Myklebust:
> 
> > Sure. The other problem is that the test is made before the i_sem is
> > grabbed. OK, so how about the appended patch instead?
> 
> Doh!
> 
> Trond

> VFS/NFS: Fix up behaviour w.r.t. truncate() and open(O_TRUNC)
> 
>  POSIX and the SUSv3 specify that open(O_TRUNC) should always bump ctime/mtime
>  whereas truncate() should only do so if the file size actually changes.
> 
>  Fix the behaviour of NFS, which currently is broken w.r.t. open(), and fix
>  the VFS truncate() so that it no enforces the POSIX rules.
> 
>  Signed-off-by: Trond Myklebust <Trond.Myklebust@netapp.com>
> ---
>  attr.c      |   14 +++-----------
>  nfs/inode.c |    5 -----
>  open.c      |   25 +++++++++++++++++++++++--
>  3 files changed, 26 insertions(+), 18 deletions(-)

This patch does not fix the original issue - timestamps are not updated
as expected.
-- 
Rob
