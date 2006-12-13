Return-Path: <linux-kernel-owner+w=401wt.eu-S1751854AbWLNBEo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751854AbWLNBEo (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 20:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751622AbWLNBEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 20:04:44 -0500
Received: from hera.kernel.org ([140.211.167.34]:40966 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbWLNBEn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 20:04:43 -0500
X-Greylist: delayed 4433 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Dec 2006 20:04:42 EST
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: get device from file struct
Date: Wed, 13 Dec 2006 15:53:46 -0800
Organization: OSDL
Message-ID: <20061213155346.0a9ecf20@freekitty>
References: <1165850548.30185.18.camel@ThinkPadCK6>
	<457DA4A0.4060108@ens-lyon.org>
	<1165914248.30185.41.camel@ThinkPadCK6>
	<Pine.LNX.4.61.0612131059100.25870@yvahk01.tjqt.qr>
	<1166006239.30185.66.camel@ThinkPadCK6>
	<Pine.LNX.4.61.0612131200430.25870@yvahk01.tjqt.qr>
	<1166012939.30185.77.camel@ThinkPadCK6>
	<Pine.LNX.4.61.0612132011280.32433@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1166054026 20080 10.8.0.228 (13 Dec 2006 23:53:46 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 13 Dec 2006 23:53:46 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 2.5.0-rc3 (GTK+ 2.10.6; i486-pc-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Dec 2006 20:19:51 +0100 (MET)
Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> 
> >in fs/read_write.c, the vfs_read function does:
> >
> >file->f_op->read(file, buf, count, pos);
> >
> >after this call is it possible to determine where the
> >data is coming from?
> >e.g., the first hard disk, a pipe or from a socket.
> 
> For hard disks:
>   file->f_dentry->d_inode->d_sb->s_bdev gives you the block device
>   in case it is a non-virtual filesystem.
> 
> For pipes/sockets I do not know of a may to go from a filp to a
> struct sock or struct socket.
> 
> >If it is a socket we are interested
> >from which device (eth0, eth1, lo, ...) the data was received.
> 
> I do not think that is possible either.

The connection between file and network device is through many
layers and there is no direct binding. It could be 0 to N interfaces
and even be data dependent.

-- 
Stephen Hemminger <shemminger@osdl.org>
