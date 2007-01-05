Return-Path: <linux-kernel-owner+w=401wt.eu-S1161086AbXAEMsc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161086AbXAEMsc (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 07:48:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161090AbXAEMsc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 07:48:32 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:55261 "HELO ustc.edu.cn"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1161086AbXAEMsb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 07:48:31 -0500
Message-ID: <368001275.26960@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Date: Fri, 5 Jan 2007 20:48:22 +0800
From: Fengguang Wu <fengguang.wu@gmail.com>
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Neil Brown <neilb@suse.de>,
       linux-kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: "svc: unknown version (3)" when CONFIG_NFSD_V4=y
Message-ID: <20070105124822.GA7901@mail.ustc.edu.cn>
Mail-Followup-To: Trond Myklebust <trond.myklebust@fys.uio.no>,
	Neil Brown <neilb@suse.de>,
	linux-kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20070105024226.GA6076@mail.ustc.edu.cn> <1167999939.6050.42.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1167999939.6050.42.camel@lade.trondhjem.org>
X-GPG-Fingerprint: 53D2 DDCE AB5C 8DC6 188B  1CB1 F766 DA34 8D8B 1C6D
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 01:25:39PM +0100, Trond Myklebust wrote:
> On Fri, 2007-01-05 at 10:42 +0800, Fengguang Wu wrote:
> > Hi Neil,
> > 
> > NFS mounting succeeded, but the kernel gives a warning.
> > I'm running 2.6.20-rc2-mm1.
> > 
> > # mount -o vers=3 localhost:/suse /mnt
> > [  689.651606] svc: unknown version (3)
> > # mount | grep suse
> > localhost:/suse on /mnt type nfs (rw,nfsvers=3,addr=127.0.0.1)
> 
> Are you perhaps running the userland NFS server instead of knfsd? The
> former will only support NFSv2.

I'm running kernel nfs servers:

USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root      5451  0.0  0.0      0     0 ?        S    19:30   0:00 [nfsd]
root      5452  0.0  0.0      0     0 ?        S    19:30   0:00 [nfsd]
root      5453  0.0  0.0      0     0 ?        S    19:30   0:00 [nfsd]
root      5454  0.0  0.0      0     0 ?        S    19:30   0:00 [nfsd]
root      5455  0.0  0.0      0     0 ?        S    19:30   0:00 [nfsd]
root      5456  0.0  0.0      0     0 ?        S    19:30   0:00 [nfsd]
root      5457  0.0  0.0      0     0 ?        S    19:30   0:00 [nfsd]
root      5458  0.0  0.0      0     0 ?        S    19:30   0:00 [nfsd]
root      5449  0.0  0.0      0     0 ?        S<   19:30   0:00 [rpciod/0]
root      5450  0.0  0.0      0     0 ?        S<   19:30   0:00 [rpciod/1]
root      5462  0.0  0.0   7940   672 ?        Ss   19:30   0:00 /usr/sbin/rpc.mountd
statd     5527  0.0  0.0   7892  1084 ?        Ss   19:30   0:00 /sbin/rpc.statd
root      5538  0.0  0.0  23168   764 ?        Ss   19:30   0:00 /usr/sbin/rpc.idmapd

My system is Debian etch. And I just found that CONFIG_NFSD_V4 is irrelevant,
the message remains even if it is disabled. I'll check more kernel versions.

Thanks,
Wu
