Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264886AbUD2Rjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264886AbUD2Rjs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 13:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264898AbUD2Rjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 13:39:48 -0400
Received: from dh132.citi.umich.edu ([141.211.133.132]:59782 "EHLO
	lade.trondhjem.org") by vger.kernel.org with ESMTP id S264886AbUD2RjV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 13:39:21 -0400
Subject: Re: Possible permissions bug on NFSv3 kernel client
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: Colin Paton <colin.paton@etvinteractive.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1083236543.4541.293.camel@colinp>
References: <1083236543.4541.293.camel@colinp>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1083260353.3686.63.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 29 Apr 2004 13:39:13 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-04-29 at 07:02, Colin Paton wrote:

> In file: fs/nfs/nfs3proc.c modify nfs3_proc_access(). This calls the
> access RPC on the server. I added the following to the code:
> 
>             if (S_ISBLK(inode->i_mode) || S_ISCHR(inode->i_mode))
>                 {
>                     // Leave arg.access untouched.
>  
>                 }
> 
> ...so that the the MODIFY and EXTEND bits aren't set when writing to a
> block or character device.

Hmm... Why shouldn't the MODIFY bit at least be set if the user
requested write access to the device?

Cheers,
  Trond
