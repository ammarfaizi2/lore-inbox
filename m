Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263695AbTKACfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 21:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263700AbTKACfw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 21:35:52 -0500
Received: from hawk.mail.pas.earthlink.net ([207.217.120.22]:6876 "EHLO
	hawk.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id S263695AbTKACfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 21:35:51 -0500
Subject: md wierdness with 2.6.0test9
From: Brad Langhorst <brad@langhorst.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1067654148.19557.409.camel@up>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 31 Oct 2003 21:35:48 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a pretty simple little raid 1 

/dev/hda1 and /dev/hdc1 should be mirrors of each other.

i created the raid like this

mdadm --create --level 1 -n 2 /dev/md0 /dev/hdc1 missing
(this is from memory - just to give you an idea of how this happened)

i also created /dev/md1 for swap
mdadm --create --level 1 -n 2 /dev/md1 /dev/hdc2 /dev/hda2


now when i go to add /dev/hda1 to the array all looks fine

mdadm --zero-superblock /dev/hda1

mdadm --add /dev/md0 /dev/hda1

array syncs up but i see this wierdness (it exists across reboots)
from mdadm --details /dev/md0

Number 	Major 	Minor 	RaidDevice	State
0	22	1	0		active sync /dev/hdc1
1	0	0	-1		removed
2	3	1	1		spare /dev/hda1

rebooting to a 2.4 series kernel appears to fix this problem...

In my search for information I read this post
http://groups.google.com/groups?hl=en&lr=&ie=UTF-8&oe=utf-8&threadm=rvg0.5x4.17%40gated-at.bofh.it&rnum=4&prev=/groups%3Fq%3Dmdadm%2Bfaulty%2Bremoved%26hl%3Den%26lr%3D%26ie%3DUTF-8%26oe%3Dutf-8%26selm%3Drvg0.5x4.17%2540gated-at.bofh.it%26rnum%3D4
which talks about patching md.c to fix a similar problem...

In test9 the patch discussed is already applied 
so it either doesn't fix the problem or this problem is not the same
problem 

best wishes

brad





