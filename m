Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262864AbTLJNdw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 08:33:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTLJNdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 08:33:52 -0500
Received: from pat.uio.no ([129.240.130.16]:14251 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S262864AbTLJNdu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 08:33:50 -0500
To: Miles Bader <miles@gnu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS errors in 2.6
References: <buobrqhun6r.fsf@mcspd15.ucom.lsi.nec.co.jp>
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Date: 10 Dec 2003 08:33:24 -0500
In-Reply-To: <buobrqhun6r.fsf@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <shsu148ajbv.fsf@guts.uio.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-MailScanner-Information: This message has been scanned for viruses/spam. Contact postmaster@uio.no if you have questions about this scanning
X-UiO-MailScanner: No virus found
X-UiO-Spam-info: not spam, SpamAssassin (score=-4.9, required 12,
	BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Miles Bader <miles@lsi.nec.co.jp> writes:

     > My home directory is NFS-mounted from a Solaris server like:
     >    mccfs10:/mccfs10-4/soft1 /home/soft1 nfs
     >    nfsvers=3,rsize=1024,wsize=1024,noatime,nodiratime 0 0

(BTW: noatime and nodirtime don't make sense in an NFS
environment. There is no way to notify the server not to update
attributes)

     > Frame 22 (158 bytes on wire, 158 bytes captured) Ethernet II,
     > Src: 00:01:30:e9:cb:00, Dst: 00:03:47:97:9b:18 Internet
     > Protocol, Src Addr: mccfs10.ucom.lsi.nec.co.jp (10.30.120.156),
     > Dst Addr: mcspd15.ucom.lsi.nec.co.jp (10.30.114.174) User
     > Datagram Protocol, Src Port: 2049 (2049), Dst Port: 800 (800)
     > Remote Procedure Call, Type:Reply XID:0x0e72455c
     >     XID: 0xe72455c (242369884) Message Type: Reply (1) Program:
     >     NFS (100003) Program Version: 3 Procedure: READDIRPLUS (17)
     >     Reply State: accepted (0) This is a reply to a request in
     >     frame 21 Time from request: 0.001394000 seconds Verifier
     >         Flavor: AUTH_NULL (0) Length: 0
     >     Accept State: RPC executed successfully (0)
     > Network File System, READDIRPLUS Reply Error:ERR_INVAL
     >     Program Version: 3 V3 Procedure: READDIRPLUS (17) Status:
     >     ERR_INVAL (22) dir_attributes

Interesting. That actually looks like an error on the part of your
Solaris server. NFS3ERR_INVAL is not a valid return code for either
READDIR or for READDIRPLUS according to RFC1813.

Is the server being kept up to scratch on the patch side?

Cheers,
  Trond
