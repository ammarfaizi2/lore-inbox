Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265695AbTFNRlE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jun 2003 13:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265696AbTFNRlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jun 2003 13:41:04 -0400
Received: from pimout3-ext.prodigy.net ([207.115.63.102]:45721 "EHLO
	pimout3-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S265695AbTFNRlC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jun 2003 13:41:02 -0400
Message-ID: <3EEAF192.4050102@myrealbox.com>
Date: Sat, 14 Jun 2003 09:57:38 +0000
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030529
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-ac1
References: <200306141430.h5EEUuV31162@devserv.devel.redhat.com>
In-Reply-To: <200306141430.h5EEUuV31162@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> Linux 2.4.21-ac1

Hi Alan,

Starting two 'ac' versions ago (rc7, IIRC) I can't compile the alsa-driver package:

gcc -D__KERNEL__ -DMODULE=1 -I/var/tmp/portage/alsa-driver-0.9.2/work/alsa-driver-0.9.2/include  -I/usr/src/linux/include -O2 -mpreferred-stack-boundary=2 -march=athlon -DLINUX -Wall 
-Wstrict-prototypes -fomit-frame-pointer -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -pipe -DALSA_BUILD  -DKBUILD_BASENAME=serialmidi   -c -o serialmidi.o serialmidi.c
serialmidi.c: In function `open_tty':
serialmidi.c:158: invalid operands to binary >
make[1]: *** [serialmidi.o] Error 1

This problem is specific to the ac tree.  The vanilla kernel allows the alsa-
drivers to compile without problem.

This is the offending line in serialmidi.c:

	if (tty->count > 1) {
		snd_printk(KERN_ERR "tty %s is already used", serial->sdev);

The compilation will finish if I make this change:

	if (atomic_read(&(tty->count)) > 1) {

Since I don't have a clue what I'm doing this is probably not the right fix :0)
I suspect that changing the alsa code is starting at the wrong end of the
problem anyway.

Am I the only one seeing this?

