Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274086AbRISPDc>; Wed, 19 Sep 2001 11:03:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274088AbRISPDM>; Wed, 19 Sep 2001 11:03:12 -0400
Received: from prfdec.natur.cuni.cz ([195.113.56.1]:29195 "EHLO
	prfdec.natur.cuni.cz") by vger.kernel.org with ESMTP
	id <S274087AbRISPDI>; Wed, 19 Sep 2001 11:03:08 -0400
X-Envelope-From: mmokrejs
Posted-Date: Wed, 19 Sep 2001 17:03:32 +0200 (MET DST)
Date: Wed, 19 Sep 2001 17:03:32 +0200 (MET DST)
From: =?iso-8859-2?Q?Martin_MOKREJ=A9?= <mmokrejs@natur.cuni.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: __alloc_pages: 0-order allocation failed still in -pre12
In-Reply-To: <Pine.OSF.4.21.0109191615070.3826-100000@prfdec.natur.cuni.cz>
Message-ID: <Pine.OSF.4.21.0109191651070.3826-100000@prfdec.natur.cuni.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
  one more addition:
I used mysqldump to dump some big database, and here's something weird:

jerboas:/mnt# ls -la
total 372024
drwxr-xr-x    2 root     root           80 Sep 19 16:34 .
drwxr-xr-x   20 root     root         4096 Sep 19 11:32 ..
-rw-r--r--    1 root     root     380946064 Sep 19 16:35 Celegans.sql
jerboas:/mnt# ls -la
ls: Celegans.sql: Value too large for defined data type
total 4
drwxr-xr-x    2 root     root           80 Sep 19 16:34 .
drwxr-xr-x   20 root     root         4096 Sep 19 11:32 ..
[1]-  Done                    /usr/local/mysql/bin/mysqldump -hlocalhost -P3306 -upedant Celegans >Celegans.sql
jerboas:/mnt# ls -la
ls: Celegans.sql: Value too large for defined data type
total 4
drwxr-xr-x    2 root     root           80 Sep 19 16:34 .
drwxr-xr-x   20 root     root         4096 Sep 19 11:32 ..
jerboas:/mnt# 

Running `mc' in this directory says:

File 'Celegans.sql' exists but can not be stat-ed: Value too large for defined data type 

It's on freshly made reiserfs filesystem, if it helps.
Sep 19 16:32:28 jerboas kernel: reiserfs: checking transaction log (device 03:41) ...
Sep 19 16:32:30 jerboas kernel: Using r5 hash to sort names
Sep 19 16:32:30 jerboas kernel: ReiserFS version 3.6.25

The source mysql directory on reiserfs on different disk, has 1693948 kB
(multiple files). In the /mnt it should the dump be all in one file, also
on reiserfs. The machine has 1GB RAM, SMP kernel, HIGHMEM enabled.
-- 
Martin Mokrejs - PGP5.0i key is at http://www.natur.cuni.cz/~mmokrejs
MIPS / Institute for Bioinformatics <http://mips.gsf.de>
GSF - National Research Center for Environment and Health
Ingolstaedter Landstrasse 1, D-85764 Neuherberg, Germany

