Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968070AbWLENi0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968070AbWLENi0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 08:38:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968185AbWLENi0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 08:38:26 -0500
Received: from fms-01.valinux.co.jp ([210.128.90.1]:60314 "EHLO
	mail.valinux.co.jp" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S968070AbWLENiZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 08:38:25 -0500
From: Magnus Damm <magnus@valinux.co.jp>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Vivek Goyal <vgoyal@in.ibm.com>, magnus.damm@gmail.com,
       fastboot@lists.osdl.org, Magnus Damm <magnus@valinux.co.jp>,
       ebiederm@xmission.com, Andrew Morton <akpm@osdl.org>,
       Rik van Riel <riel@redhat.com>
Date: Tue, 05 Dec 2006 22:37:57 +0900
Message-Id: <20061205133757.25725.96929.sendpatchset@localhost>
Subject: [PATCH 00/02] kexec: Move segment code to assembly files
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kexec: Move segment code to assembly files

The following patches rearrange the lowlevel kexec code to perform idt,
gdt and segment setup code in assembly on the code page instead of doing 
it in inline assembly in the C files.

Our dom0 Xen port of kexec and kdump executes the code page from the 
hypervisor when kexec:ing into a new kernel. Putting as much code as
possible on the code page allows us to keep the amount of duplicated 
code low.

These patches are part of the Xen port of kexec and kdump which recently 
has been accepted into the xen-unstable.hg tree. Sending them upstream
now is an attempt to simplify future porting work.

Signed-off-by: Magnus Damm <magnus@valinux.co.jp>
---

 Applies to 2.6.19.

 arch/i386/kernel/machine_kexec.c     |   59 ----------------------------------
 arch/i386/kernel/relocate_kernel.S   |   58 ++++++++++++++++++++++++++++++---
 arch/x86_64/kernel/machine_kexec.c   |   58 ---------------------------------
 arch/x86_64/kernel/relocate_kernel.S |   50 +++++++++++++++++++++++++---
 4 files changed, 98 insertions(+), 127 deletions(-)
