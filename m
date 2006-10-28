Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWJ1Psy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWJ1Psy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 11:48:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbWJ1Psy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 11:48:54 -0400
Received: from linux-geeks.de ([213.133.99.198]:36614 "EHLO linux-geeks.de")
	by vger.kernel.org with ESMTP id S1750929AbWJ1Psy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 11:48:54 -0400
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Transfer-Encoding: 7bit
Message-Id: <65EE3C45-1966-4C31-97DF-555967976709@terpstra.ca>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-kernel@vger.kernel.org
From: "Wesley W. Terpstra" <wesley@terpstra.ca>
Subject: Extended attributes on symlinks --> EPERM ?
Date: Sat, 28 Oct 2006 17:48:45 +0200
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good evening!

Setting extended attributes on symlinks is forbidden with EPERM.  
Certainly, if you follow the symlink, it can set the value on the  
destination file, but I want to set extended attributes on the  
symlink itself.

Is this correct behaviour?:
	pumpkin:/backup/x# touch y
	pumpkin:/backup/x# ln -s y x
	pumpkin:/backup/x# setfattr -h -n user.key1 -v val1 y
	pumpkin:/backup/x# setfattr -h -n user.key2 -v val2 x
	setfattr: x: Operation not permitted

This happens on linux-2.6.18 with ext3/xfs and backports of extended  
attributes to 2.4.20 with ext3.

The same thing works with extended attributes on osx. I have no other  
platforms with extended attributes to compare against.

It seems desirable to be able to store extended attributes on  
symlinks: meta-data can apply to anything. In fact, this is causing  
trouble with an rsync option that stores ownership, device number,  
and mode in an extended attribute. This would allow backups to a root- 
less rsync server which uses no special file-system permissions in  
backing up client computers.

Please CC me on replies.
Thank you for your time!
