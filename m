Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbTIUApK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Sep 2003 20:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbTIUApK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Sep 2003 20:45:10 -0400
Received: from postfix4-2.free.fr ([213.228.0.176]:13513 "EHLO
	postfix4-2.free.fr") by vger.kernel.org with ESMTP id S261979AbTIUApG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Sep 2003 20:45:06 -0400
Message-ID: <3F6CF491.9030205@free.fr>
Date: Sun, 21 Sep 2003 02:45:05 +0200
From: Jean-pierre Cartal <jpcartal@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b; MultiZilla v1.5.0.2f) Gecko/20030918
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: suid bit behaviour modification in 2.6.0-test5
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm running a standard RH 9 installation upgraded to kernel 2.6.0-test5 
with rpms from http://people.redhat.com/arjanv/2.5/RPMS.kernel/.

I noticed that contrary to what was happening with 2.4.x kernel, suid 
root files don't loose their suid bit when they get overwritten by a 
normal user (see example below)

Is this the intended behaviour or a bug ?

Example :

[cartaljp@localhost test]$ uname -r
2.6.0-0.test5.1.38
[cartaljp@localhost test]$ id
uid=500(cartaljp) gid=500(cartaljp)
[cartaljp@localhost test]$ touch suid_test
[cartaljp@localhost test]$ ls -l
total 0
-rw-rw-r--    1 cartaljp cartaljp        0 Sep 19 07:55 suid_test
[cartaljp@localhost test]$ su -
Password:
[root@localhost test]# chown root ~cartaljp/test/suid_test
[root@localhost test]# chmod 4775 ~cartaljp/test/suid_test
[root@localhost test]# exit
[cartaljp@localhost test]$ ls -l
total 0
-rwsrwxr-x    1 root     cartaljp        0 Sep 19 07:55 suid_test
[cartaljp@localhost test]$ cp /bin/ls suid_test
[cartaljp@localhost test]$ ls -l
total 72
-rwsrwxr-x    1 root     cartaljp    67668 Sep 19 07:56 suid_test <- 
Suid bit is still set whereas with 2.4.x kernel it was reset.

