Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271742AbRIGLrZ>; Fri, 7 Sep 2001 07:47:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271745AbRIGLrF>; Fri, 7 Sep 2001 07:47:05 -0400
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.29]:26890 "HELO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S271742AbRIGLrE>; Fri, 7 Sep 2001 07:47:04 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: "Michael Rothwell" <rothwell@holly-springs.nc.us>
Date: Fri, 7 Sep 2001 21:47:13 +1000 (EST)
Message-ID: <15256.46017.7716.689482@notabene.cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: nfs is stupid ("getfh failed")
In-Reply-To: message from Michael Rothwell on Thursday September 6
In-Reply-To: <002b01c136e1$3bb36a80$81d4870a@cartman>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday September 6, rothwell@holly-springs.nc.us wrote:
> Two systems that worked fine for weeks, both running 2.4.[7,8] kernels. The
> server is running 2.4.8 and exporting a reiserfs filesystem via nfs. Or it
> was, anyway. The server was shut down and brought back up (power failure).
> The client was then
> rebooted.
> 
> server# cat /etc/exports
> /export 192.168.1.*(rw,no_root_squash)
> /export/home 192.168.1.*(rw,no_root_squash)

This is not allowed, and makes no sense.
exporting "/export" exports everything below /export that is in the
same filesystem, so exporting "/export/home" as well servers no
purpose and is not allowed (unless /export/home is a separate
filesystem).

Simply remove the second line and your problems should go away.


> client# mount /export
> mount: 192.168.1.1:/export failed, reason given by server: Permission denied
> 
> server# tail /var/log/messages
> Sep  6 09:37:43 gateway rpc.mountd: authenticated mount request from
> 192.168.1.133:933 for /export (/export)
> Sep  6 09:37:43 gateway rpc.mountd: getfh failed: Operation not permitted
> 
> ... so,  rebooting two working systems seems to kill NFS. Any ideas why?
> 
> On a related topic, will Linux ever have a better file-service protocol?

This is an unanswerable question.  The future of Linux is completely
undefined until it happens.

What exactly do you mean by "better" anyway?

NeilBrown
 

> 
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
