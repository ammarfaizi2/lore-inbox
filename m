Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262109AbTJYNGM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Oct 2003 09:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262198AbTJYNGM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Oct 2003 09:06:12 -0400
Received: from quechua.inka.de ([193.197.184.2]:951 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262109AbTJYNGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Oct 2003 09:06:08 -0400
From: Andreas Jellinghaus <aj@dungeon.inka.de>
Subject: Re: Announce: Swsusp-2.0-2.6-alpha1
Date: Sat, 25 Oct 2003 15:08:18 +0200
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity. (Debian GNU/Linux))
Message-Id: <pan.2003.10.25.13.08.16.901159@dungeon.inka.de>
References: <1067069558.1975.54.camel@laptop-linux>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

website: the ML section should point to the sf.net website
where you can subscribe to the ML. Else lazy people like
me will simply post to linux-kernel :-)

The suspend shell script touches /tmp/suspend.$$.
I don't know, but maybe that is a securitry problem?
People always recommend to use tmpfile to create
temporary files, so noone can guess the name and
create evil symlinks to /etc/passwd and friends.
I don't know if a touch is also a problem.

Maybe add some documentation: swsusp does not use
the bios, I guess? PM_DISK seems to use, and the
acpi does allow both (4 for swsusp, 4b for bios based)?
I don't have a special partition the dell bios will
accept, so I can only try swsusp for now.

Also, maybe add some documentation on how to integrate
with ACPI? many laptops have a function button and
special keys to trigger suspend (e.g. fn+esc on my
machine). This triggers the suspend event via
/proc/acpi/events. I wrote a simple config and shell
script, but found one issue other people might have,
too: acpi creates one such even for pressing the key
and one for releasing the key. if the shell script
only does "echo 4 > /proc/acpi/suspend", then
the first resume will put the machine to sleep
right again. I didn't look at the suspend.sh in
detail: will it detect such double calls and somehow
ignore the release event? 

And last: it does not compile at all for me:
  CC      kernel/power/proc.o
kernel/power/proc.c: In function `swsusp_write_proc':
kernel/power/proc.c:259: error: `debug_sections' undeclared (first use in this function)
kernel/power/proc.c:259: error: (Each undeclared identifier is reported only once
kernel/power/proc.c:259: error: for each function it appears in.)
make[2]: *** [kernel/power/proc.o] Error 1
make[1]: *** [kernel/power] Error 2
make: *** [kernel] Error 2

and there are some new warnings:
  CC      kernel/power/io.o
kernel/power/io.c: In function `__read_primary_suspend_image':
kernel/power/io.c:845: warning: unused variable `headerblocksize'
kernel/power/io.c: In function `read_primary_suspend_image':
kernel/power/io.c:1106: warning: unused variable `blksize'

config:
http://athene.wiwi.uni-karlsruhe.de/~aj/config-2.6.0-test8-swsusp

and I find this quite strage in the documentation:
Since 2.4 kernels don't have the driver model that's being developed
...

huh? it's the kernel 2.6. documentation. maybe that file was simply
copied from 2.4? updating it could reduce some confusion :-)

Andreas

