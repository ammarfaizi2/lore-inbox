Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313162AbSEEQIY>; Sun, 5 May 2002 12:08:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313163AbSEEQIX>; Sun, 5 May 2002 12:08:23 -0400
Received: from ool-182c923d.dyn.optonline.net ([24.44.146.61]:7309 "EHLO
	www.milanese.cc") by vger.kernel.org with ESMTP id <S313162AbSEEQIW>;
	Sun, 5 May 2002 12:08:22 -0400
Message-ID: <1020614971.3cd5593b0f908@www.milanese.cc>
Date: Sun,  5 May 2002 12:09:31 -0400
From: "Peter J. Milanese" <peterm@milanese.cc>
To: Urban Widmark <urban@teststation.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMBfs / Unicode problem perhaps?
In-Reply-To: <Pine.LNX.4.33.0205051720470.4444-100000@cola.enlightnet.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.0
X-Originating-IP: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bah...

I did find some old libs on the box...

I've cleaned that all up, and I'm currently compiling 2.2.4 to see how it goes.
I will back it to 2.2.3a again (clean) if there's a problem with that, but the 
notes don't say anything negative. I will go with the patch below IF it comes 
to that, but I'd imagine the old libs were suspect.

Thanks for openning my mind.... :)

P


Quoting Urban Widmark <urban@teststation.com>:

> On Sun, 5 May 2002, Peter J. Milanese wrote:
> 
> > :\ - I am running 2.2.3a... I'll look at those messages and see if there is
> a
> > corelation. Thanks for the tip-
> 
> Are you sure your smbmount is 2.2.3a and that you don't have a mix of an
> old 2.2.1a install? smbmount from 2.2.3a should not negotiate unicode
> unless you told it to ...
> 
> You could also try the untested patch below that only enables it if you
> also specify "codepage=unicode" as a mount option.
> 
> /Urban
> 
> 
> diff -urN -X exclude linux-2.5.13-kbuild-orig/fs/smbfs/proc.c
> linux-2.5.13-kbuild-smbfs/fs/smbfs/proc.c
> --- linux-2.5.13-kbuild-orig/fs/smbfs/proc.c	Fri May  3 02:22:42 2002
> +++ linux-2.5.13-kbuild-smbfs/fs/smbfs/proc.c	Sun May  5 14:53:08 2002
> @@ -979,7 +979,9 @@
>  		SB_of(server)->s_maxbytes = ~0ULL >> 1;
>  		VERBOSE("LFS enabled\n");
>  	}
> -	if (server->opt.capabilities & SMB_CAP_UNICODE) {
> +	if (server->opt.capabilities & SMB_CAP_UNICODE &&
> +	    server->remote_nls == &unicode_table) {
> +		/* Only enable unicode if the remote nls is also unicode */
>  		server->mnt->flags |= SMB_MOUNT_UNICODE;
>  		VERBOSE("Unicode enabled\n");
>  	} else {
> 
> 



