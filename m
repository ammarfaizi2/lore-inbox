Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269695AbUJMNIr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269695AbUJMNIr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 09:08:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269697AbUJMNIr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 09:08:47 -0400
Received: from zamok.crans.org ([138.231.136.6]:23703 "EHLO zamok.crans.org")
	by vger.kernel.org with ESMTP id S269695AbUJMNIW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 09:08:22 -0400
To: "Harald Dunkel" <harald.dunkel@t-online.de>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: udev: what's up with old /dev ?
References: <1097446129l.5815l.0l@werewolf.able.es>
	<20041012001901.GA23831@kroah.com> <416B91C4.7050905@t-online.de>
	<20041012165809.GA11635@kroah.com> <416C26B4.6040408@t-online.de>
	<20041012185733.GA31222@kroah.com> <416C3BB6.4040200@t-online.de>
	<20041012203022.GB32139@kroah.com> <416C4E15.9000503@t-online.de>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Wed, 13 Oct 2004 15:08:23 +0200
In-Reply-To: <416C4E15.9000503@t-online.de> (Harald Dunkel's message of "Tue,
	12 Oct 2004 23:35:17 +0200")
Message-ID: <87vfde3gvs.fsf@barad-dur.crans.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Harald Dunkel" <harald.dunkel@t-online.de> disait dernièrement que :

> Greg KH wrote:
>> On Tue, Oct 12, 2004 at 10:16:54PM +0200, Harald Dunkel wrote:

> Sorry, somewhere in this thread I had clicked the wrong
> reply button.
>
> Talking about initramfs: I am still trying to become
> familiar with this stuff. I have found a lot of small
> pieces of information (still reading), and the cpio
> stuff in the kernel usr directory. But I have 2 questions:
>
> Why is the initramfs built at the beginning of the
> kernel build procedure? Wouldn't it be more reasonable
> to build it when all kernel modules are available?

because for now, the initramfs built into the kernel is quasi-empty and
isn't used as-is.

>
> And why is it compiled into the kernel at all? The
> README in Documentation/early-userspace says
>
> <quote>
> "Early userspace" is a set of libraries and programs that provide
> various pieces of functionality that are important enough to be
> available while a Linux kernel is coming up, but that don't need to be
> run inside the kernel itself.
> </quote>

the last statement just says it does not run in _kernelspace_ but in
_userspace_. 
it has to be in the kernel.
I use it to mount my dm-crypt'd / and no initrd is needed.
(well as I wasn't able to get a small cryptsetup binary, my kernels
are ~1850kB worth of size)

> So why compile it into the kernel? IMHO it would be more
> flexible to load the early-userspace stuff similar to initrd
> via the grub command line. Compiling it into the kernel
> could be optional.

huh, well initrd is / that is mounted over the so-called _rootfs_
initramfs is here to _be_ that rootfs. So no pivot_root needed and the run-it
program included in klibc tarballs takes care of wiping-out everything that
could waste memory into the initramfs before mounting the real /. 
If it was to compiled out of the kernel, it would just be an initrd....

rootfs is _needed_ for mounting the real root, so is initramfs.

have a nice day,

Mathieu

-- 
"My pan plays down an unprecedented amount of our national debt."

George W. Bush
February 27, 2001
>From a speech concerning the proposed federal budget.

