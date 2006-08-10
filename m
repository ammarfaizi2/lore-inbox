Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbWHJFLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbWHJFLP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 01:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161030AbWHJFLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 01:11:15 -0400
Received: from ns.suse.de ([195.135.220.2]:4055 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161026AbWHJFLP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 01:11:15 -0400
From: Neil Brown <neilb@suse.de>
To: "Xin Zhao" <uszhaoxin@gmail.com>
Date: Thu, 10 Aug 2006 15:11:12 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17626.49136.384370.284757@cse.unsw.edu.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: Urgent help needed on an NFS question, please help!!!
In-Reply-To: message from Xin Zhao on Thursday August 10
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday August 10, uszhaoxin@gmail.com wrote:
> I just ran into a problem about NFS. It might be a fundmental problem
> of my current work. So please help!
> 
> I am wondering how NFS guarantees a client didn't get wrong file
> attributes. Consider the following scenario:
> 
> Suppose we have an NFS server S and two clients C1 and C2.
> 
> Now C1 needs to access the file attributes of file X, it first does
> lookup() to get the file handle of file X.
> 
> After C1 gets X's file handle and before C1 issues the getattr()
> request, C2 cuts in. Now C2 deletes file X and creates a new file X1,
> which has different name but the same inode number and device ID as
> the nonexistent file X.
> 
> When C1 issues getattr() with the old file handle, it may get file
> attribute on wrong file X1. Is this true?
> 
> If not, how NFS avoid this problem? Please direct me to the code that
> verifies this.

Generation numbers.

When the filesystem creates a new file it assigns a random number 
as the 'generation' number and stores that in the inode.
This gets included in the filehandle, and checked when the filehandle
lookup is done.

Look for references to 'i_generation' in fs/ext3/*

Other files systems may approach this slightly differently, but the
filesystem is responsible for providing a unique-over-time filehandle,
and 'generation number' is the 'standard' way of doing this.

NeilBrown
