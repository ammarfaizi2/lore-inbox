Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131786AbRCOQid>; Thu, 15 Mar 2001 11:38:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131788AbRCOQiX>; Thu, 15 Mar 2001 11:38:23 -0500
Received: from ecstasy.ksu.ru ([193.232.252.41]:6133 "EHLO ecstasy.ksu.ru")
	by vger.kernel.org with ESMTP id <S131786AbRCOQiP>;
	Thu, 15 Mar 2001 11:38:15 -0500
X-Pass-Through: Kazan State University network
Message-ID: <3AB0C09A.1020505@ksu.ru>
Date: Thu, 15 Mar 2001 16:16:10 +0300
From: Art Boulatov <art@ksu.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-test10-pre5-reiserfs-3.6.18-acpi-i2c i686; en-US; 0.7) Gecko/20010203
X-Accept-Language: ru, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pivot_root & linuxrc problem
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

may be thats a bug, or I'm doing something really wrong :)

from Documentation/initrd.txt:

"# cd /new-root
   # mkdir initrd
   # pivot_root . initrd

Now, the linuxrc process may still access the old root via its
executable, shared libraries, standard input/output/error, and its
current root directory. All these references are dropped by the
following command:

# exec chroot . what-follows <dev/console >dev/console 2>&1

Where what-follows is a program under the new root, e.g. /sbin/init"



How can I "exec /sbin/init" from "/linuxrc", whatever it is,
if "linuxrc" does not get PID=1?

Actually, why does NOT "linuxrc" get PID=1?

A task list after booting with "root=/dev/rd/0" and "init=/linuxurc",
where "linuxrc" is simply "bash", shows that:
"swapper" got PID=1,
next come other kernel threads with a parent PID=1,
and "linuxrc" got PID=7 and a parent PID=1.

"init" sees it does not have PID=1 and simply bails out, next happens this:

"Note: if linuxrc or any program exec'ed from it terminates for some
reason, the old change_root mechanism is invoked (see section "Obsolete
root change mechanism")."


I probably misunderstand something here,
but could you please help?

In summary:

What is "swapper" and why does it get PID=1 and "linuxrc" does not?
If it is supposed to be that way, how do I "exec /sbin/init" from
"linuxrc" then?
Also why "/linuxrc" is hardcoded in init/main.c,
so telling kernel "root=/dev/rd/0 init=/sbin/whatever" does still invoke
"/linuxrc"?

Thanks a lot,
Art.

