Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264276AbTFDXBP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 19:01:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264277AbTFDXBP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 19:01:15 -0400
Received: from smtp-out.comcast.net ([24.153.64.113]:33833 "EHLO
	smtp-out.comcast.net") by vger.kernel.org with ESMTP
	id S264276AbTFDXBN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 19:01:13 -0400
Date: Wed, 04 Jun 2003 19:09:14 -0400
From: Albert Cahalan <albert@users.sf.net>
Subject: Re: another must-fix: major PS/2 mouse problem
In-reply-to: <20030604011413.16787964.akpm@digeo.com>
To: Andrew Morton <akpm@digeo.com>
Cc: Vojtech Pavlik <vojtech@ucw.cz>, linux-yoann@ifrance.com,
       linux-kernel <linux-kernel@vger.kernel.org>, vojtech@suse.cz
Message-id: <1054768154.22088.5286.camel@cube>
Organization: 
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.2.4
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <1054431962.22103.744.camel@cube> <3EDD87FD.6020307@ifrance.com>
 <20030603232155.1488c02f.akpm@digeo.com> <20030604094737.C5345@ucw.cz>
 <20030604005302.41f3b0b8.akpm@digeo.com> <20030604100017.A5475@ucw.cz>
 <20030604011413.16787964.akpm@digeo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-06-04 at 04:14, Andrew Morton wrote:
> Vojtech Pavlik <vojtech@ucw.cz> wrote:

> >> Has this problem been observed in 2.4 kernels?
> > 
> >  No, since 2.4 doesn't have the re-sync code in the mouse driver which is
> >  triggering in this case. But problems with the machine being flooded
> >  with interrupts from the NIC so hard that it actually cannot do anything
> >  are quite common.
> 
> So is the resync code doing more good than harm?

The log message is useful.

I think the resync code is a bit like the OOM killer.
We need it, but something is wrong if it ever gets used.
It also doesn't quite work the way it should.

Anyway...

I only get the problem with NFS traffic. It may be
that NFS traffic is the only way I've yet found to
generate extreme network usage though.

The system with problems is an NFSv3 client that
gets abused by an in-house version control system
based on SCCS. I suppose this is like running
"tar xf foo.tar" or "tar xf foo.tar foo" over NFS.

The hardware is:

Pentium III (Coppermine)
1002.822 MHz
Apollo chipset

# lspci -s 00:0d.0 -v
00:0d.0 Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado]
(rev 74)
        Subsystem: 3Com Corporation 3C905C-TX Fast Etherlink for PC
Management NIC
        Flags: bus master, medium devsel, latency 32, IRQ 11
        I/O ports at ec00 [size=128]
        Memory at df000000 (32-bit, non-prefetchable) [size=128]
        Expansion ROM at <unassigned> [disabled] [size=128K]
        Capabilities: [dc] Power Management version 2

# nfsstat -c       
Client rpc stats:
calls      retrans    authrefrsh
118380     7843       0       
Client nfs v2:
null       getattr    setattr    root       lookup     readlink   
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
read       wrcache    write      create     remove     rename     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 
link       symlink    mkdir      rmdir      readdir    fsstat     
0       0% 0       0% 0       0% 0       0% 0       0% 0       0% 

Client nfs v3:
null       getattr    setattr    lookup     access     readlink   
0       0% 12501  10% 114     0% 68765  58% 25538  21% 4       0% 
read       write      create     mkdir      symlink    mknod      
8830    7% 725     0% 377     0% 3       0% 1       0% 0       0% 
remove     rmdir      rename     link       readdir    readdirplus
498     0% 0       0% 367     0% 173     0% 0       0% 10      0% 
fsstat     fsinfo     pathconf   commit     
2       0% 2       0% 0       0% 470     0% 


