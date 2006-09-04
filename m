Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964934AbWIDQjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964934AbWIDQjd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 12:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbWIDQjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 12:39:33 -0400
Received: from emailer.gwdg.de ([134.76.10.24]:9109 "EHLO emailer.gwdg.de")
	by vger.kernel.org with ESMTP id S1751480AbWIDQjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 12:39:32 -0400
Date: Mon, 4 Sep 2006 18:35:41 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Steven Whitehouse <swhiteho@redhat.com>
cc: linux-kernel@vger.kernel.org, Russell Cattelan <cattelan@redhat.com>,
       David Teigland <teigland@redhat.com>, Ingo Molnar <mingo@elte.hu>,
       hch@infradead.org
Subject: Re: [PATCH 06/16] GFS2: dentry, export, super and vm operations
In-Reply-To: <1157383622.3384.950.camel@quoit.chygwyn.com>
Message-ID: <Pine.LNX.4.61.0609041832010.28823@yvahk01.tjqt.qr>
References: <1157031245.3384.795.camel@quoit.chygwyn.com> 
 <Pine.LNX.4.61.0609041046380.11217@yvahk01.tjqt.qr>
 <1157383622.3384.950.camel@quoit.chygwyn.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> >+	switch (fh_type) {
>> >+	case 10:
>> >+		parent.no_formal_ino = ((uint64_t)be32_to_cpu(fh[4])) << 32;
>> >+		parent.no_formal_ino |= be32_to_cpu(fh[5]);
>> >+		parent.no_addr = ((uint64_t)be32_to_cpu(fh[6])) << 32;
>> >+		parent.no_addr |= be32_to_cpu(fh[7]);
>> >+		fh_obj.imode = be32_to_cpu(fh[8]);
>> >+	case 4:
>> 
>> What do these constants specify? Would not it be better to have a #define or
>> enum{} for them somewhere?
>
>The sizes of the NFS file handles in units of sizeof(u32). I've added a
>couple of #defines as requested.

A #define/enum is only really useful if more than one place references it.
If this is the only one, just add a comment.

>> >+	if (IS_ERR(inode))
>> >+		return ERR_PTR(PTR_ERR(inode));
>> 
>> Just return inode.
>
>The function returns a dentry, so it would need to be casted and I
>thought that would look "more odd" than this construction.

Yes, it is very odd indeed that you return an inode as a dentry at all. How is
the caller supposed to know whether it was an inode or dentry that was actually
returned?


Jan Engelhardt
-- 
