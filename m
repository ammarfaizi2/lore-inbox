Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbUHRJvT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbUHRJvT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 05:51:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265196AbUHRJvT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 05:51:19 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:58502 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265234AbUHRJvO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 05:51:14 -0400
Date: Wed, 18 Aug 2004 11:50:59 +0200
To: linux-kernel@vger.kernel.org
Cc: fsteiner-mail@bio.ifi.lmu.de, Ballarin.Marc@gmx.de
Subject: [RFC] New security model for scsi_cmd_ioctl
Message-ID: <20040818095059.GA1899@proton-satura-home>
References: <411FD919.9030702@comcast.net> <20040816231211.76360eaa.Ballarin.Marc@gmx.de> <4121A689.8030708@bio.ifi.lmu.de> <200408171311.06222.satura@proton> <20040817155927.GA19546@proton-satura-home> <41231790.7060806@bio.ifi.lmu.de> <41231CD8.5020300@bio.ifi.lmu.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <41231CD8.5020300@bio.ifi.lmu.de>
User-Agent: Mutt/1.5.6+20040722i
From: Andreas Messer <andreas.messer@gmx.de>
X-ID: EX1UIwZawemIsc+eriBfOb0Z5FeTudCu8YJlzwYkh0bMQYuv4nDJs2@t-dialin.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2004 at 11:09:44AM +0200, Frank Steiner wrote:

> Does it, by the way, make any sense that I report this here? Or will the
> security model have to be desgined first like you discussed it, before
> such tests are helpful? Just to avoid that I flood you with a list of
> blocked commands when you can't make any use of it now :-)

I don't know. The problem, is that the model has completely redesigned to
improve security, as some commands for mmc-drives are necessary 
(like FORMAT) and destructive on harddiscs. Marc and i think, that there 
should be a additional parameter for verify_command, which specifies the 
device class. 
The problem is, that there is now way to detect the device class within the 
functions sg_io and sg_scsi_ioctl or even scsi_cmd_ioctl (which calles the
other functions). So the parameter has to be given to scsi_cmd_ioctl. This
function is called within the kernel from cdrom.c, sd.c, st.c and ide.c but
i'm not sure, if there are another ways to call this function. (i'm not so
familar with the kernel source) If so, there may be no save way to hand 
over the device class. 
Then we need a new acl, based on device class and command. This list seems
to be very large - who maintains it? Perhaps it would be better to have
a linked list with some default values, which may be changed from 
userspace (like iptables). Another problem might be the SCSI sub-commands. 
I'm not sure, if they have to be checked too.

 
Andreas
-- 
gnuPG keyid: 0xE94F63B7 
fingerprint: D189 D5E3 FF4B 7E24 E49D 7638 07C5 924C E94F 63B7
