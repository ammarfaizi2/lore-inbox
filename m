Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262375AbTLJEWs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 23:22:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTLJEWs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 23:22:48 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:12454 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S262375AbTLJEWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 23:22:45 -0500
Date: Wed, 10 Dec 2003 17:22:54 +1300
From: Nigel Cunningham <ncunningham@clear.net.nz>
Subject: Announce: Software Suspend 2.0rc3 for 2.4 and 2.6.
To: swsusp-devel <swsusp-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-id: <1071030171.3344.29.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: text/plain
Content-transfer-encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

This is to announce 2.0-rc3, now being uploaded to swsusp.sf.net.

A number of small but significant user-visible changes have been made
with this release, so please read these notes carefully.

1) New format. There is now one 'core' patch which should be applied
regardless of your kernel version. In addition to the core patch, a
version-specific patch should be applied. These are available for both
2.4 and 2.6 series kernels. Core and version-specific patches should be
able to be updated independently.

PARTICULARLY IN THE CASE OF 2.6, THE VERSION SPECIFIC PATCH SHOULD BE
APPLIED FIRST. Otherwise, rejects will occur.

2) Changed kernel command line parameters. Instead of resume=,
resume_block= and resume_blocksize=, there is now a single resume2=
command line parameter. Note that that's RESUME2, not RESUME. The format
for this parameter is:

resume2=[writer]:[writer-specific-parameters]

At the moment, there is only one method of storing images - the
swapwriter. It is envisaged, that NFS support will be implemented
sometime in the future. (After I do the work of merging with Patrick).
For now, then, you will want to replace

resume=/dev/hda1 resume_block=0x560 resume_blocksize=1024

with

resume2=swap:/dev/hda1:0x560@1024

Later, you'll hopefully end up being able to have
resume2=nfs:192.168.1.1/images/laptop.

3) /proc/sys/kernel/swsusp is now deprecated. It is still in this
version, but I'd appreciate it if scripts could be changed to use the
new /proc/swsusp/all_settings entry instead. The functionality is
exactly the same. Only the location has changed.

In addition, a ton of user-invisible changes have been made. This
accounts for the size of the patch. A new internal API implements two
new kinds of 'plugins', designed to make adding new methods of
transforming the data to be stored ('transformers') and saving the data
('writers') easier to implement. This has allowed me to separate out the
swap specific code and the compression code as part of the big cleanup
I've also done. The /proc code has also been enhanced, so that plugins
can dynamically register new entries. This will also form a foundation
for kobject support in the 2.6 kernel. (That is to say, 2.6 swsusp will
soon stop using proc, and will use sysfs instead).

4) Compatibility with other 2.6 implementations.

This version should play nicely with the existing software suspend
implementations in the 2.6 kernel. Patrick's pmdisk implementation can
be activated as always using the sysfs interface, and Pavel's using echo
4 > /proc/acpi/sleep. This patch does replace the freezer implementation
those versions use, and Pavel's suspend will initialise but not use the
nice display. Apart from these minor changes, no differences should be
seen.

For those who simply with to upgrade from rc2, an incremental patch is
also available from Sourceforge. I've put it there rather than attaching
it because of its size.

Apart from the kobject changes mentioned above, this should be the last
set of big changes to the code base. Unless something has slipped my
mind, I believe I've just about implemented all the functionality we
need. From now on, then, I'll only be looking to update/improve the
documentation and clean and further document the code, to implement
kobject support and perhaps also SMP support (which should be a minor
changeset).

As always, I look forward to feedback.

Regards,

Nigel
-- 
Nigel Cunningham
495 St Georges Road South, Hastings 4201, New Zealand

Evolution (n): A hypothetical process whereby infinitely improbable events occur 
with alarming frequency, order arises from chaos, and no one is given credit.

