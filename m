Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbUJ0HJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbUJ0HJO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 03:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbUJ0HJF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 03:09:05 -0400
Received: from smtp812.mail.sc5.yahoo.com ([66.163.170.82]:24450 "HELO
	smtp812.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262319AbUJ0HEr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 03:04:47 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Rusty Russell <rusty@rustcorp.com.au>, Dominik Brodowski <linux@brodo.de>
Subject: Problem with module parameters and sysfs
Date: Wed, 27 Oct 2004 01:43:54 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200410270143.54852.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

It seems that the following patch

http://linux.bkbits.net:8080/linux-2.5/diffs/kernel/params.c%401.12?nav=index.html|ChangeSet@-3d|cset@1.2142

broke module parameters in sysfs for the case when driver is built
as a module:

[root@core dtor]# ls -la /sys/module/i8042/
total 0
drwxr-xr-x    3 root     root            0 Oct 26 19:20 .
drwxr-xr-x   54 root     root            0 Oct 27 00:28 ..
drwxr-xr-x    2 root     root            0 Oct 26 19:20 parameters

[root@core dtor]# ls -la /sys/module/psmouse/
total 0
drwxr-xr-x    3 root     root            0 Oct 27 00:21 .
drwxr-xr-x   54 root     root            0 Oct 27 00:28 ..
-r--r--r--    1 root     root         4096 Oct 27 00:21 refcnt
drwxr-xr-x    2 root     root            0 Oct 27 00:21 sections

psmouse is built as a module while i8042 is compiled in.

-- 
Dmitry
