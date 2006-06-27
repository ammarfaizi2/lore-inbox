Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030265AbWF0Acu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWF0Acu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jun 2006 20:32:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWF0Act
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jun 2006 20:32:49 -0400
Received: from mail.suse.de ([195.135.220.2]:17338 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030265AbWF0Acs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jun 2006 20:32:48 -0400
From: Neil Brown <neilb@suse.de>
To: Martin Filip <bugtraq@smoula.net>
Date: Tue, 27 Jun 2006 10:32:22 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17568.31894.207153.563590@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS and partitioned md
In-Reply-To: message from Martin Filip on Monday June 26
References: <1151355145.4460.16.camel@archon.smoula-in.net>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday June 26, bugtraq@smoula.net wrote:
> Hello to LKML,
> 
> few days ago I've changed my sw RAID5 to use md_d devices, which are
> "partitonable". (major 254, minor dependant on partiton no)
> 
> The problem is with kernel space NFS daemon. When I create loopback
> device and export it - everything works OK, but when exported directory
> is directly something goes really wrong and it's not possible to mount
> it.
> 
> I'm getting "nfs: server 192.168.0.2 not responding, timed out" in my
> kernel log, when I look on what's happening on network, the last thing
> what's there are 3 retransmitted GETATTR calls without any response. 

Odd.  It works fine for me (I've had this sort of configuration on
some machines for ages, and I just tested a bleeding edge kernel and
it still works).

So I suspect there is something else going on that has nothing to do
with the usage of partitioned md.... then again, maybe there is some
weird sign extension happening to '254' somewhere, though that would
be terribly strange.

So: details please.
 What md device exactly (major and minor)
 What filesystem.
 'tcpdump -s0' trace capturing all nfs/mountd/rpc packets from before
 you issue the mount command. e.g.  use 'rpcinfo -p' to find out what
 port mountd is listening on then,

   tcpdump -s0 -w /tmp/trace host CLIENT and host SERVER and \( \
    port 2049 or port 111 or port MOUNTDPORT \)  &

 Then try the mount.

 After the experiment, on the server
    grep . /proc/net/rpc/*/content
    cat /proc/fs/nfsd/exports

That should be enough detail to start with.

NeilBrown
