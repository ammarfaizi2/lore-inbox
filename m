Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266991AbTBSUWj>; Wed, 19 Feb 2003 15:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267188AbTBSUWj>; Wed, 19 Feb 2003 15:22:39 -0500
Received: from smtpzilla5.xs4all.nl ([194.109.127.141]:36874 "EHLO
	smtpzilla5.xs4all.nl") by vger.kernel.org with ESMTP
	id <S266991AbTBSUWj>; Wed, 19 Feb 2003 15:22:39 -0500
Date: Wed, 19 Feb 2003 21:31:58 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: "David S. Miller" <davem@redhat.com>
cc: rusty@rustcorp.com.au, <maxk@qualcomm.com>, <kuznet@ms2.inr.ac.ru>,
       <jt@bougret.hpl.hp.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH/RFC] New module refcounting for net_proto_family 
In-Reply-To: <20030218.230402.113318233.davem@redhat.com>
Message-ID: <Pine.LNX.4.44.0302191525000.32518-100000@serv>
References: <5.1.0.14.2.20030218101309.048d4288@mail1.qualcomm.com>
 <20030219035559.7527A2C079@lists.samba.org> <20030218.230402.113318233.davem@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 18 Feb 2003, David S. Miller wrote:

>    Firstly, the owner field should probably be in struct proto_ops not
>    struct socket, where the function pointers are.
> 
> I think this is one of Alexey's main problems with the
> patch.

BTW the access to sockets_in_use is not preempt safe. Although the data 
has only statistic value, it might be worth to fix this. The easiest 
solution might be to move socket allocation and the create call outside 
the net_family lock. The read lock should at least get a preempt enable/ 
disable (brlock might be another possibilty) and within this lock we can 
safely modify sockets_in_use and do something like net_family_get()/ 
net_family_put() similiar to get_fs_type().

bye, Roman


