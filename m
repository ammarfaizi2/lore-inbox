Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316382AbSEOMSf>; Wed, 15 May 2002 08:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316383AbSEOMSe>; Wed, 15 May 2002 08:18:34 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:55696 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S316382AbSEOMSd>; Wed, 15 May 2002 08:18:33 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Sverker Wiberg <Sverker.Wiberg@uab.ericsson.se>
Date: Wed, 15 May 2002 22:18:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15586.20989.992591.474108@notabene.cse.unsw.edu.au>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: knfsd misses occasional writes
In-Reply-To: message from Sverker Wiberg on Wednesday May 15
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday May 15, Sverker.Wiberg@uab.ericsson.se wrote:
> 
> Hello everyone, 
> 
> When copying lots of small files from multiple NFS clients to a kNFSd
> filesystem (i.e. doing backup of a cluster), exported with `sync', I
> find that some few files (1 out of 1000) were silently truncated to zero
> size when checking locally with `ls' (the clients reported total
> success). With `asynch' instead, all files were correctly copied. 

How are you mounting the file systems on the clients?
The symptoms sound exactly like you are using "soft" mounts.  "soft"
is a very bad mount option.  Use "hard".

If you aren't using "soft", let me know and I will look harder.

NeilBrown

> 
> I have seen this behaviour in 2.4.17 (UP and SMP builds, UP hardware) as
> well as 2.4.18, when using the NFSv2 protocol. I have not tried 2.5.x
> and NFSv3 yet. The full /etc/exports line is:
> 
>    /opt/telorb 172.16.0.0/255.255.0.0(rw,sync,no_wdelay)
> 
> Removing `no_wdelay' makes no difference.
> 
> The clients are all 2.4.17, and the relevant .config lines (for both
> server and clients) are:
> 
>    CONFIG_NFS_FS=y
>    CONFIG_NFS_V3=y
>    CONFIG_ROOT_NFS=y
>    CONFIG_NFSD=y
>    CONFIG_NFSD_V3=y
>    CONFIG_SUNRPC=y
>    CONFIG_LOCKD=y
>    CONFIG_LOCKD_V4=y
> 
> Reading the source (fs/nfsd/*) seems to show that knfsd tries to do the
> right thing.
> 
> /Sverker Wiberg
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
