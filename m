Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVFKDaw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVFKDaw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 23:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261617AbVFKDav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 23:30:51 -0400
Received: from relay01.roc.ny.frontiernet.net ([66.133.182.164]:64746 "EHLO
	relay01.roc.ny.frontiernet.net") by vger.kernel.org with ESMTP
	id S261615AbVFKDal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 23:30:41 -0400
Message-ID: <42AA5AE6.4040102@xfs.org>
Date: Fri, 10 Jun 2005 22:30:46 -0500
From: Stephen Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, rusty@rustcorp.com.au
Subject: Re: Race condition in module load causing undefined symbols
References: <42A99D9D.7080900@xfs.org> <20050610112515.691dcb6e.akpm@osdl.org>
In-Reply-To: <20050610112515.691dcb6e.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> Stephen Lord <lord@xfs.org> wrote:
> 
>>I am having troubles getting any recent kernel to boot successfully
>> on one of my machines, a generic 2.6GHz P4 box with HT enabled
>> running an updated Fedora Core 3 distro. This is present in
>> 2.6.12-rc6. It does not manifest itself with the Fedora Core
>> kernels which have identical initrd contents as far as the
>> init script and the set of modules included goes.
>>
>> The problem manifests itself as various undefined symbols from
>> module loads.
> 
> 
> Peculiar.  Module loading is all synchronous, isn't it?
> 

Well, things are getting more bizarre, adding sleeps between
module loads cures the problem with missing symbols. I then
run into a problem with device mapper/lvm which seems to be
having problems setting up devices. In this section of
the init script:

umount /sys
echo Mounting root filesystem
mount -o defaults --ro -t ext3 /dev/root /sysroot
mount -t tmpfs --bind /dev /sysroot/dev
echo Switching to new root
switchroot /sysroot
umount /initrd/dev

The correct number of volumes are found, but adding a showlabels
command to the init script fails to display them, it spits out
errors about readdir failures in /dev/Volume00

The umount of /sys fails, the root mount fails and obviously, the
switchroot then fails.

I tried using the same config options as the redhat supplied
kernel without any success, this still has module symbol
problems.

I am baffled, but it looks like it is not a symbol table problem.

Steve

