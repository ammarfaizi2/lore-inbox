Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284766AbRLLAqR>; Tue, 11 Dec 2001 19:46:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284768AbRLLAqH>; Tue, 11 Dec 2001 19:46:07 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:40977 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S284766AbRLLAp5>; Tue, 11 Dec 2001 19:45:57 -0500
Date: Tue, 11 Dec 2001 19:45:56 -0500 (EST)
From: Elliot Lee <sopwith@redhat.com>
X-X-Sender: <sopwith@devserv.devel.redhat.com>
To: "David S. Miller" <davem@redhat.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: knfsd and FS_REQUIRES_DEV
In-Reply-To: <20011211.162011.21927662.davem@redhat.com>
Message-ID: <Pine.LNX.4.33.0112111922100.541-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Dec 2001, David S. Miller wrote:

>    From: Elliot Lee <sopwith@redhat.com>
>    Date: Tue, 11 Dec 2001 19:13:48 -0500 (EST)
> 
>    I'm looking for information on knfsd's requirement that a filesystem be
>    FS_REQUIRES_DEV in order to export it. Would someone point me in the right
>    direction?
>    
>    Needing to implement some not-quite-kosher exports,
> 
> NFSD puts dev/ino into the filehandles it gives to the
> client, it uses this to lookup the inode in question.

I believe you're bringing up a requirement that inode numbers not change
while the filesystem is being exported, in order to avoid constant "stale
file handle" type of things. I can provide that guarantee (userland
filesystem via coda), but knfsd won't let me get that far because of its
more conservative policies right now.

I'm not worried about problems where files mysteriously disappear due to
me screwing up inode numbers in my code, only about causing kernel panics
or other Bad Things in the server's kernel. If I were to remove the
FS_REQUIRES_DEV check (or, more likely, submit a patch adding an nfsd
module option to remove the check...), what are the worst things that
could theoretically and realistically happen?

-- Elliot


