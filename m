Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262009AbVCVVhL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbVCVVhL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 16:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261997AbVCVVhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 16:37:09 -0500
Received: from ms-smtp-03.texas.rr.com ([24.93.47.42]:38334 "EHLO
	ms-smtp-03-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S262009AbVCVVgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 16:36:11 -0500
Message-ID: <42408FCD.1080303@austin.rr.com>
Date: Tue, 22 Mar 2005 15:36:13 -0600
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesper Juhl <juhl-lkml@dif.dk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][0/6] cifs: readdir.c cleanup
References: <Pine.LNX.4.62.0503222055150.2683@dragon.hyggekrogen.localhost>
In-Reply-To: <Pine.LNX.4.62.0503222055150.2683@dragon.hyggekrogen.localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

>Hi Steve,
>
>Here's one more cleanup for a file in fs/cifs - readdir.c (i'm going to 
>follow the order you told me you'd prefer first, then do the remaining 
>files in arbitrary order).
>I'm going to send the patches inline to make it easy for others to comment 
>if they so choose, but since you had problems with inline patches from me 
>last time I've also placed them online for you :
>
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_readdir-whitespace-cleanup-1.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_readdir-whitespace-cleanup-2.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_readdir-whitespace-cleanup-3.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_readdir-kfree-cleanup.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_readdir-cast-cleanup.patch
>http://www.linuxtux.org/~juhl/kernel_patches/fs_cifs_readdir-whitespace-cleanup-final-bits.patch
>
>(listed in the order they apply)
>
>
>Short description of each patch will be in the email with that patch 
>inline that will follow shortly.
>
>
>  
>
The first looks fine.  I am part way through reviewing the second, and 
so far only found one change (see following) that I question.  I prefer 
to keep the local variables together without a blank line between them.  
Is there a global Linux style compliance issue here?  By the way, it is 
not common to use typedefs but you will see a few in this function since 
the network protocol specification describes the format of the wire 
protocol using them and it makes the structure names match the standard.

 static char *nxt_dir_entry(char *old_entry, char *end_of_smb)
 {
-	char * new_entry;
-	FILE_DIRECTORY_INFO * pDirInfo = (FILE_DIRECTORY_INFO *)old_entry;
+	char *new_entry;
+
+	FILE_DIRECTORY_INFO *pDirInfo = (FILE_DIRECTORY_INFO *)old_entry;

I will apply at least a few of them, but I am busy doing a high priority 
fix to handle split transact2 responses (which could cause an oops in ls 
to some servers so is high priority - although it only occurs on large 
directories, and if the server decides to send two transact responses 
for one request (which is not that common) and a search entry is split 
in certain ways across two SMB responses).
