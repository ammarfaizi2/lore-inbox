Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264786AbSLFQqQ>; Fri, 6 Dec 2002 11:46:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264797AbSLFQqK>; Fri, 6 Dec 2002 11:46:10 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:11144 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264745AbSLFQox>; Fri, 6 Dec 2002 11:44:53 -0500
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20021206161519.A16341@parcelfarce.linux.theplanet.co.uk>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Matthew Wilcox <willy@debian.org>
Subject: Re: [PATCH] 2.5.50: unused code in link_path_walk()
Date: Fri, 06 Dec 2002 17:52:13 +0100
Message-ID: <87of7zqede.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox <willy@debian.org> writes:

> @@ -700,7 +700,6 @@
>                                  if (this.name[1] != '.')
>                                          break;
>                                  follow_dotdot(&nd->mnt, &nd->dentry);
> -				inode = nd->dentry->d_inode;
>                                  /* fallthrough */
>                          case 1:
>                                  goto return_base;
>
> seems broken to me.  if follow_dotdot() changes nd->dentry (can happen!),
> inode needs to be changed.  look:
>
>         inode = nd->dentry->d_inode;
>         for(;;) {
>                 err = exec_permission_lite(inode);
>                 if (this.name[0] == '.') switch (this.len) {
>                         case 2: 
>                                 if (this.name[1] != '.')
>                                         break;
>                                 follow_dotdot(&nd->mnt, &nd->dentry);
>                                 inode = nd->dentry->d_inode;
>                                 /* fallthrough */
>                         case 1:
>                                 continue;
>                 }
>         }

You looked at the _first_ switch statement. You must go further down
to the _second_ switch. *There*, you don't need this assignment, AFAICS.

> btw, you should cc linux-fsdevel for patches to the VFS.

Thanks for this pointer, I'll spam linux-fsdevel in the future ;-).

Regards, Olaf.
