Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265480AbSKRXSI>; Mon, 18 Nov 2002 18:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265457AbSKRXRQ>; Mon, 18 Nov 2002 18:17:16 -0500
Received: from marcie.netcarrier.net ([216.178.72.21]:39430 "HELO
	marcie.netcarrier.net") by vger.kernel.org with SMTP
	id <S265368AbSKRXQC>; Mon, 18 Nov 2002 18:16:02 -0500
Message-ID: <3DD977E6.9996A521@compuserve.com>
Date: Mon, 18 Nov 2002 18:29:42 -0500
From: Kevin Brosius <cobra@compuserve.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16-4GB i586)
X-Accept-Language: en
MIME-Version: 1.0
To: kernel <linux-kernel@vger.kernel.org>
Subject: ksyms, kksymoops, modules, et.al.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

So what's going on with ksyms in 2.5.48 (and bk trees since the module
loader change, as far as I can tell)?  I no longer see /proc/ksyms and
kernel oops's don't get decoded automatically either.

I also notice that the 'modules_install' target is populating the
/lib/modules/version#/kernel directory with a flat collection of all the
modules at that one directory level.  There are no subdirectories.  Is
this intentional?  This seems to break depmod and insmod for me, unless
I use insmod with a direct path and full filename.


In a (possibly related) test, if I add to .config:

CONFIG_KALLSYMS=y

then I see the following interesting behavior.  Note that I do have new
modutils installed, so insmod.old does exist in /sbin

---------------
make[1]: `scripts/kconfig/conf' is up to date.
./scripts/kconfig/conf -s arch/i386/Kconfig
.config:1309: trying to assign nonexistent symbol KALLSYMS

<snip>

  /sbin/kallsyms .tmp_vmlinux1 > .tmp_kallsyms1.o
Kernel requires old insmod, but couldn't run insmod.old: No such file or
directory
make: *** [.tmp_kallsyms1.o] Error 2
---------------

Is there some documented change (which I failed to locate) to ksyms I
should be using to decode oops's?  Oh, and the make removes the entry
for 'CONFIG_KALLSYMS'...  Help :)

-- 
Kevin
