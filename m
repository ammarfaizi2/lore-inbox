Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262115AbVHAKXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbVHAKXa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Aug 2005 06:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbVHAKX3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Aug 2005 06:23:29 -0400
Received: from bluebottle-fe1.bluebottle.com ([67.107.78.243]:9427 "EHLO
	bluebottle-fe1.bluebottle.com") by vger.kernel.org with ESMTP
	id S263059AbVHAKWV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Aug 2005 06:22:21 -0400
Message-ID: <1122891737.42edf7d9a402a@www.bluebottle.com>
Date: Mon,  1 Aug 2005 05:22:17 -0500
From: Eugene Pavlovsky <heilong@bluebottle.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: RFE: console_blank_hook that calls userspace helper
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-MOQ1122891737ce7dafde0a4e3a9ceaa4dff1689ae10d"
User-Agent: Internet Messaging Program (IMP) 3.2.2
X-Trusted-Delivery: <97fc4284f75e86e94265110edcafa824>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This message is in MIME format.

---MOQ1122891737ce7dafde0a4e3a9ceaa4dff1689ae10d
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit

http://bugzilla.kernel.org/show_bug.cgi?id=4767:

Bugzilla Bug 4767 	RFE: console_blank_hook that can call userspace
program
Submitter:   	heilong@bluebottle.com (Eugene Pavlovsky)

I think it'd be very good to have a console_blank_hook handler that
would call a
userspace program/script/generate hotplug event whatever. Currently,
the console
can only be blanked using APM, so no options exist for people using
ACPI. I've
got a Radeon graphics chip on my laptop, and the LCD backlight can be
controlled
(on/off) using radeontool. If there was a userspace callback
interface
to
console blanking, I would just make a callback script that calls
"radeontool
light off" on blank and "radeontool light on" on unblank - really
easy. I think
this userspace console_blank_hook handler is very simple to put into
kernel, but
I'm not a kernel developer myself, so wouldn't risk sending any
patches (that
call system("some_script")), because I probably won't make things as
they should
be in the kernel.


------- Additional Comment #1 From Eugene Pavlovsky 2005-06-29 06:46
-------

Created an attachment (id=5238)
implemented this functionality in a kernel module

I've actually checked the kernel sources on how this can be done and
implemented the proposed functionality in a kernel module. The module
attaches
a console blank hook function that uses kernel's
call_usermodehelper()
to
execute /sbin/user_vc_blank (defined at compile-time) to
blank/unblank
the
console. I've written a sample script (which I use on my laptop) that
uses
radeontool to turn the LCD backlight off/on. Maybe this functionality
should be
moved to the kernel. On the other hand, as it still needs userspace
utilities,
maybe it's better off as a module. Anyway, please give it a thought,
or at
least made this module available.


---MOQ1122891737ce7dafde0a4e3a9ceaa4dff1689ae10d
Content-Type: application/x-gzip; name="user_vc_blank-0.1.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="user_vc_blank-0.1.tar.gz"

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
gwwyyCCDDDLIIIMMMvhW8C/FWOooAFAAAA==

---MOQ1122891737ce7dafde0a4e3a9ceaa4dff1689ae10d--

