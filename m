Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264278AbUAHKdL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 05:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264285AbUAHKdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 05:33:11 -0500
Received: from nef.ens.fr ([129.199.96.32]:27911 "EHLO nef.ens.fr")
	by vger.kernel.org with ESMTP id S264278AbUAHKdH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 05:33:07 -0500
To: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: removable media revalidation - udev vs. devfs or static /dev
In-Reply-To: <Pine.LNX.4.58.0401071854500.2131@home.osdl.org>
References: <200401012333.04930.arvidjaar@mail.ru> <20040103055847.GC5306@kroah.com> <Pine.LNX.4.58.0401071036560.12602@home.osdl.org> <20040108031357.A1396@pclin040.win.tue.nl> <Pine.LNX.4.58.0401071815320.12602@home.osdl.org> <20040108034906.A1409@pclin040.win.tue.nl> <Pine.LNX.4.58.0401071854500.2131@home.osdl.org>
Date: Thu, 8 Jan 2004 11:32:58 +0100
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-Id: <20040108103258.4E27638F7@quatramaran.ens.fr>
From: ebrunet@quatramaran.ens.fr ( =?ISO-8859-1?Q?=C9ric?= Brunet)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In ens.mailing-lists.linux-kernel, you wrote:
> Exactly. It works today, because:
>
>  - the device nodes are there.
>
>    Ergo: udev should create the device nodes
>
>  - the kernel autopartitions the device on any open (both main device and 
>    the subpartitions) when it notices a changed media. No polling 
>    required.
>
>    Ergo: the kernel should continue to do this.

Maybe I don't understand the issues, maybe I am going to say something
stupid, but couldn't the problem be solved by adding an extra option to
mount, which would say: if device is a main device and no filesystem on
it, then try to open all subpartitions in turn till a filesystem is
found.

This way, I could just put in fstab
/dev/sda	/mnt/media	auto	mymagicoption	0 0

mount first access sda, forcing a partition read. /dev/sda1 is created
by udev and mount finds it during its scan.

Complexity is in userspace. No polling, no extra device nodes. Policy is
in userspace (what should mount do when it finds two partitions ?
Creates subdirectories ? Fails ? Mount the first one ? The largest one ?
Just add as many mount options as you wish !). Plus it solves an extra
problem: I have zip disks with no partition tables (everything in
/dev/sda), and zip disks with filesystem sometimes in sda1, sometimes in
sda4. Right now, writing a fstab is difficult.

What did I miss ?

Éric Brunet
