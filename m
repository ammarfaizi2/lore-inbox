Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTLDJDq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Dec 2003 04:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbTLDJDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Dec 2003 04:03:46 -0500
Received: from smtp.tiscali.ch ([212.40.5.52]:58800 "EHLO smtp.tiscali.ch")
	by vger.kernel.org with ESMTP id S261909AbTLDJDm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Dec 2003 04:03:42 -0500
Date: Thu, 4 Dec 2003 10:02:06 +0100
From: Fabian Uebersax <fabian.uebersax@tiscali.ch>
X-Mailer: The Bat! (v1.62r) Personal
Reply-To: Fabian Uebersax <fabian.uebersax@tiscali.ch>
Organization: not really organized...
X-Priority: 3 (Normal)
Message-ID: <18710194769.20031204100206@tiscali.ch>
To: linux-kernel@vger.kernel.org
Subject: [OT] rsync 2.5.6 security advisory
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From http://rsync.samba.org/ :

December 4th 2003

Background

The rsync team has received evidence that a vulnerability in rsync was recently used in combination with a Linux kernel vulnerability to compromise the security of a public rsync server. While the forensic evidence we have is incomplete, we have pieced together the most likely way that this attack was conducted and we are releasing this advisory as a result of our investigations to date.

Our conclusions are that:

    * rsync version 2.5.6 contains a heap overflow vulnerability that can be used to remotely run arbitrary code.
    * While this heap overflow vulnerability could not be used by itself to obtain root access on a rsync server, it could be used in combination with the recently announced brk vulnerability in the Linux kernel to produce a full remote compromise.
    * The server that was compromised was using a non-default rsyncd.conf option "use chroot = no". The use of this option made the attack on the compromised server considerably easier. A successful attack is almost certainly still possible without this option, but it would be much more difficult. 

Please note that this vulnerability only affects the use of rsync as a "rsync server". To see if you are running a rsync server you should use the netstat command to see if you are listening on TCP port 873. If you are not listening on TCP port 873 then you are not running a rsync server.
New rsync release

In response we have released a new version of rsync, version 2.5.7. This is based on the current stable 2.5.6 release with only the changes necessary to prevent this heap overflow vulnerability. There are no new features in this release.

We recommend that anyone running a rsync server take the following steps:

   1. Update to rsync version 2.5.7 immediately.
   2. If you are running a Linux kernel prior to version 2.4.23 then you should upgrade your kernel immediately. Note that some distribution vendors may have patched versions of the 2.4.x series kernel that fix the brk vulnerability in versions before 2.4.23. Check with your vendor security site to ensure that you are not vulnerable to the brk problem.
   3. Review your /etc/rsyncd.conf configuration file. If you are using the option "use chroot = no" then remove that line or change it to "use chroot = yes". If you find that you need that option for your rsync service then you should disable your rsync service until you have discussed a workaround with the rsync maintainers on the rsync mailing list. The disabling of the chroot option should not be needed for any normal rsync server. 

The patches and full source for rsync version 2.5.7 are available from http://rsync.samba.org/ and mirror sites. We expect that vendors will produce updated packages for their distributions shortly.
Credits

The rsync team would like to thank the following individuals for their assistance in investigating this vulnerability and producing this response:

    * Timo Sirainen <tss.iki.fi>
    * Mike Warfield <mhw.wittsend.com>
    * Paul Russell <rusty.samba.org>
    * Andrea Barisani <lcars.gentoo.org> 

