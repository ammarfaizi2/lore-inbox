Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265600AbUAGREC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 12:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266220AbUAGREB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 12:04:01 -0500
Received: from mail2.ugr.es ([150.214.35.29]:21189 "EHLO mail2.ugr.es")
	by vger.kernel.org with ESMTP id S265600AbUAGRD4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 12:03:56 -0500
Message-ID: <3FFC3BF4.6080105@ugr.es>
Date: Wed, 07 Jan 2004 18:03:48 +0100
From: Ruben Garcia <ruben@ugr.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20030925
X-Accept-Language: en-us, ja, en, es-es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: loop device changes the block size and causes misaligned accesses
 to the real device, which can't be processed
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The loop device advertises a block size of 1024 even when configured 
over a cdrom.

When burning a ext2 on a cd, and mounting it directly, I get:

blocksize=2048;

when I losetup /dev/loop0 /dev/cdrom, and then try to mount, I get:

blocksize=1024; and then misaligned transfer; this results in not being 
able to read the superblock.

The loop device should be changed to export the same blocksize of the 
underlying device

or

to be able to handle the different blocksize and ask the real disk for 
the hard sectors; then split them and send them up.

This is needed for crypto, or backup won't mount. (Worked on 2.4.21+Old 
Cryptoapi)

