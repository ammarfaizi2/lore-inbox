Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262383AbTEMTqJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 15:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbTEMTqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 15:46:09 -0400
Received: from mail.gmx.de ([213.165.65.60]:13088 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262383AbTEMTqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 15:46:08 -0400
Message-ID: <3EC14E6D.7020602@gmx.net>
Date: Tue, 13 May 2003 21:58:37 +0200
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021126
X-Accept-Language: de, en
MIME-Version: 1.0
To: Pablo Donzis <pablodonzis@anvet.com.ar>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3 file deletion
References: <1052844347.3ec1213b111b1@webmail.netizen.com.ar>
In-Reply-To: <1052844347.3ec1213b111b1@webmail.netizen.com.ar>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pablo Donzis wrote:
> Hi,
> 
> I have just made a mess. I deleted some important files on my ext3fs.
> Have you ever found a solution to undeletion issue in ext3?
> I'm in a real hurry.

This is not a real solution - more of a starting point. If you have
enough free space on *ANOTHER* partition, try to make a backup of the
partition that contains the filesystem *before* unmounting it.

If /foo is the mount point of the ext3fs with the deleted files
If /foo sits on /dev/hda5
If /bar has enough free space to hold a partition image of /dev/hda5

issue the following command:

dd if=/dev/hda5 of=/bar/image

and try to recover the data from the image. If the files are really
important, you can try to e2fsck the *image file* and attack it with
undeletion utilities (probably won't work) or mark all free blocks used
by hand, e2fsck the image file again and pick up the mess from /lost+found.


HTH,
Carl-Daniel
-- 
http://www.hailfinger.org/

