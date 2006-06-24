Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752270AbWFXPPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752270AbWFXPPE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752281AbWFXPPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:15:04 -0400
Received: from ug-out-1314.google.com ([66.249.92.169]:59818 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752270AbWFXPPD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:15:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Lbi7cQCmWz4ddoFHYB7gtT3Oywy6Hoa53Ivpym/eImYIAQYAHjjP1WaNM6tcww0dOkeW54/qkimvlAdaeSIOzrAHG9ky8J3kSwCHPWDuNDkIxaqyNCltxFvdEdFWNMRcaJVpC/hJpwA4gCA9VDTayJ9szEYetdPdcBx3Px3ckxg=
Date: Sat, 24 Jun 2006 19:15:31 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.17-...: looong writeouts
Message-ID: <20060624151531.GA7565@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Immediate problem: from time to time post 2.6.17 kernel [1] decides that it
really really needs disk.

	[kernel compilation goes as usual]
	  CC [M]  fs/xfs/xfs_inode.o
	[compilation blocks for ~10 seconds, disk LED is red]
	[then it continues]

Again, from time to time saving 2k file makes vi inoperational for same
period.

Scheduler is CFQ, fs is reiserfs mounted with noatime, notail. 2.6.17-rc
and 2.6.17 kernels were OK.

It occured only several times in 4 hours.

[1] 2.6.17-95eaa5fa8eb2c345244acd5f65b200b115ae8c65 to be precise


Probably related problem below:

During 2.6.17-rc cycle CFQ subjectively became less F.

	[   unpacking  ]
	[kernel tarball]
		.
		.
		.
		.
		.
		.
		.		[:wq on little file]
		.
		.
		.
		.
		.
		.
	[              ]

IIRC, on 2.6.16 that :wq took say 0.5 sec, on late 2.6.17-rc it was
several times slower. I don't have numbers but it was psychologically
noticeable, but not BFD.

