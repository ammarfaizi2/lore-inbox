Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262907AbVA2Msl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262907AbVA2Msl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 07:48:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262908AbVA2Msl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 07:48:41 -0500
Received: from main.gmane.org ([80.91.229.2]:20191 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262907AbVA2Msi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 07:48:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Richard Hughes <ee21rh@surrey.ac.uk>
Subject: OpenOffice crashes due to incorrect access permissions on /dev/dri/card*
Date: Sat, 29 Jan 2005 12:49:16 +0000
Message-ID: <pan.2005.01.29.12.49.13.177016@surrey.ac.uk>
References: <pan.2005.01.29.10.44.08.856000@surrey.ac.uk> <E1CurmR-0000H8-00@calista.eckenfels.6bone.ka-ip.net>
Reply-To: ee21rh@surrey.ac.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: host217-43-20-137.range217-43.btcentralplus.com
User-Agent: Pan/0.14.2 (This is not a psychotic episode. It's a cleansing moment of clarity.)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jan 2005 13:32:47 +0100, Bernd Eckenfels wrote:
> it is not a permission thing, it tells you, that you have not card14 - and i
> dont know the dri interface but it looks unlikely that there ever will be
> one .)

I figured (maybe incorrectly) that oo was just going thru the dri card*
files:

stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card8", 0xbfec2e8c)    = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card9", 0xbfec2e8c)    = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card10", 0xbfec2e8c)   = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card11", 0xbfec2e8c)   = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card12", 0xbfec2e8c)   = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card13", 0xbfec2e8c)   = -1 ENOENT (No such file or directory)
geteuid32()                             = 500
stat64("/dev/dri", {st_mode=S_IFDIR|0755, st_size=80, ...}) = 0
stat64("/dev/dri/card14", 0xbfec2e8c)   = -1 ENOENT (No such file or directory)
munmap(0x9b4838, 8192)                  = -1 EINVAL (Invalid argument)
munmap(0x9d55248, 3219928560)           = -1 EINVAL (Invalid argument)
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++

from 0 to 14 until it found a card that it could use. The root cause
has to be that it can't use dri/card* because of access permissions.

Note, that strace glxgears gives exactly the same output, going from 0 to
14 and then seg-faulting, so it's *not just a oo problem*.

Richard Hughes

-- 

http://www.hughsie.com/PUBLIC-KEY


