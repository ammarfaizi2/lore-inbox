Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964825AbWCAC2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWCAC2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 21:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWCAC2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 21:28:47 -0500
Received: from moutng.kundenserver.de ([212.227.126.187]:13768 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964825AbWCAC2q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 21:28:46 -0500
From: Hauke Laging <mailinglisten@hauke-laging.de>
To: linux-kernel@vger.kernel.org
Subject: VFS: Dynamic umask for the access rights of linked objects
Date: Wed, 1 Mar 2006 03:28:41 +0100
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603010328.42008.mailinglisten@hauke-laging.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:02bdc4d6ea016d90f9ef4145f50516b2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I tried to send this to the VFS maintainer but the address I found on 
http://www.kernelnewbies.org/maintainers/ and in 
my /usr/src/linux/MAINTAINERS seems not to exist any more 
(viro@parcelfarce.linux.theplanet.co.uk).


The complete version of the following text ist avaiable at 
http://www.hauke-laging.de/ideen/symlink-umask/konzept_en.html


the problem
(At least) If applications store data in directories which are 
write-accessible by other users then symlink attacks become possible. A 
file is erased and replaced by a symlink. The (buggy) application can be 
abused if it can read or write the linked-to file but the abusing user 
cannot. These attacks are mostly denial of service attacks.


Solution
The kernel should be extended by a function (which can be enabled and 
disabled) which would solve the problem. The access rights of a symlink 
are ignored but its creator is stored. The kernel should do additional 
checks when determining whether a file system object can be accessed in 
the requested way:

- Is the accessed object a symlink?

- Has the creator of the symlink got the access rights which the respective 
process is requesting?

If the situation turns out to be critical then the kernel would deny the 
respective rights. The process cannot access the file via the symlink 
though it could have if it had tried to access it directly. The access 
rights of the symlink creator (through the whole path, not just for the 
file) would be used as a mask for the applications rights.


This approach does not solve every kind of this problem but should be quite 
easy to implement. I don't want this mail to get too long so I have left 
out some considerations about hard links. See the URL.


Best regards,

Hauke
