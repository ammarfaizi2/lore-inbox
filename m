Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289297AbSAVNIi>; Tue, 22 Jan 2002 08:08:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289296AbSAVNI2>; Tue, 22 Jan 2002 08:08:28 -0500
Received: from mailhost.uni-koblenz.de ([141.26.64.1]:45710 "EHLO
	mailhost.uni-koblenz.de") by vger.kernel.org with ESMTP
	id <S289297AbSAVNIY>; Tue, 22 Jan 2002 08:08:24 -0500
Message-Id: <200201221308.g0MD8EY16176@bliss.uni-koblenz.de>
Content-Type: text/plain;
  charset="iso-8859-15"
From: Rainer Krienke <krienke@uni-koblenz.de>
Organization: Uni Koblenz
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: 2.4.17:Increase number of anonymous filesystems beyond 256?
Date: Tue, 22 Jan 2002 14:08:14 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net
In-Reply-To: <mailman.1011275640.16596.linux-kernel2news@redhat.com> <200201221025.g0MAP8Y14023@bliss.uni-koblenz.de> <shszo36pt1h.fsf@charged.uio.no>
In-Reply-To: <shszo36pt1h.fsf@charged.uio.no>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 22. January 2002 11:40, Trond Myklebust wrote:
> >>>>> " " == Rainer Krienke <krienke@uni-koblenz.de> writes:
>      > portmap: connect from 127.0.0.1 to set(nfs): request from
>      > unprivileged port rpc.nfsd: nfssvc: error Permission denied
>      >
>      > A strace of nfsd shows the problem: ...  nfsservctl(0,
>      > 0xbfffeed8, 0) = -1 EACCES (Permission denied) ...
>
> 'man 5 exports'
>
>        secure This option requires that requests originate on  an
>               internet  port  less  than  IPPORT_RESERVED (1024).
>               This option is on by default. To turn it off, spec­
>               ify insecure.

This is not the problem. The exported filesystem is marked insecure. The 
problem is that on the machine running Petes patch you cannot even start the 
kernel nfsd, no matter what /etc/export contains. I f you try to start 
/usr/sbin/rpc.nfsd (the kernel nfsd version) it tries to register with 
portmap and to my interpretation the kernel denies this request with the 
message from above. Since no nfsd can be started I cannot mount any 
filesystem from this host.

So I still think that the reason for this is a check in the kernel, that 
prevents connections from ports > 1024. But where exactly is this done?

Thanks Rainer
-- 
---------------------------------------------------------------------
Rainer Krienke                     krienke@uni-koblenz.de
Universitaet Koblenz, 		   http://www.uni-koblenz.de/~krienke
Rechenzentrum,                     Voice: +49 261 287 - 1312
Rheinau 1, 56075 Koblenz, Germany  Fax:   +49 261 287 - 1001312
---------------------------------------------------------------------
