Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262433AbUKDUgO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262433AbUKDUgO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 15:36:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUKDUft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 15:35:49 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:45508 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S262410AbUKDUfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 15:35:16 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
Subject: Re: [patch 2.4.28-rc1] Avoid oops in proc_delete_inode 
In-reply-to: Your message of "Thu, 04 Nov 2004 16:29:17 BST."
             <200411041629.17443@WOLK> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 05 Nov 2004 07:35:05 +1100
Message-ID: <11726.1099600505@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Nov 2004 16:29:17 +0100, 
Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com> wrote:
>On Thursday 04 November 2004 03:35, Keith Owens wrote:
>
>Marcelo,
>
>I just saw you applied this to bk. Cool, but please apply a right version ;)
>
>> Under heavy load, vmstat, top and other programs that access /proc can
>> oops.  PROC_INODE_PROPER(inode) is sometimes false for pid entries
>> (usually zombies), but inode->u.generic_ip is not NULL.
>>
>> Backport a fix by AL Viro from 2.5.7-pre2 to 2.4.28-rc1.
>>
>> Signed-off-by: Keith Owens <kaos@sgi.com>
>>
>> Index: 2.4.28-rc1/fs/proc/base.c
>> ===================================================================
>> --- 2.4.28-rc1.orig/fs/proc/base.c 2004-08-08 10:10:49.000000000 +1000
>> +++ 2.4.28-rc1/fs/proc/base.c 2004-11-04 13:25:16.402602459 +1100
>> @@ -780,6 +780,7 @@ out:
>>   return inode;
>>
>>  out_unlock:
>> + node->u.generic_ip = NULL;
>
>has to be:
>
>  + inode->u.generic_ip = NULL;
>
>>   iput(inode);
>>   return NULL;
>>  }

Oops, copied the old patch into the mail.  Where did I put that brown
paper bag?

