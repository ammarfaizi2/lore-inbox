Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751063AbWA2QPD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbWA2QPD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jan 2006 11:15:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751065AbWA2QPD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jan 2006 11:15:03 -0500
Received: from mx3.mail.ru ([194.67.23.149]:35148 "EHLO mx3.mail.ru")
	by vger.kernel.org with ESMTP id S1751063AbWA2QPC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jan 2006 11:15:02 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: Does /sys/module/foo reflect external module name?
Date: Sun, 29 Jan 2006 19:14:47 +0300
User-Agent: KMail/1.9.1
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601291914.48318.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Is it correct that /sys/module lists module *file* names (sans -_ confusion)? 
Is it possible to find out if module is built in or truly external? The goal 
is to automate initrd build by walking from /dev/root up and pulling in all 
modules. Now missing module may mean that it is built in or that it is really 
missing :) In my case:

{pts/1}% for i in /sys/module/*
for> do
for> grep -q ${i:t} /proc/modules || echo $i
for> done
/sys/module/8250
/sys/module/i8042
/sys/module/md_mod
/sys/module/psmouse
/sys/module/tcp_bic
{pts/1}% for i in $(lsmod | awk '{print $1}')
do
[[ -d /sys/module/$i ]] || echo $i
done
Module

so it looks quite reliable up to built in modules. Is there any information 
that could be exported in sysfs (like "builtin" == 0|1)?

TIA

- -andrey
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD3On4R6LMutpd94wRAiAxAJ9859hlkCu9BpTmry+82fuCDeJoJQCfQ5cx
DTOPjNg3P6n8zyH2rthS4yE=
=D+H5
-----END PGP SIGNATURE-----
