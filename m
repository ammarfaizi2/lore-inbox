Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261917AbUL0Pvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261917AbUL0Pvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Dec 2004 10:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261918AbUL0Pvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Dec 2004 10:51:44 -0500
Received: from [143.247.20.203] ([143.247.20.203]:43433 "EHLO
	cgx-mail.capitalgenomix.com") by vger.kernel.org with ESMTP
	id S261916AbUL0Pur (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Dec 2004 10:50:47 -0500
Message-ID: <41D02F54.8070107@capitalgenomix.com>
Date: Mon, 27 Dec 2004 10:50:44 -0500
From: "Fao, Sean" <sean.fao@capitalgenomix.com>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Filesystem/kernel bug?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was attempting to perform an "emerge --sync" as root on my Gentoo 
system to update the portage tree (the actual meaning of this command is 
irrelevant, so don't worry if you're not familiar with it) and had it 
fail while attempting to change directories.  I found this to be quite 
strange, as I was running the synchronization as root.  The directory in 
question was, "/usr/portage/mail-mta/msmtp".  Sure enough, manually 
changing directories failed with a "permission denied".  I then CD'ed to 
"/usr/portage/mail-mta" and executed a "ls -la".  To my surprise, there 
was no directory named "msmtp" in "/usr/portage/mail-mta".  I then tried 
to change to a random directory name, to verify that the error message 
wasn't just generic.  "cd foo" returned "No such file or directory", as 
expected.

Following is basically an outline of the steps I performed, which lead 
to my confusion:

cgx-mail / # cd /usr/portage/mail-mta/

cgx-mail mail-mta # ls -la
ls: msmtp: Permission denied
total 4
drwxr-xr-x   16 root root  416 Dec 27 09:47 .
drwxr-xr-x  135 root root 4008 Dec 27 09:48 ..
drwxr-xr-x    3 root root  336 Dec 15 17:09 courier
drwxr-xr-x    3 root root  200 Nov  1 16:35 esmtp
drwxr-xr-x    3 root root  400 Dec 17 16:06 exim
drwxr-xr-x    3 root root  200 Sep  7 07:10 mini-qmail
drwxr-xr-x    3 root root  400 Dec 22 08:45 nbsmtp
drwxr-xr-x    3 root root  400 Nov 16 04:38 nullmailer
drwxr-xr-x    3 root root  328 Dec 23 01:37 postfix
drwxr-xr-x    3 root root  480 Dec 15 17:37 qmail
drwxr-xr-x    3 root root  352 Jul 20 09:37 qmail-ldap
drwxr-xr-x    3 root root  248 Nov 24 17:07 qmail-mysql
drwxr-xr-x    3 root root  296 Dec 21 09:11 sendmail
drwxr-xr-x    3 root root  240 Dec 25 16:07 ssmtp
drwxr-xr-x    3 root root  280 Dec  6 10:16 xmail

cgx-mail mail-mta # cd msmtp
-bash: cd: msmtp: Permission denied

cgx-mail mail-mta # cd foo
-bash: cd: foo: No such file or directory

cgx-mail mail-mta # uname -r
2.6.9-gentoo-r9

cgx-mail mail-mta # cat /etc/fstab
/dev/sda1               /boot        reiserfs  noatime,notail        1 1
/dev/sda3               /            reiserfs  noatime               0 0
/dev/sda2               none         swap      sw                    0 0
/dev/fd0                /mnt/floppy  auto      noauto                0 0
none                    /proc        proc      defaults              0 0


At this point, I'm not really sure what's going on.

Can anybody help me out?  I've posted any information I thought would be 
relevant.  If you need anything else, feel free to let me know.

Thank you,

-- 
Sean
