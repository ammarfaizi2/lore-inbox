Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268267AbUHFTyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268267AbUHFTyN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268266AbUHFTsR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:48:17 -0400
Received: from gw.ptr_62-65-149-158.customer.ch.netstream.com ([62.65.149.158]:2176
	"EHLO provider.smartpal.de") by vger.kernel.org with ESMTP
	id S268264AbUHFTqx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:46:53 -0400
Message-ID: <4113E02A.6030705@lcsys.ch>
Date: Fri, 06 Aug 2004 21:46:50 +0200
From: michael.siebecker@lcsys.ch
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040627
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: /lib/modules
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,
i see a good possibility that this is not new, but also found no way to 
verify this due to lack of sufficiently distinguishing keywords
... so forgive if it's not so original...

What i'm looking at is the problem of having to have a kernel that can 
access rootfs/modules and the "unclean solution" feeling i have
with initrd, somewhat duplicating the install.

Since probably in principle everybody here knows, i'll just mention a 
few situations i currently remember where currently it is a bit u
ncomfortable (leaving initrd trick aside):

- initial installs
- switches of rootfs (imagine local disc root, now you want to do major 
automated reinstallation and want root from somewhere else, e.g
. NFS)
- HW changes in existing setup moving rootdisc to different HW

possibly one could come up with more.

So what it is in a way is the niceness of modules is broken in rootfs.

If it makes sense at all, i'd like to suggest some discussion starter at 
best...

Suggested theory: The place where modules reside should not have to be 
mounted or be part of the filesystem (you would mount it to chan
ge its content though). Modules should be decoupled from the rootfs. 
Maybe be stored where bootloader/kernel is or separate partition a
nd be read by the kernel directly, without filesystem paths.

E.g. you have a small embedded device with a builtin flash and a slot 
for some external flash. You'd have all kernel, core and modules,
 on the internal one and you could switch distributions via rootfs on 
external. No duplication involved (with small space) as in intitr
d or modules in rootfs.
Or just for convenience, you could boot a rootfs without verifying that 
it has modules for your current version of kernel.


Other idea: If it was possible to arrange with bootloaders, that they 
stay for a bit with the booting kernel and offered a function so
that the kernel can retrieve files from it out of their boot partition, 
then one could move the modules from /lib/modules into the boot
 partition and the booting kernel could:

- ask for an intial configuration file that names the modules needed to 
access root, possibly the bootloader could deliver a different
one depending on bootloader menu...
- the kernel could retrieve those and possibly depending modules from 
the bootloader to access rootfs
- go on as usual

This way, the kernel would be fully split from rootfs and one could 
exchange rootfs or rootfs source and kernel independently.

If a bootloader cannot provide the kernel file access upon request, then a
possibility might be, when it would be configured to load a set of files in
sequence. So you would e.g. configure it to load files a,b,c being kernel,
controller module, filesystem module in sequence into RAM. Then the kernel
would read the modules from RAM.

thanks for making your work accessible to all,
Michael

I will try to see what happens with the mail via NNTP (big traffic :)), 
otherwise as suggested by FAQ, i ask for cc
