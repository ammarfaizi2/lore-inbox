Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262442AbVCCKej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262442AbVCCKej (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 05:34:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262486AbVCCKcq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 05:32:46 -0500
Received: from hermine.aitel.hist.no ([158.38.50.15]:64783 "HELO
	hermine.aitel.hist.no") by vger.kernel.org with SMTP
	id S262442AbVCCKcM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 05:32:12 -0500
Message-ID: <4226E85E.6070407@aitel.hist.no>
Date: Thu, 03 Mar 2005 11:35:10 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0 (X11/20050116)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Helge Hafting <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc5-mm1 nfs oddity, file creation => "no such file"
References: <20050302191427.GA9383@hh.idb.hist.no> <20050302133703.65e0b8f3.akpm@osdl.org>
In-Reply-To: <20050302133703.65e0b8f3.akpm@osdl.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>Helge Hafting <helgehaf@aitel.hist.no> wrote:
>  
>
>>I observed an oddity on a nfs-mounted fs while using 2.6.11-rc5-mm1.
>>    
>>
>
>Could you try this please?
>
>--- 25/fs/nfs/nfs3proc.c~nfsacl-acl-umask-handling-workaround-in-nfs-client-fix	2005-03-02 08:49:59.000000000 -0800
>+++ 25-akpm/fs/nfs/nfs3proc.c	2005-03-02 08:49:59.000000000 -0800
>@@ -423,6 +423,9 @@ exit:
> 		if (!inode)
> 			goto out;
> 		status = nfs3_set_default_acl(dir, inode, mode);
>+		if (status)
>+			goto out;
>+		return inode;
> 	}
> out:
> 	return ERR_PTR(status);
>_
>
>  
>
"cat > some_new_file" worked fine on NFS with this patch.  I'll keep using
nfs at work with this.

Helge Hafting
