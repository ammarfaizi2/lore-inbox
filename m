Return-Path: <linux-kernel-owner+w=401wt.eu-S1760698AbWLHNIL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760698AbWLHNIL (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 08:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760697AbWLHNIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 08:08:10 -0500
Received: from ms-smtp-02.southeast.rr.com ([24.25.9.101]:36931 "EHLO
	ms-smtp-02.southeast.rr.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760695AbWLHNIH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 08:08:07 -0500
Message-ID: <457963B3.3080801@poochiereds.net>
Date: Fri, 08 Dec 2006 08:08:03 -0500
From: Jeff Layton <jlayton@poochiereds.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] ensure unique i_ino in filesystems without permanent
 inode numbers (libfs superblock cleanup)
References: <457891F4.8030501@redhat.com> <20061208061641.GA24255@filer.fsl.cs.sunysb.edu>
In-Reply-To: <20061208061641.GA24255@filer.fsl.cs.sunysb.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josef Sipek wrote:
 >> -	ret = simple_fill_super(sb, IPATHFS_MAGIC, files);
 >> +	ret = simple_fill_super(sb, IPATHFS_MAGIC, files, 1);
 >
 > I don't know...the magic looking 1 and 0 (later in the patch) seem a bit
 > arbitrary. Maybe a #define is in order?

Yeah, I'm not fond of that, though the comments on simple_fill_super should
explain it. Basically, I need simple_fill_super to operate in two different
"modes", and I was using the extra flag to key this. I'm not clear on what
sort of #define would make sense here. Can you suggest something?

 >> -int simple_fill_super(struct super_block *s, int magic, struct tree_descr
 >> *files)
 >> +/*
 >> + * Some filesystems require that particular entries have particular i_ino
 >> values. Those
 >> + * callers need to set the "seq" flag to make sure that i_ino is assigned
 >> sequentially
 >> + * to the files starting with 0.
 >> + */
 >> +int simple_fill_super(struct super_block *s, int magic, struct tree_descr
 >> *files, int seq)
 >
 > Line wraped.
 >

I thought those were under 80 columns but perhaps they weren't. I'll clean
them up and repost, once you clarify what you'd like to see in the #define.

 >> @@ -399,7 +407,10 @@ int simple_fill_super(struct super_block
 >>  		inode->i_blocks = 0;
 >>  		inode->i_atime = inode->i_mtime = inode->i_ctime =
 >>  		CURRENT_TIME;
 >
 > I'd indent CURRENT_TIME a bit.

I wasn't planning on touching those parts of the code that don't need to be
changed, since formatting deltas can make it harder to see the "actual"
changes in the patch. That should probably be addressed in a follow-on
patch if you think it needs to be changed.

-- Jeff Layton
