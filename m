Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268926AbRIWHDt>; Sun, 23 Sep 2001 03:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273298AbRIWHDi>; Sun, 23 Sep 2001 03:03:38 -0400
Received: from embolism.psychosis.com ([216.242.103.100]:61454 "EHLO
	embolism.psychosis.com") by vger.kernel.org with ESMTP
	id <S268926AbRIWHDg>; Sun, 23 Sep 2001 03:03:36 -0400
Content-Type: text/plain; charset=US-ASCII
From: David Cinege <dcinege@psychosis.com>
Reply-To: dcinege@psychosis.com
To: Alexander Viro <viro@math.psu.edu>
Subject: Re: [PATCH] Initrd Dynamic v4.2 - New Feature: Tmpfs root support
Date: Sun, 23 Sep 2001 03:03:59 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org, LRP <linux-router@linuxrouter.org>,
        LRPD <linux-router-devel@linuxrouter.org>
In-Reply-To: <Pine.GSO.4.21.0109230036450.13262-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0109230036450.13262-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15l3IH-0005Tu-00@schizo.psychosis.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 23 September 2001 0:41, Alexander Viro wrote:
> >
> > Please consider it for inclusion in the next 2.4 kernel release.
>
> Sigh...  With initramfs it can be done in userland. 

Using Initrd Dynamic a person can boot with a ramdisk as their primary
root, populating it with tar.gz archive(s). Making 'image' changes works
very well and in a modular way. (IE root.tgz, etc.tgz) 

With this release you can now forgo an internal mkfs on /dev/ram0 before 
archive extraction and go straight to a truly dynamic tmpfs VFS as the root
without the minix FS limitations. 

Now, could you please explain to me how the hell you boot to a tmpfs
root from userland!?!? This feature *creates* your userland.

Maybe you're just confused what this feature does. Maybe you've never
worked with systems that run a volatile root. Maybe you've just never made
a boot disk.

Maybe you even think it's sane to compile userland into the kernel? <snicker 
snicker> I just looked at your initramfs. From what I see it's the same 
scheme I used to use In the Linux Router Project before I wrote 
initrd-archive. Except I did it *entirely* in userland back in 1997. It 
sucked. Badly.

> _Please_, let's stop
> adding complexity to already ridiculously bloated late boot stages.

It's funny you've refered to my patch as bloated. What you've wrote (which is 
a limited solution) weighs in at ~122k. Initrd Dynamic is ~35K complete and 
that includes ~7K of mkfs_minix, which can be removed when use Linux 2.4 with 
tmpfs (and ~2K of Configure.help : > ). Compiled up it add only ~3K to the 
kernel size, and as for boot complexity, I agree lets reduce it. Leave it
up to the bootloader to populate initrd memory space, or let a specific 
driver tie the initrd file handle to a device to load from. Initrd Dynamic
is made to work this way and is (should be) entirely platform independant
code.

One day I hope someone finally implements loading kernel modules from 
'initrd' type memory space, again leaving the job of getting them their to 
the boot loader. (Actually it's called the multi boot standard and GRUB boot 
loader has supported it for 3(?) years.)

> David, no offence, but let's do it the right way.

It is done right. Infact, I'm proud that this release finally has implemented 
it to perfection for the purposes it was designed. It took 3 years
to get to this point of a completly dynamic, modular, ram based root.

It never fails, post a patch to kernel and they come out of the wood work 
with delusional bitching. This is one reason I sat on releases for 9 months.
BTW Offence intended...

Dave
