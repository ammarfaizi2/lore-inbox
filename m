Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTKCXci (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 18:32:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263494AbTKCXci
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 18:32:38 -0500
Received: from uucp.cistron.nl ([62.216.30.38]:9699 "EHLO ncc1701.cistron.net")
	by vger.kernel.org with ESMTP id S263491AbTKCXce (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 18:32:34 -0500
From: "Miquel van Smoorenburg" <miquels@cistron.nl>
Subject: Re: how to restart userland?
Date: Mon, 3 Nov 2003 23:32:33 +0000 (UTC)
Organization: Cistron Group
Message-ID: <bo6oih$s51$1@news.cistron.nl>
References: <20031103193940.GA16820@louise.pinerecords.com> <Pine.LNX.4.53.0311031519050.2654@chaos>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Trace: ncc1701.cistron.net 1067902353 28833 62.216.29.200 (3 Nov 2003 23:32:33 GMT)
X-Complaints-To: abuse@cistron.nl
X-Newsreader: trn 4.0-test76 (Apr 2, 2001)
Originator: miquels@cistron-office.nl (Miquel van Smoorenburg)
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <Pine.LNX.4.53.0311031519050.2654@chaos>,
Richard B. Johnson <root@chaos.analogic.com> wrote:
>On Mon, 3 Nov 2003, Tomas Szepe wrote:
>
>> Hi,
>>
>> Would anyone know of a proven way to completely restart the userland
>> of a Linux system?
>>
>> i.e. something like
>> # echo whatever-restart >/proc/wherever
>>
>> Killing all processes.
>> Killing init.
>> Unmounting all filesystems.
>> VFS: Mounted root (ext2 filesystem).
>> INIT: v2.84 booting
>> ...
>
>If you have an 'old' sys-V installation, you as root can execute
>`init 0`.
>Then, after everything has stopped, you can execute
>`init 5` or `init 6` to restart to the runlevel you had. More
>modern versions from (probably all) distributions won't allow
>this.

It's been a while since you used a real sysv right ? Or you've
used different ones then I did.

The correct command for single user mode is:

# shutdown now (equivalent to "init 1")

Now the system will throw you into single user mode. Here, all
processed are killed. It's just that all filesystems remain
mounted

You can now login and enter 'init 2' or 'init 3' or whatever to
go to that runlevel

Just exiting the shell (logout) will boot into the default runlevel

You can even just not login at all, press ^D and the system will
boot to the default runlevel.

The command that is run at single user mode is "sulogin". It's
invoked by init, as defined in /etc/inittab. If you just add
a timeout to the sulogin invocation (-t 20 or so) then sulogin
will exit after that timeout.

Now that is exactly what you want - add the timeout. Throw the
system into single user mode with "shutdown now" or "init 1".
After a while the system will be restarted from scratch
without a reboot.

This will work on Debian. It most likely will works on other
distributions too, and probably on most System Vs as well.
Though on System V the shutdown command is "shutdown -i1 -y".
Which, btw, will work just fine on Linux too ;)

Mike.

