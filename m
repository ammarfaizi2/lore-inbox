Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265661AbUBBJlj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 04:41:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265682AbUBBJlj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 04:41:39 -0500
Received: from f16.mail.ru ([194.67.57.46]:5128 "EHLO f16.mail.ru")
	by vger.kernel.org with ESMTP id S265661AbUBBJli (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 04:41:38 -0500
From: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	<arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: duplicated inode numbers for different files=?koi8-r?Q?=3F?=
Mime-Version: 1.0
X-Mailer: mPOP Web-Mail 2.19
X-Originating-IP: [212.248.25.26]
Date: Mon, 02 Feb 2004 12:41:37 +0300
Reply-To: =?koi8-r?Q?=22?=Andrey Borzenkov=?koi8-r?Q?=22=20?= 
	  <arvidjaar@mail.ru>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Message-Id: <E1AnaaH-000HCr-00.arvidjaar-mail-ru@f16.mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Are inode numbers supposed to be unique inside a filesystem? There
is some code in nfsd (at least in 2.4) that suggests that it is not
always the case.

Background:

Supermount is currently using 1-to-1 correspondence
between super- and subfs inodes. This is OK for all except root
inode - it still has to have some inode number for root all the time.
So it assigns arbitrary number and changes it after subfs has been
mounted to reflect subfs root.

This breaks for NFS (at least for Linux client, cannot test any other)
because NFS thinks root inode changed after having been mounted
and gives up.

idea is to use fixed root number; it can be done but may result
in duplicated number. Using ino == 0 may lessen chances (is it valid
BTW?)

Hmm ... actually if subfs is allowed to have duplicated inode numbers
then supermount needs different get inode implementation anyway.

TIA

-andrey
