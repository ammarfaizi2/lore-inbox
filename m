Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262254AbVCVA4f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262254AbVCVA4f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 19:56:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262259AbVCVAyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 19:54:44 -0500
Received: from rproxy.gmail.com ([64.233.170.203]:17064 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262221AbVCVAxP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 19:53:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=et8cXpnJ3bdb32geRCnHizh1ODKKSri1UQxwUHJ4rh3LlaZ6YcdEYp8o+iBNMYdUDVfwt5LOp4nVCeVAdnE29tYmESCrU2NFVk51cs5gQCrp2zwO6k8k5UihR9rvNXhgLv+CAf+2FrGG+TyAi1qpGxGYEn/rR++tfoU2Fb25jtQ=
Message-ID: <9e473391050321165338208c66@mail.gmail.com>
Date: Mon, 21 Mar 2005 19:53:15 -0500
From: Jon Smirl <jonsmirl@gmail.com>
Reply-To: Jon Smirl <jonsmirl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: current linus bk, error mounting root
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org, axboe@suse.de
In-Reply-To: <20050321164318.04a5dc82.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <9e47339105030909031486744f@mail.gmail.com>
	 <20050321154131.30616ed0.akpm@osdl.org>
	 <9e473391050321155735fc506d@mail.gmail.com>
	 <20050321161925.76c37a7f.akpm@osdl.org>
	 <20050322003807.GA10180@kroah.com>
	 <20050321164318.04a5dc82.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is fedora's initrd nash script from my system. I modified it with
the sleep lines.

It already is creating the /dev node with 'mkrootdev /dev/root'
I don't think udev is even running yet. Something else is causing this.

echo "Loading libata.ko module"
insmod /lib/libata.ko
echo "Loading ata_piix.ko module"
insmod /lib/ata_piix.ko
echo "Loading raid1.ko module"
insmod /lib/raid1.ko
/sbin/udevstart
raidautorun /dev/md0
>>>echo Sleep 1
>>>sleep 1
echo Creating root device
mkrootdev /dev/root
umount /sys
echo Mounting root filesystem
mount -o defaults --ro -v -t ext3 /dev/root /sysroot
mount -t tmpfs --bind /dev /sysroot/dev
echo Switching to new root
switchroot /sysroot
umount /initrd/dev

-- 
Jon Smirl
jonsmirl@gmail.com
