Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267165AbUIMQUx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267165AbUIMQUx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 12:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268246AbUIMQTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 12:19:48 -0400
Received: from mailgate2.Cadence.COM ([158.140.2.31]:19943 "EHLO
	mailgate2.Cadence.COM") by vger.kernel.org with ESMTP
	id S267648AbUIMQTW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 12:19:22 -0400
Message-Id: <6.1.2.0.2.20040913092535.0d1d5aa0@mailhub>
X-Mailer: QUALCOMM Windows Eudora Version 6.1.2.0
Date: Mon, 13 Sep 2004 09:28:40 -0700
To: linux-kernel@vger.kernel.org
From: Mitch Sako <msako@cadence.com>
Subject: autofs4 /net /proc/mounts problem
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I’m seeing the following situation occur with 2.4.23 up through 2.4.27 and 
autofs 4.1.3 using /net access with a generic /etc/auto.net.  I tried 
'nonstrict' and 'nosymlink' in /etc/auto.net but that resulted in the 
mounts not working.

NFS Server foo has virtual nested exports:
/ on /dev/sda1
/bar on /dev/sdb1 (for example)

cd /net/foo/bar mounts both / and /bar which it finds from ‘showmount –e’

df shows foo:/ and foo:/bar mounted

/proc/mounts shows both, also.

I’m guessing what’s happening next is autofs4 tries to umount foo:/ before 
foo:/bar which yields a busy condition for foo:/, even though it’s not 
because foo:/bar is mounted above foo:/ on the client.

/proc/mounts starts filling up with foo:/bar entries at this point and 
fills up the mount table.

If I bring down the automount process, manually go through and umount all 
of the foo:/bar entries in /proc/mounts, clean up anything in /etc/mtab and 
then restart the automounter, everything seems to be OK.  Obviously, this 
is not acceptable.

Any ideas?

  


