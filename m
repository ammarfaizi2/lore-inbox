Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262999AbUCSOL2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 09:11:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263005AbUCSOL2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 09:11:28 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:40138 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262999AbUCSOLW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 09:11:22 -0500
Subject: Re: Problem with jfs
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Calin Szonyi <caszonyi@rdslink.ro>
Cc: JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.53.0403172254550.5941@grinch.ro>
References: <Pine.LNX.4.53.0403172254550.5941@grinch.ro>
Content-Type: text/plain
Message-Id: <1079705469.29044.26.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 19 Mar 2004 08:11:09 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-17 at 15:14, caszonyi@rdslink.ro wrote:
> A gnome program crashed and created a file in my home directory which i
> cannot delete. ls says:
> 
> sony@grinch -23:04:01- 0 jobs, ver 2.05b.0 7
>  /~ $ ls
> ls: F?r? titlu 1.CRASHED: No such file or directory
> #pico05941#
> 1
> 1.b
> 1.fvwmrc
> ...

Probably what happened is that the file was created earlier, and now JFS
can't read it now.  The default behavior for JFS recently changed from
using CONFIG_NLS_DEFAULT for the iocharset, to doing no translation
(which is equivalent to iso8859-1).

> mount options for jfs (from /etc/fstab) are:
> /dev/hda6       /                jfs         defaults         1   1
> 
> However in logs jfs says to mount with iocharset=utf8 to access the
> filename.
> 
> My default NLS charset is iso8859-2.
> 
> Why should i mount jfs with iocharset=utf8 ?

You should be able to mount it with iocharset=iso8859-2.  The kernel
prints the utf8 message, since utf8 will allow you to access any
character.  It doesn't know what charset was used to create the file
originally.

> Everytime i use such a buggy program i have to mount jfs with charset=utf8
> to delete that file ? For me this behaviour is silly.

If you intend to use iso8859-2 characters, you can always mount with
iocharset=iso8859-2.  Otherwise, you shouldn't see any new files created
that jfs can't access.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

