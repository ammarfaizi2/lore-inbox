Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267692AbTB1J2e>; Fri, 28 Feb 2003 04:28:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267693AbTB1J2d>; Fri, 28 Feb 2003 04:28:33 -0500
Received: from packet.digeo.com ([12.110.80.53]:14486 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267692AbTB1J2d>;
	Fri, 28 Feb 2003 04:28:33 -0500
Date: Fri, 28 Feb 2003 01:39:43 -0800
From: Andrew Morton <akpm@digeo.com>
To: maneesh@in.ibm.com
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org, zilvinas@gemtek.lt
Subject: Re: kernel Ooops (2.5.63 bk latest)
Message-Id: <20030228013943.025774b0.akpm@digeo.com>
In-Reply-To: <20030228091535.GE11135@in.ibm.com>
References: <20030226113718.GA3568@gemtek.lt>
	<20030228070905.GA11135@in.ibm.com>
	<20030227233434.7ed26b83.akpm@digeo.com>
	<20030228091535.GE11135@in.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Feb 2003 09:38:47.0269 (UTC) FILETIME=[31317950:01C2DF0D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni <maneesh@in.ibm.com> wrote:
>
> ref is taken in d_validate, which is called before using the smbfs cached 
> dentry. It is this ref which is taken back in smb_readdir(). 

hmm, thinking about this a bit more...

It appears that d_validate's role in life is to take some random pointer
which the caller thinks might be a dentry and to verify that it is indeed
still a valid dentry (or a totally new dentry at the same address!).  If
so, pin that dentry and tell the user.

Perhaps the dentry's address was received across the network, although it
doesn't look that way.

In which case passing in a might-be pointer to a zero-ref dentry is
appropriate and your patch is OK.  One would need some understanding of ncpfs
and smbfs to say for sure.

