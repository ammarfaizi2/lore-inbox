Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261193AbVCWHN3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261193AbVCWHN3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 02:13:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262837AbVCWHN3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 02:13:29 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:4521 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261193AbVCWHN0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 02:13:26 -0500
Date: Wed, 23 Mar 2005 08:13:16 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: linux-os <linux-os@analogic.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: lseek on /proc/kmsg
In-Reply-To: <Pine.LNX.4.61.0503221633230.7421@chaos.analogic.com>
Message-ID: <Pine.LNX.4.61.0503230811020.21578@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0503221320090.5551@chaos.analogic.com>
 <Pine.LNX.4.61.0503222020470.32461@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0503221423560.6369@chaos.analogic.com>
 <Pine.LNX.4.61.0503222215310.19826@yvahk01.tjqt.qr>
 <Pine.LNX.4.61.0503221633230.7421@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


1> Sure, read() needs to be modified to respect the file-position
1> set by kmsg_seek(). I don't think you can get away with the
1> call back into do_syslog.

2>I'm not sure that seek makes any sense on that, since it is more like a 
2>pipe than a normal file..

Well, seek(fd, 0, SEEK_END) could be used to flush a pipe's buffers.

0>> +static loff_t kmsg_seek(struct file *filp, loff_t offset, int origin) {
0>> +    if(origin != 2 /* SEEK_END */ || offset < 0) { return -ESPIPE; }
3> "Allow" seeking past the end of the buffer?

Well, what does lseek(fd, >0, SEEK_END) do on normal files?



Jan Engelhardt
-- 
