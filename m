Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbTJIMPt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Oct 2003 08:15:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbTJIMPt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Oct 2003 08:15:49 -0400
Received: from sete.essi.fr ([157.169.2.104]:46725 "HELO 127.0.0.1")
	by vger.kernel.org with SMTP id S262099AbTJIMPs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Oct 2003 08:15:48 -0400
Date: Thu, 9 Oct 2003 14:15:31 +0200
From: Guillaume Chazarain <guichaz@yahoo.fr>
To: LKML <linux-kernel@vger.kernel.org>
Subject: Runtime joystick detection & snd-ens1371
Message-Id: <20031009141531.21dd15ab.guichaz@yahoo.fr>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have an Ensoniq ES1371 with a joystick port, so the
joystick driver depends on the snd-ens1371 (I use alsa)
module to be loaded.

With this line in /etc/modprobe.conf, I can use the joystick
as soon as the sound module is loaded.

install snd-ens1371 /sbin/modprobe -i snd-ens1371; \
                    /usr/sbin/alsactl restore;     \
                    /sbin/modprobe -iq joydev;     \
                    /sbin/modprobe -iq analog

But I'd like to be able to use the joystick without manually
loading the sound module. With 2.4 I would put "alias char-major-XX sound"
in /etc/modules.conf with XX being js0 major number. Unfortunately,
with 2.6 if I cat /dev/js0 without the sound module loaded, it does
not find the joystick but does not try to load any module on which I could hook.


Also, between 2.6.0-test5 and 2.6.0-test6 my joystick stopped
working properly. When cat'ting /dev/js0 I still can get some output
when I play with the joystick but xmms using
ioctl(joy_fd, JSIOCGBUTTONS, &joy_buttons);
sees 0 buttons for my joysticks which has 4.

Not sure if it helps, but my not so trained eyes see much more output
with 2.6.0-test6 than 2.6.0-test5 with cat /dev/js0 and me playing with
the joystick.


Thanks for any help.
Guillaume.

