Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266570AbUAWP71 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 10:59:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266579AbUAWP70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 10:59:26 -0500
Received: from [63.81.117.28] ([63.81.117.28]:46860 "HELO cyber1hq.adic.com")
	by vger.kernel.org with SMTP id S266570AbUAWP7U convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 10:59:20 -0500
Message-ID: <4011440C.4070803@adic.com>
Date: Fri, 23 Jan 2004 09:55:56 -0600
From: Steve Lord <stephen.lord@adic.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@kth.se>
CC: linux-kernel@vger.kernel.org, Nathan Scott <nathans@sgi.com>,
       davej@redhat.com
Subject: Re: logic error in XFS
References: <E1Ajuub-0000xw-00@adic.com> <yw1xr7xr80wi.fsf@ford.guide>
In-Reply-To: <yw1xr7xr80wi.fsf@adic.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by localhost.localdomain id i0NFtu5N013884
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Måns Rullgård wrote:

>davej@redhat.com writes:
>
>  
>
>>Yet another misplaced ! by the looks..
>>    
>>
>
>Sure looks like it.  When is this code encountered?
>  
>

File system recovery, it is going to insert buffer items out of order in
the recovery sequence which means replay could be out of order.
Its been there since around September by the look of it. Definitely should
be the other way around. Thanks Dave.

Steve

>  
>
>>diff -urpN --exclude-from=/home/davej/.exclude bk-linus/fs/xfs/xfs_log_recover.c linux-2.5/fs/xfs/xfs_log_recover.c
>>--- bk-linus/fs/xfs/xfs_log_recover.c	2003-10-09 01:01:24.000000000 +0100
>>+++ linux-2.5/fs/xfs/xfs_log_recover.c	2004-01-14 07:06:40.000000000 +0000
>>@@ -1553,7 +1553,7 @@ xlog_recover_reorder_trans(
>> 		case XFS_LI_BUF:
>> 		case XFS_LI_6_1_BUF:
>> 		case XFS_LI_5_3_BUF:
>>-			if ((!flags & XFS_BLI_CANCEL)) {
>>+			if (!(flags & XFS_BLI_CANCEL)) {
>> 				xlog_recover_insert_item_frontq(&trans->r_itemq,
>> 								itemq);
>> 				break;
>>    
>>
>
>  
>


-- 
Steve Lord <Stephen.Lord@adic.com>                Tel: 952-882-0619

