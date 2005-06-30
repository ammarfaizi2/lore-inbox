Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262898AbVF3Stv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262898AbVF3Stv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Jun 2005 14:49:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbVF3Stv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Jun 2005 14:49:51 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:21926 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S262898AbVF3Sts
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Jun 2005 14:49:48 -0400
Message-ID: <42C43EC9.7090700@namesys.com>
Date: Thu, 30 Jun 2005 22:49:45 +0400
From: Edward Shishkin <edward@namesys.com>
Organization: Namesys
User-Agent: Mozilla/5.0 (X11; U; Linux i686; cs-CZ; rv:1.7.2) Gecko/20040906
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: Hans Reiser <reiser@namesys.com>
CC: Jens Axboe <axboe@suse.de>, linux-kernel@vger.kernel.org,
       reiserfs-list@namesys.com, Andrew Morton <akpm@osdl.org>,
       Vladimir Saveliev <vs@namesys.com>
Subject: Re: [PATCH] reiser BUG in 2.6.13-rc1
References: <20050630101157.GI2243@suse.de> <42C42EFD.8050306@namesys.com>
In-Reply-To: <42C42EFD.8050306@namesys.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hans Reiser wrote:

>Jens Axboe wrote:
>
>  
>
>>Hi,
>>
>>Reiser is derefencing an uninitialized pointer, causing an oops on boot.
>>
>>Signed-off-by: Jens Axboe <axboe@suse.de>
>>
>>diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
>>--- a/fs/reiserfs/super.c
>>+++ b/fs/reiserfs/super.c
>>@@ -1053,10 +1053,9 @@ static void handle_barrier_mode(struct s
>>
>>static void handle_attrs( struct super_block *s )
>>{
>>-	struct reiserfs_super_block * rs;
>>+	struct reiserfs_super_block * rs = SB_DISK_SUPER_BLOCK (s);
>>
>>	if( reiserfs_attrs( s ) ) {
>>-		rs = SB_DISK_SUPER_BLOCK (s);
>>		if( old_format_only(s) ) {
>>			reiserfs_warning(s, "reiserfs: cannot support attributes on 3.5.x disk format" );
>>			REISERFS_SB(s) -> s_mount_opt &= ~ ( 1 << REISERFS_ATTRS );
>>
>> 
>>
>>    
>>
>Thanks Jens.
>
>Edward, how is the fedora boot bug finding going? Is this it by any chance?
>
>Hans
>  
>

FC4-test3 with root on reiserfs has been successfully booted with 
another miniinstall CD,
so it seems that something wrong in grub.
Unfortunately FC was installed on the workstation which currently is 
used for
intensive benchmarking, so the following is still in todo-list:
- hacking grub
- investigating reiserfs+selinux

Thanks,
Edward.

