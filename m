Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261846AbVBUUJ0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261846AbVBUUJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 15:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbVBUUJ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 15:09:26 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:33904 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261846AbVBUUJV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 15:09:21 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=p5MP8hfwFzcBN0R+8ML39NnBxSrcQiqASTrUhAd4K4ItEYRX1LJoj1g0jlioLJPn/9XaBqyJ+M+M27ubtvoLbJdaf2Ve06yVuZGuqjp70moYm1+JKwAp7QOq9BmYSBZxHllnU862tntZGZTMUXJyrC9Og20RARTa3miMFqmL7W4=
Message-ID: <b6d0f5fb050221120929c27300@mail.gmail.com>
Date: Mon, 21 Feb 2005 20:09:20 +0000
From: Cameron Harris <thecwin@gmail.com>
Reply-To: Cameron Harris <thecwin@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: cifs connection loss hangs
In-Reply-To: <4219FFD0.8050008@austin.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <4219FFD0.8050008@austin.rr.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Feb 2005 09:35:44 -0600, Steve French <smfrench@austin.rr.com> wrote:
> 
>  >Being a wireless user i experience the occasional connection loss due
>  >to walking out of range or something, recently after starting to use
>  >cifs mounts instead of smbfs, I've noticed that stuff tends to break
>  > if i lose connection.
> 
> cifs does support reconnection after tcp session drops (including
> reattaching to the server shares and reopening open files, rewriting
> cached data).
> 
> What kernel version ("cat /proc/version") or cifs vfs version ("modinfo
> /lib/modules/<kernel ver>/kernel/fs/cifs/cifs.ko) are you running?
> 
> 2.6.10 includes one fix for a race in the cifs reconnection logic (which
> is included in cifs version 1.27 or later) and there was an earlier (and
> more important) reconnection fix in cifs version 1.10 (I think that came
> in mainline about at kernel version 2.6.6).
> 
> There are test patches (or in some cases a copy of the fs/cifs
> directory) available for a few of the older but common kernels (SLES9,
> SuseWorkstation 9.2, FC3 etc.) at
> http://us1.samba.org/samba/ftp/cifs-cvs which include up to 2.6.10 level.
> 
> Note that you can view the state of cifs connections by "cat
> /proc/fs/cifs/DebugData" (also interesting is "cat /proc/fs/cifs/Stats")
> which will show the cifs tcp sessions, smb sessions and tree connection
> (mount) and whether they need reconnection - it also shows the state of
> any pending [cifs] operations on the network.
> 
I use 2.6.11-rc1-mm1. I'll check out the /proc/fs/cifs/ stuff next
time i get a problem. It isn't so much reconnection issues, it's if
the connection is completely lost for whatever reason it tends to put
the processes to uninterruptible sleep. It's as though it doesn't
actually return an error, but instead waits until it can access the
file again, even when the filesystem is umounted.

-- 
Cameron Harris
