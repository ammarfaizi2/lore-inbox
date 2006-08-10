Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161404AbWHJQLL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161404AbWHJQLL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 12:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161419AbWHJQLK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 12:11:10 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:41957 "EHLO
	palinux.external.hp.com") by vger.kernel.org with ESMTP
	id S1161415AbWHJQLI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 12:11:08 -0400
Date: Thu, 10 Aug 2006 10:11:07 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: Neil Brown <neilb@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Urgent help needed on an NFS question, please help!!!
Message-ID: <20060810161107.GC4379@parisc-linux.org>
References: <4ae3c140608092204n1c07152k52010a10e209bb77@mail.gmail.com> <17626.49136.384370.284757@cse.unsw.edu.au> <4ae3c140608092254k62dce9at2e8cdcc9ae7a6d9f@mail.gmail.com> <17626.52269.828274.831029@cse.unsw.edu.au> <4ae3c140608100815p57c0378kfd316a482738ee83@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140608100815p57c0378kfd316a482738ee83@mail.gmail.com>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2006 at 11:15:57AM -0400, Xin Zhao wrote:
> I am considering another possibility: suppose client C1 does lookup()
> on file X and gets a file handle, which include inode number,
> generation number and parent's inode number. Before C1 issues
> getattr(), C2 move the parent directory to a different place, which
> will not change the parent's inode number, neither the file X's inode,
> i_generation. So when C1 issues a getattr() request with this file
> handle, the server seems to have no way to detect that file X is not
> existent at the original path. Instead, the server will returns the
> moved X's attributes, which are correct, but semantically wrong. Is
> there any way that server deal with this problem?

It isn't semantically wrong.  There is no way for the application to
distinguish between the events:

open()
stat()
	mv

and

open()
	mv
stat()

As long as the results are consistent with the former case, it doesn't
matter if the latter case actually happened.
