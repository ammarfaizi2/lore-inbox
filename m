Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264942AbTGBLuG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 07:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264938AbTGBLuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 07:50:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:65454 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264929AbTGBLuC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 07:50:02 -0400
Date: Wed, 2 Jul 2003 13:04:27 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jan Kratochvil 
	<rcpt-viro.AT.parcelfarce.linux.theplanet.co.uk@jankratochvil.net>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       chaffee@cs.berkeley.edu, zippel@linux-m68k.org
Subject: Re: [PATCH] vfat+affs case preservation
Message-ID: <20030702120426.GU27348@parcelfarce.linux.theplanet.co.uk>
References: <20030702102538.GA16711@exuhome.dyn.jankratochvil.net> <20030702103457.GS27348@parcelfarce.linux.theplanet.co.uk> <20030702105328.GA17023@exuhome.dyn.jankratochvil.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030702105328.GA17023@exuhome.dyn.jankratochvil.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 12:53:28PM +0200, Jan Kratochvil wrote:
> > Broken.   With that we can get two active dentries for the same directory.
> > There goes any cache coherency, with all usual results.
> 
> Right, this patch will introduce virtual directory hardlinks - multiple dentries
> to one directory inode. But it also makes dentry validation mandatory for such
> filesystems to fix it.

Obvious example of bad behaviour:

# mkdir A
# ls A
# mount -t iso9600 /dev/cdrom A
# touch a/b
# ls a/b
a/b
# ls A/b
ls: A/b: No such file or directory
# umount A
# ls A/b
A/b
#
