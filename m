Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264123AbTKZKLu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Nov 2003 05:11:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264126AbTKZKLu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Nov 2003 05:11:50 -0500
Received: from 0x503e3f58.boanxx7.adsl-dhcp.tele.dk ([80.62.63.88]:33164 "HELO
	mail.hswn.dk") by vger.kernel.org with SMTP id S264123AbTKZKLR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Nov 2003 05:11:17 -0500
To: linux-kernel@vger.kernel.org
Path: not-for-mail
From: Henrik Storner <henrik-kernel@hswn.dk>
Newsgroups: linux.kernel
Subject: Re: 2.4.20-18 size-4096 memory leaks
Date: Wed, 26 Nov 2003 10:11:15 +0000 (UTC)
Organization: Linux Users Inc.
Message-ID: <bq1u83$pcu$1@ask.hswn.dk>
References: <BAY2-F65DwLK4adtttY00010f98@hotmail.com>
NNTP-Posting-Host: osiris.hswn.dk
X-Trace: ask.hswn.dk 1069841475 26014 172.16.10.100 (26 Nov 2003 10:11:15 GMT)
X-Complaints-To: news@ask.hswn.dk
NNTP-Posting-Date: Wed, 26 Nov 2003 10:11:15 +0000 (UTC)
User-Agent: nn/6.6.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In <BAY2-F65DwLK4adtttY00010f98@hotmail.com> "yuval yeret" <yuval_yeret@hotmail.com> writes:

>I'm seeing a constant leak in size-4096 on a machine running 2.4.20-18 SMP 
>BIGMEM, which might / might not be related to the machine finally going out 
>of memory and going into a hang.

This sounds like one of the Red Hat kernels - those are immensely
patched and very different from the original Linux kernels normally
discussed here.

However ...

>I saw a discussion around similar problems in 2.6.0 (2.6.0-test5/6 (and 
>probably 7 too) size-4096 memory leak - http://lkml.org/lkml/2003/10/17/5 )
>and an ext3 patch was suggested by Andrew Morton.

>From a brief look the code in 2.4 it seems like the patch might be relevant 
>here as well. Is the size-4096 leak a known issue for 2.4 ?
>Is the 2.6 patch applicable in 2.4 as well ?

There definitely is a memory leak in the Red Hat 9 kernels, including
the 2.4.20-20.9smp kernel (seems to be in the uniprocessor build as well).
It leaks mm_struct slabs - see the trend graphs I do from the slabinfo
data, available at 

http://tyge.sslug.dk/bb-cgi/larrd-grapher.cgi?host=tyge.sslug.dk&service=slabinfo

The blue curve is the mm_struct slab allocation (column 5, the "active
pages" column from /proc/slabinfo) - the way it continually grows from
the system is rebooted IMHO points to a memory leak somewhere. This is
very clear from the third graph, which goes back the last 48 days,
during which we had two reboots of the system (hardware related).

The standard kernels from www.kernel.org do not have this problem,
so I am fairly certain it is in one of the Red Hat patches.

Others also see it:
 https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=91090


Henrik
-- 
Henrik Storner <henrik@hswn.dk> 
