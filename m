Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269026AbUI2Uxk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269026AbUI2Uxk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 16:53:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269029AbUI2Uxj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 16:53:39 -0400
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:2821 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S269026AbUI2Uxg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 16:53:36 -0400
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Trond Myklebust <trond.myklebust@fys.uio.no>,
       "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Subject: Re: Linux 2.6.8-rc4 "Kernel panic: Attempted to kill init!" - af ter replacing /fadsroot on the Linux NFSserver with the one from Arabella cdrom
Date: Wed, 29 Sep 2004 23:53:29 +0300
User-Agent: KMail/1.5.4
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <313680C9A886D511A06000204840E1CF0A6471D9@whq-msgusr-02.pit.comms.marconi.com> <1096407135.11135.138.camel@lade.trondhjem.org>
In-Reply-To: <1096407135.11135.138.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200409292353.29957.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 29 September 2004 00:32, Trond Myklebust wrote:
> På ty , 28/09/2004 klokka 23:14, skreiv Povolotsky, Alexander:
> > In my previous e-mail I forgot to mention that on the remote NFS Linux
> > (Intel PC) server I am running:
> > 
> > Red Hat Linux release 9 (Shrike)
> > Kernel 2.4.20-28.9 on an i686
> > 
> > I have another strange problem to report - related to NFS.
> > To work around my original problem (reported in my previous e-mail),
> > I am booting with ramdisk as root filesystem server and then trying to
> > manually mount the /fadsroot exported on the 
> > above described Linux NFS server - I am getting errors ( but mounting still
> > works) ...
> > 
> > Could anyone on this list determine (guess) what is the reason for errors
> > (see below) ?
> 
> You have to use the "-onolock" option if you are not running the
> rpc.portmap and rpc.statd daemons.

Or alternatively configure 127.0.0.1 on loopback and
start portmapper before you mount NFS. You can kill portmapper
before you pivot_root into "real" root dir.

>From /linuxrc on my initrd:

echo "# Configuring interfaces"
# Optional, for NFS happiness
ip l set dev lo up
ip a add 127.0.0.1/8 dev lo
...
rpc.portmap             # for statd (which is implicitly started by mount)
while true; do
    mount -n -o ro $ROOTFS /new_root \
    && break
    echo "mount -n -o ro $ROOTFS /new_root failed (err:$?)"; sleep 2
done
killall rpc.portmap     # portmap keeps old root busy
...
--
vda

