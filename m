Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266669AbUF3Ncf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266669AbUF3Ncf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 09:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUF3Nce
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 09:32:34 -0400
Received: from mail.gmx.de ([213.165.64.20]:51392 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266677AbUF3NcA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 09:32:00 -0400
Date: Wed, 30 Jun 2004 15:31:59 +0200 (MEST)
From: "Michael Kerrisk" <mtk-lkml@gmx.net>
To: Jacky Malcles <Jacky.Malcles@bull.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <40E2B795.35EA5824@bull.net>
Subject: Re: A question about extended attributes of filesystem objects (setfattr command)
X-Priority: 3 (Normal)
X-Authenticated: #23581172
Message-ID: <17330.1088602319@www51.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gidday,

> I have a question regarding
>  Attributes of symlinks vs. the files pointed to
> 
> If I try to attach name:value pair to object symlink file
> then I'll get: "Operation not permitted"

What file system are you using?  If ext2, ext3 (or patched kernel 
supporting Reiserfs EAs), did you mount with "-o user_xattr?
(The above error suggests you haven't used this option.)

> reading the man pages of setfattr (or attr) I thought that it operates
> on the attributes of  the  symbolic link itself.

No, these commands follow symbolic links.

> show:
> -----
> touch f
> ln -s f l
> setfattr -n user.filename -v ascii1 f l
> setfattr -h -n user.filename  -v ascii2 f
> getfattr -d f l
> setfattr -h -n user.filename  -v ascii3 l
> setfattr -h --no-dereference -n user.filename  -v ascii4 l
> getfattr -d f l
> 
> so, my question is : what is expected ?

attr(5) specifically notes that USER EAs are disallowed on 
symbolic links, but this is rather an issu that affects the 
use of lsetxattr(2).

Cheers,

Michael

-- 
"Sie haben neue Mails!" - Die GMX Toolbar informiert Sie beim Surfen!
Jetzt aktivieren unter http://www.gmx.net/info

