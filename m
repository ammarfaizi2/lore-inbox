Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUAFVfc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 16:35:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265346AbUAFVfc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 16:35:32 -0500
Received: from [217.73.129.129] ([217.73.129.129]:8594 "EHLO linuxhacker.ru")
	by vger.kernel.org with ESMTP id S264949AbUAFVf2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 16:35:28 -0500
Date: Tue, 6 Jan 2004 23:35:10 +0200
Message-Id: <200401062135.i06LZAOY005429@car.linuxhacker.ru>
From: Oleg Drokin <green@linuxhacker.ru>
Subject: Re: Suspected bug infilesystems (UFS,ADFS,BEFS,BFS,ReiserFS) related to sector_t being unsigned, advice requested
To: linux-kernel@vger.kernel.org, mfedyk@matchmail.com
References: <Pine.LNX.4.56.0401052343350.7407@jju_lnx.backbone.dif.dk> <3FFA7717.7080808@namesys.com> <Pine.LNX.4.56.0401061218320.7945@jju_lnx.backbone.dif.dk> <20040106174650.GD1882@matchmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

Mike Fedyk <mfedyk@matchmail.com> wrote:
MF> On Tue, Jan 06, 2004 at 12:28:34PM +0100, Jesper Juhl wrote:
>> --- linux-2.6.1-rc1-mm2-orig/fs/reiserfs/inode.c        2004-01-06 01:33:08.000000000 +0100
>> +++ linux-2.6.1-rc1-mm2/fs/reiserfs/inode.c     2004-01-06 12:16:16.000000000 +0100
>> @@ -574,11 +574,6 @@ int reiserfs_get_block (struct inode * i
>>      th.t_trans_id = 0 ;
>>      version = get_inode_item_key_version (inode);
>> 
>> -    if (block < 0) {
>> -       reiserfs_write_unlock(inode->i_sb);
>> -       return -EIO;
>> -    }
>> -
MF> Did you check the locking after this is removed?

Locking should be fine.
As I remember, we take this lock near reiserfs_get_block() entrance,
and then drop it on exit.

MF> Maybe after the sector_t merges, this code covered a case that is left open
MF> now...

This code was never executing anyway.

Bye,
    Oleg
