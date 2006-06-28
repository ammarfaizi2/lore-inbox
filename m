Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751142AbWF1TyH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751142AbWF1TyH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jun 2006 15:54:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751150AbWF1TyH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jun 2006 15:54:07 -0400
Received: from nz-out-0102.google.com ([64.233.162.205]:18894 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751142AbWF1TyD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jun 2006 15:54:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IaXXBNO0TfY+CdYcPnZ0goFQbqZah10+nLk4arvsDsphbw6l061GZuNru9cN5l3lV+vYjfJOIf3SwnLP+5TNt5XUK0m8DFRA9uC4PtQG+6BZf3nCnvdixc5CGgKdOu4/Du6Ef9ChOM60su3zs4aDW7mBSW26v+Af3fTNxOAmUmE=
Message-ID: <38b19aa60606281254v43a7639dl4c74a57503c65dec@mail.gmail.com>
Date: Wed, 28 Jun 2006 12:54:01 -0700
From: "Hareesh Nagarajan" <hnagar2@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: losetup behavior
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In my example below I have an image of an entire disk /dev/sda created
using the dd command. The name of the file is foo.img. There are
(internally) 3 partitions. ext2 (root), swap, ext2 (data). I will
extract the third partition, first with dd and show that it works and
then with losetup and show that it doesn't work.

With dd:
root: / # dd if=foo.img of=part3 bs=512 skip=12402180 count=21141540
(Partition 3 begins at: 12402180 * 512 = 6349916160 bytes from start)

root: / # mount -o loop=/dev/loop0 part3 mypart3/
root: microv3/ # cd mypart3/; ls
blah/ blah-blah/

*works*

With losetup:
root: # losetup -o6349916160 /dev/loop0 foo.img
root: # mount /dev/loop0 mypart3/
mount: you must specify the filesystem type
root: / # mount -t ext2 /dev/loop0 mypart3
mount: wrong fs type, bad option, bad superblock on /dev/loop5,
or too many mounted file systems

*doesn't work*

At this point I must mention that losetup had no issues in mounting
the first partition.

root: # losetup -o32256 /dev/loop0 foo.img
(Partition 1 begins at: 63 * 512 = 32256 bytes from start)
root: # mount /dev/loop0 myroot/
root: # cd myroot/; ls
bin/   dev/

*works*

Anyone know, if this is the correct behaviour of losetup? Perhaps, I
am doing something incorrectly.

Thanks,

-- 
./hareesh
PS: uname -r ---> 2.6.16.11
