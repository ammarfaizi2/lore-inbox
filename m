Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbTLJHt7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 02:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbTLJHt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 02:49:59 -0500
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:38535 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262940AbTLJHt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 02:49:56 -0500
To: linux-kernel@vger.kernel.org
Subject: NFS errors in 2.6
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 10 Dec 2003 16:49:48 +0900
Message-ID: <buobrqhun6r.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My home directory is NFS-mounted from a Solaris server like:

   mccfs10:/mccfs10-4/soft1 /home/soft1	nfs	nfsvers=3,rsize=1024,wsize=1024,noatime,nodiratime	0	0

everything works peachy with linux 2.4.23, and _mostly_ works in linux
2.6.0-test11, but the latter cannot read certain directories; for instance,
if I do `ls -l .gconf' in my homedir, I get an `Invalid Argument' error.

Here's what the directory looks like (in 2.4.23):

   $ ls -ld .gconf
   drwxr-xr-x    6 miles         512 Dec 10 14:15 .gconf
   $ ls -l .gconf
   total 3
   -rw-------    1 miles          31 Oct 29  2002 %gconf.xml
   drwx------   19 miles        1024 Aug 26 10:30 apps
   drwx------    3 miles         512 Oct 29  2002 desktop
   drwx------    4 miles         512 Oct 29  2002 schemas
   drwx------    4 miles         512 Jan 24  2003 system

In 2.6.0-test11, both of those commands fail like:

   $ ls -l .gconf
   ls: .gconf: Invalid Argument

[not sure of the precise syntax of the error message]


I have a packet capture of a failing `ls -l' command like the above;
here's the final packet (previous packets don't seem to have any errors):


Frame 22 (158 bytes on wire, 158 bytes captured)
Ethernet II, Src: 00:01:30:e9:cb:00, Dst: 00:03:47:97:9b:18
Internet Protocol, Src Addr: mccfs10.ucom.lsi.nec.co.jp (10.30.120.156), Dst Addr: mcspd15.ucom.lsi.nec.co.jp (10.30.114.174)
User Datagram Protocol, Src Port: 2049 (2049), Dst Port: 800 (800)
Remote Procedure Call, Type:Reply XID:0x0e72455c
    XID: 0xe72455c (242369884)
    Message Type: Reply (1)
    Program: NFS (100003)
    Program Version: 3
    Procedure: READDIRPLUS (17)
    Reply State: accepted (0)
    This is a reply to a request in frame 21
    Time from request: 0.001394000 seconds
    Verifier
        Flavor: AUTH_NULL (0)
        Length: 0
    Accept State: RPC executed successfully (0)
Network File System, READDIRPLUS Reply  Error:ERR_INVAL
    Program Version: 3
    V3 Procedure: READDIRPLUS (17)
    Status: ERR_INVAL (22)
    dir_attributes
        attributes_follow: value follows (1)
        attributes
            Type: Directory (2)
            mode: 040755
                0... .... .... = not SUID
                .0.. .... .... = not SGID
                ..0. .... .... = not save swapped text
                ...1 .... .... = Read permission for owner
                .... 1... .... = Write permission for owner
                .... .1.. .... = Execute permission for owner
                .... ..1. .... = Read permission for group
                .... ...0 .... = no Write permission for group
                .... .... 1... = Execute permission for group
                .... .... .1.. = Read permission for others
                .... .... ..0. = no Write permission for others
                .... .... ...1 = Execute permission for others
            nlink: 6
            uid: 31295
            gid: 10125
            size: 512
            used: 512
            rdev: 0,0
                specdata1: 0
                specdata2: 0
            fsid: 289359024837623808
            fileid: 4091573
            atime: Dec  9, 2003 13:34:07.040759000
                seconds: 1070944447
                nano seconds: 40759000
            mtime: Dec  9, 2003 12:47:36.827032000
                seconds: 1070941656
                nano seconds: 827032000
            ctime: Dec  9, 2003 12:47:36.827032000
                seconds: 1070941656
                nano seconds: 827032000


Any suggestions?

Thanks,

-Miles
-- 
[|nurgle|]  ddt- demonic? so quake will have an evil kinda setting? one that
            will  make every christian in the world foamm at the mouth?
[iddt]      nurg, that's the goal
