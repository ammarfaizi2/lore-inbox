Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTL2To4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbTL2ToG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:44:06 -0500
Received: from prin.lo2.opole.pl ([213.77.100.98]:1555 "EHLO prin.lo2.opole.pl")
	by vger.kernel.org with ESMTP id S264479AbTL2TmO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:42:14 -0500
From: Mariusz Mazur <mmazur@kernel.pl>
To: linux-kernel@vger.kernel.org
Subject: Should struct inode be made available to userspace?
Date: Mon, 29 Dec 2003 20:40:00 +0100
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Message-Id: <200312292040.00409.mmazur@kernel.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Inside __KERNEL__ block in linux/fs.h there is a definition (looks rather 
kernel specific) of struct inode. This structure is used all over the 
headers, specificaly in ${fsname}_fs_i.h files containing 
${fsname}_inode_info structures. The problem is ${fsname}_fs_i.h files are  
included in ${fsname}_fs.h files which in turn are often used by various 
programs. This results in compile time errors since normal programs don't 
define __KERNEL__ (they shouldn't) and thus while parsing 
${fsname}_inode_info structures do not have access to the inode structure 
("error: field `vfs_inode' has incomplete type").
What is the complete, politicaly correct solution? (workarounds are of no use 
to me)
Is it (a) struct inode should be made available to userspace (yuck), (b) no 
!kernel code should use struct inode (linux/${fsname}_fs_i.h files shouldn't 
be included anywhere... hell... maybe all linux/${fsname}* files shouldn't be 
available outside kernel!) or (c) this kind of structures should come with 
apps using it and not be a part of any kernel derived userspace headers.



-- 
Ka¿dy cz³owiek, który naprawdê ¿yje, nie ma charakteru, nie mo¿e go mieæ.
Charakter jest zawsze martwy, otacza ciê zgni³a struktura przeniesiona z 
przesz³o¶ci. Je¿eli dzia³asz zgodnie z charakterem wtedy nie dzia³asz w ogóle
- jedynie mechanicznie reagujesz.                 { Osho }
