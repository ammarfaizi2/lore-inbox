Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262617AbVA0NfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262617AbVA0NfS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 08:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbVA0NfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 08:35:18 -0500
Received: from main.uucpssh.org ([212.27.33.224]:48038 "EHLO main.uucpssh.org")
	by vger.kernel.org with ESMTP id S262617AbVA0NfK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 08:35:10 -0500
To: linux-kernel@vger.kernel.org
Subject: initrd / initramfs - root*,ro,rw parameters
From: syrius.ml@no-log.org
Message-ID: <87ekg7dow2.87d5vrdow2@87brbbdow2.message.id>
Date: Thu, 27 Jan 2005 14:33:43 +0100
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

It seems a lot of initrd images expect to find the final root
filesystem device in the root= boot parameter while
Documentation/initrd.txt states root should be set to /dev/ram0.
I'm not sure, but it seems this patch introduced in 2.6.11-rc1 
<bunk@stusta.de>
  [PATCH] init/initramfs.c: make unpack_to_rootfs static
made root=/dev/ram0 mandatory. And initrd images that expect people to
set their root boot parameter to the final device don't work anymore.

It seems logical to me, as Documentation/kernel-parameters states
ro, rw, root, rootflags, rootdelay and rootfstype are kernel start-up
parameters. And in the case of using a loaded-into-dev-ram0 initrd
those parameters apply to /dev/ram0.
It's the initrd's job to define new parameters it will use to mount
the final root filesystem with. (for ex: pivot_root=, pivot_root_rw,
pivot_root_ro, pivot_root_flags, pivot_root_fstype and possibly
pivot_root_delay)

(for sure i'm not considering the old deprecated root_change method
nor devfs)

Is it correct ?

I'd like to hear maintainers' opinions about it.

>From Documentation/initrd.txt:
<quote>
Finally, you have to boot the kernel and load initrd. Almost all Linux
boot loaders support initrd. Since the boot process is still compatible
with an older mechanism, the following boot command line parameters
have to be given:

  root=/dev/ram0 init=/linuxrc rw
</quote>

How should this be read ? I guess it has to be updated so that it's
now mandatory to use root=/dev/ram0. Isn't it ?

I might be totally wrong.
At least i'm pretty sure some clarifications will help.

TIA.

-- 
