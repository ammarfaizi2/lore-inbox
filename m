Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267337AbUBSVzC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 16:55:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267375AbUBSVzC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 16:55:02 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:48000 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S267337AbUBSVyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 16:54:50 -0500
Message-ID: <403531A3.4000503@tmr.com>
Date: Thu, 19 Feb 2004 16:58:59 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christophe Saout <christophe@saout.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.3-mm1
References: <1qujU-5xX-31@gated-at.bofh.it> <1qCUf-4vn-41@gated-at.bofh.it> <1qGuR-bb-25@gated-at.bofh.it> <1qGO2-uG-13@gated-at.bofh.it> <1qGO5-uG-21@gated-at.bofh.it> <1qGY1-RT-29@gated-at.bofh.it> <1qGY1-RT-27@gated-at.bofh.it> <1qIn3-5yq-23@gated-at.bofh.it>
In-Reply-To: <1qIn3-5yq-23@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christophe Saout wrote:
> Am Mi, den 18.02.2004 schrieb Brandon Low um 21:52:
> 
> 
>>I am just reading up on dm now, but correct me if I am wrong, I will
>>need to do losetup, dmcreate, mount in that order in order to use
>>dmcrypt on loop where with cryptoloop, I could just do "mount"... there
>>must be an easier way to handle this!
> 
> 
> You don't need to know everything about dm to set up encrypted devices.
> 
> Basically dmsetup is something like losetup, only that it's much more
> flexible.
> 
> To set up a device basically:
> 
> echo 0 `blockdev --getsize /dev/bla` crypt <cipher> <key> 0 /dev/bla 0 |
> dmsetup create <newname>
> 
> is enough. And it's just temporary, because no special tool has been
> written yet. dmsetup is the most low-level dm tool, mostly for
> developers. I've written a shell script named cryptsetup for the
> meantime, it asks for a passphrase and does all the magic you need.
> 
> "cryptsetup create test /dev/hda5" will ask for a passphrase and set up
> /dev/mapper/test. Voila. "cryptsetup remove test" removes it and
> "cryptsetup status test" shows some status information.
> 
> mount -o loop is basically a hack. mount uses parts of losetup to do an
> ioctl. The encryption support as mount argument is an additional patch.
> Even worse, some do passphrase hashing, some don't... it works but it's
> not a very clean solution either.
> 
> BTW: dmsetup is NOT a big program. It has two parts: a libdevmapper.so
> in /lib and the dmsetup binary itself. Every part is 16k in size (if
> compiled statically into one binary it's just 27k), and it's still
> linked against glibc. If linked against dietlibc or klibc it would be
> even smaller. Nobody needs LVM tools or something. It's just a small
> client for the dm ioctl, just like losetup is a client for the loop
> ioctl.
> 
> There are some plans to write a unified plugin based key management
> tool. You might want to have your key stored on a USB stick. Or
> encrypted in the first sector of your device and you want to unlock it
> using a password (so you can change your password without needing to
> reencrypt your data). This would be much more flexible than most of the
> crap floating around.
> 
> So, you see. NO NEED TO PANIC. Cryptoloop won't disappear over night.
> There will be some nice to user interface. At the moment dm-crypt is
> only a *kernel implementation* and not meant to be used by every end
> user immediately. Nobody will force you to drop cryptoloop until there
> is a clean solution for everybody out there.

Could you give an example of the one line I put in /etc/fstab to replace 
the one now which includes "noauto,user" so users can mount when they 
need the secure data?

You *can* do that so you don't need to train users, give them special 
permissions, or use privileged scripts or programs, right?

