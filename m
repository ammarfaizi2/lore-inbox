Return-Path: <linux-kernel-owner+w=401wt.eu-S964906AbWLMM3g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWLMM3g (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 07:29:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964911AbWLMM3g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 07:29:36 -0500
Received: from plusavs02.SBG.AC.AT ([141.201.10.77]:60545 "HELO
	plusavs02.sbg.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S964906AbWLMM3f (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 07:29:35 -0500
Subject: Re: get device from file struct
From: Silviu Craciunas <silviu.craciunas@sbg.ac.at>
Reply-To: silviu.craciunas@sbg.ac.at
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0612131200430.25870@yvahk01.tjqt.qr>
References: <1165850548.30185.18.camel@ThinkPadCK6>
	 <457DA4A0.4060108@ens-lyon.org> <1165914248.30185.41.camel@ThinkPadCK6>
	 <Pine.LNX.4.61.0612131059100.25870@yvahk01.tjqt.qr>
	 <1166006239.30185.66.camel@ThinkPadCK6>
	 <Pine.LNX.4.61.0612131200430.25870@yvahk01.tjqt.qr>
Content-Type: text/plain
Date: Wed, 13 Dec 2006 13:28:59 +0100
Message-Id: <1166012939.30185.77.camel@ThinkPadCK6>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Dec 2006 12:29:26.0122 (UTC) FILETIME=[53BC74A0:01C71EB2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-12-13 at 12:03 +0100, Jan Engelhardt wrote:
> >> >thanks for the reply, the block device can be determined with the major
> >> >and minor numbers , what I would be more interested in is if one can get
> >> >the net_device struct from the file struct
> >> 
> >> Just how are you supposed to match files and network devices?
> >> 
> >
> >from the struct file you can get the struct socket and from there to the
> >struct sock .
> 
> That only applies when using PF_LOCAL sockets.
> 
> >What I would like to find out is where the data is coming
> >from (read) and where it is going to(write) or if it is even possible to
> >find the net device out using the struct file.
> 
> I really don't get what you want.
> 
> Suppose a daemon reads from a socket (PF_INET), then there is a file descriptor
> to sockfs (look into /proc/$$/fd/). Well, then you may be able to get the
> struct file for that socket, but it does not connect to a regular file
> (S_IFREG) at all.
> 
> 
> 	-`J'

in fs/read_write.c, the vfs_read function does:

file->f_op->read(file, buf, count, pos);

after this call is it possible to determine where the
data is coming from? e.g., the first hard disk, a pipe
or from a socket. If it is a socket we are interested
from which device (eth0, eth1, lo, ...) the data was received.

silviu

