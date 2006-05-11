Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965104AbWEKAOk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965104AbWEKAOk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 20:14:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965105AbWEKAOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 20:14:40 -0400
Received: from ns2.suse.de ([195.135.220.15]:46222 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S965104AbWEKAOj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 20:14:39 -0400
From: Neil Brown <neilb@suse.de>
To: Patrick McLean <chutz@cs.mcgill.ca>
Date: Thu, 11 May 2006 10:14:23 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17506.33247.884320.387785@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Bogecho <andrewb@cs.mcgill.ca>
Subject: Re: NFS locking
In-Reply-To: message from Patrick McLean on Wednesday May 10
References: <446246D6.5010509@cs.mcgill.ca>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: v[Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday May 10, chutz@cs.mcgill.ca wrote:
> We have a NFS server here with a fairly high load. The clients are
> Linux, FreeBSD and Solaris. The exported filesystem is XFS, which is onb
> a LVM drive. After between 3 and 30 days it seems that locking
> completely stops working, clients generally either error or simply lock
> up when they try to lock a file. The only way to fix it seems to be a
> reboot.

Reboot the client or the server?

> 
> Last time it happened was on 2.6.17-rc2, it started around 2.6.15.
> 
> There is nothing in the dmesg on the server, the (Linux) clients are
> printing this in the dmesg when something tries to create a lock:
> 
> lockd: server xxx.xxx.xxx.xxx not responding, still trying
> lockd: server xxx.xxx.xxx.xxx not responding, still trying
> lockd: server xxx.xxx.xxx.xxx not responding, still trying
> lockd: server xxx.xxx.xxx.xxx not responding, still trying

Sounds like the server has locked up.
What does 'ps' on the server show for 'lockd'?  Is it in 'D'?  What is
the 'wchan'?  Are any 'nfsd's permanently in 'D'?

Try
 echo t > /proc/sysrq-trigger

and see what the stack trace for lockd is - probably only useful if it
is in 'D'.

Maybe a 'tcpdump -s 1500' of traffic between client and server would
help.

NeilBrown

