Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318025AbSGWLCh>; Tue, 23 Jul 2002 07:02:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318026AbSGWLCh>; Tue, 23 Jul 2002 07:02:37 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:36046 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S318025AbSGWLCg>; Tue, 23 Jul 2002 07:02:36 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Info <arling@sniip.ru>
Date: Tue, 23 Jul 2002 21:05:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15677.14461.517606.906118@notabene.cse.unsw.edu.au>
cc: Trond Myklebust <trond.myklebust@fys.uio.no>, linux-kernel@vger.kernel.org
Subject: Re: Fwd: NFS locking/acess bug in 2.4.19-rc3
In-Reply-To: message from Trond Myklebust on Tuesday July 23
References: <200207231236.37768.trond.myklebust@fys.uio.no>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Subject: NFS locking/acess bug in 2.4.19-rc3
> Date: Tue, 23 Jul 2002 14:31:45 +0400
> To: trond.myklebust@fys.uio.no
> Cc: linux-kernel@vger.kernel.org
> 
> Description of situation.
> 
> NFS server with public file system, export whith options (rw,
> map_daemon, all_squash, anonuid=99, anonguid=99).

I cannot reproduce your problem,  behaviour and code seem correct to
me.

I am suspicious of the "map_daemon" option.
This is not valid for the Kernel NFS server and would not be accepted
by the nfs-utils package.
Are you perhaps using the user-space nfs server (some times called
"nfs-server")?

If so, you should know that:
  The behaviour of the user-space nfs server would not be affect
    (greatly) by the kernel version that you are running
  That server is completely unsupported (as far as I know).

If you are using the  kernel based server, please show me:
  cat /etc/exports
  cat /proc/fs/nfs/exports

and I will try harder to reproduce the problem.

NeilBrown

> 
> Both server and client boxes runs under 2.4.19-rc3.
> 
> Problem:
> 
> When client create catalog in NFS, it normally creates with
> uid=99 guid=99 (i.e. "nobody") and access rwXr-Xr-X.
> 
> This catalog normally deleted by client too.
> 
> But attempting of write file into created catalog from the same
> client failed: "acess denied". File writing is possible only if
> "write" privilegies to this catalog is given to "others", i.e.
> after "chmod "o+w" <catalogname>".
> 
> Analogical situation with files: text editor normally creates
> new file ("save as"), but acess denied to re-writing the
> existant file.
> 
> It's wrong behavior.
> 
> On previous kernel version (pre10) NFS server/clients with the
> same tuning works normally, no access problems detected.
> 
> Bug is application-indepedent and detected both under under KDE
> and MidNight Commander.
> 
> --
> Best regards,
> George
> 
> -------------------------------------------------------
