Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129719AbRCLKc2>; Mon, 12 Mar 2001 05:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129725AbRCLKcT>; Mon, 12 Mar 2001 05:32:19 -0500
Received: from smtp22.singnet.com.sg ([165.21.101.202]:64270 "EHLO
	smtp22.singnet.com.sg") by vger.kernel.org with ESMTP
	id <S129719AbRCLKcI>; Mon, 12 Mar 2001 05:32:08 -0500
Message-ID: <3AACA87D.70C740A8@magix.com.sg>
Date: Mon, 12 Mar 2001 19:44:13 +0900
From: Anthony Heading <anthony@magix.com.sg>
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Should mount --bind not follow symlinks?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    My automounted dirs have up till now been symlinks, where
e.g. /opt/perl defaults to automounting /export/opt/perl/LATEST
which is a symlink.

   This all worked OK until the 2.4(.2) automounter helpfully tries
to mount --bind /export/opt/perl/LATEST /opt/perl

   And this errors with "mount: wrong fs type, ..." because it
seems the first arg to mount --bind mustn't be a symlink,
resulting in a "No such file" or similar error being returned
to the requester.

   What is especially confusing is that if this whole thing
was kicked off with say  ls /opt/perl/bin,  the first attempt
returns "No such file or directory", but automount
then installs a symlink into /opt,  so a second ls attempt
works fine.

   Is this known about / to be expected?  I can't see why
one of automount or mount or the underlying system call
shouldn't chase symlinks, but I know I might be missing
some reason why I shouldn't be attempting this.

Anthony
