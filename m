Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVBXKTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVBXKTC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 05:19:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262190AbVBXKP7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 05:15:59 -0500
Received: from lx09-hrz.uni-duisburg.de ([134.91.4.50]:13010 "EHLO
	lx09-hrz.uni-duisburg.de") by vger.kernel.org with ESMTP
	id S262164AbVBXKOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 05:14:51 -0500
Message-ID: <421DA915.7020209@uni-duisburg.de>
Date: Thu, 24 Feb 2005 11:14:45 +0100
From: =?ISO-8859-1?Q?J=F6rn_Nettingsmeier?= <pol-admin@uni-duisburg.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: nettings@folkwang-hochschule.de
Subject: FUTEX deadlock in ping?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi !


disclaimer: i'm not a kernel guy ;)

after reading the FUTEX deadlock thread 
(http://thread.gmane.org/gmane.linux.kernel/280900), i was wondering:

ever since moving to ldap for passwd/group/shadow/hosts lookup, ping to 
a non-reachable host just freezes up and never returns:

spunk:~ # strace ping herrnilsson
execve("/bin/ping", ["ping", "herrnilsson"], [/* 61 vars */]) = 0
uname({sys="Linux", node="spunk", ...}) = 0
brk(0)                                  = 0x8063000
...
...
munmap(0x40504000, 4096)                = 0
brk(0x80a5000)                          = 0x80a5000
uname({sys="Linux", node="spunk", ...}) = 0
futex(0x401540f4, FUTEX_WAIT, 2, NULL
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

is this one related to the FUTEX problem olof described?


best,

jörn


ps: i'd appreciate being cc:ed on replies. thanks.



for the record:

spunk:~ # uname -a
Linux spunk 2.6.8-24.11-smp #1 SMP Fri Jan 14 13:01:26 UTC 2005 i686 
i686 i386 GNU/Linux

SuSE 9.2

problem happens also on ia32 UP (same version as before) and amd64 UP 
(2.6.11-rc4-bk7)

ldap lookup is ok, for instance

spunk:~ # getent hosts herrnilsson
192.168.0.3     herrnilsson.villakunterbunt.netz herrnilsson

traceroute and others work as well.

on an otherwise identical system without ldap, ping correctly gives 
"unreachable" messages.

