Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318084AbSGWOyd>; Tue, 23 Jul 2002 10:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318080AbSGWOyd>; Tue, 23 Jul 2002 10:54:33 -0400
Received: from master2.astro.unibas.ch ([131.152.181.21]:37638 "EHLO
	master2.astro.unibas.ch") by vger.kernel.org with ESMTP
	id <S318084AbSGWOyc>; Tue, 23 Jul 2002 10:54:32 -0400
Date: Tue, 23 Jul 2002 16:57:41 +0200
From: Hans Schwengeler <schweng@master2.astro.unibas.ch>
Message-Id: <200207231457.QAA01550@master2.astro.unibas.ch>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: freeze during NFS copy to IDE disks kernel 2.5.27
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dear maintainers,

	I'm trying to get a machine running daily backups to its Maxtor 160GB
disks for weeks now without success. The machine always hangs during the copy
process.
First try: kernel 2.5.23 on a Pentium-4 PC running debian linux 2.2 (potato).
           motherboard: GigaByte GA-8iRXP
           processor: P-4 1.6Ghz
           ram: 512 MB DDR-RAM
           disks: 6 Maxtor 160 GB (2 on the MB-IDE, 4 on the onboard Raid/ATA
                                   controller Promise 20276)

Second try: kernel 2.5.24, 2.5.25, 2.5.27

Thrird try: add separate IDE system disk (IBM Deskstar 80GB)
            -> it also locks up.

Usually I start the copying with crontab at mightnight. Lockup happens after
5-10 min., sometimes after a few hours, once or twice the machine ran for 2-3
days. But if I start the copying by hand, the freezing occurs as well.

I have the source files NFS mounted from the other linux and tru64 unix 
machines. Then I do:
#! /bin/sh
date
/bin/cp -Rdp /juno/home /backup1/juno/
date
/bin/cp -Rdp /juno/data1 /backup1/juno/
date
/bin/cp -Rdp /juno/data2 /backup1/juno/
date

and so on. Usually just the first date appears in the log file.
Nothing gets logged in /var/log/messages or kern.log.

Fourth try: remove all Maxtor disks and run only with the system disk -> freeze.

Fifth try: use another machine (AMD Dual processor 1900+ MP on a MSI K7D
           motherboard) with the system disk from the P4 system. 
           kernel 2.5.25 and 2.5.27 lock up. *but* kernel 2.2.19pre17 runs ok.
           (although cannot be used with the large Maxtor disks, i.e.
            no support for disks bigger than 137GB, no 20276 suport).

I am at a loss what to do. It seems that all 2.5 kernels that I have tested
have serious problems with IDE (at least in combination with NFS).



Yours, Hans Schwengeler
