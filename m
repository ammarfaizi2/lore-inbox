Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265246AbUEMXUr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265246AbUEMXUr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 May 2004 19:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264151AbUEMXUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 May 2004 19:20:47 -0400
Received: from pop.gmx.de ([213.165.64.20]:13957 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S265246AbUEMXTn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 May 2004 19:19:43 -0400
X-Authenticated: #1892127
Mime-Version: 1.0 (Apple Message framework v613)
Content-Transfer-Encoding: 7bit
Message-Id: <09C01AA8-A53D-11D8-82DC-0003931E0B62@gmx.li>
Content-Type: text/plain; charset=US-ASCII; format=flowed
To: linux-kernel@vger.kernel.org
From: Martin Schaffner <schaffner@gmx.li>
Subject: hfsplus bugs in linux-2.6.5
Date: Fri, 14 May 2004 01:24:18 +0100
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's how to trigger a hfsplus bug in linux-2.6.5:

dd if=/dev/zero of=/test bs=1k count=10k
newfs_hfs /test
mount -t hfsplus /test /mnt/test -o loop
cd /mnt/test
mkdir a; mkdir b
mv a b

The last command doesn't correctly move "a": it complains that it 
cannot find "b/a". Effectively, it creates an entry in "b", but that 
entry doesn't correspond to any actual directory "a". This means I am 
stuck with a directory "b" which I can't delete with "rm -rf b". 
However, I can delete it with:

rmdir b; rm -rf b

If above, after creating, mounting and cd-ing to the hfsplus 
filesystem, I do:

cp -r /whatever/module-init-tools-3.0 .
mkdir m; mv mod* m
rmdir m; rm -rf m
cp -r /whatever/module-init-tools-3.0 .

Then the machine hangs. While I can still change the screen brightness 
with the topleft keys of the keyboard, I can't change virtual consoles 
anymore.


A second, less serious wierdness is that directories created with linux 
are bigger than directories created with Mac OS X: When I do "for 
((i=1;i>0;i++)); do mkdir $i; done" on a new 1MB-HFS+-image on Mac OS 
X, I can create about 6300 directories. With Linux, it's about 3600.
Funny that for both, I can't free up any space afterwards, even if I 
delete everything inside the volume.

Can someone more knowledgeable look at these bugs? Unfortunately, I 
don't have a serial port (or second computer with USB port), so I can't 
do any kernel debugging the usual way.

Thanks,

Martin

