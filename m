Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266688AbSLPNNS>; Mon, 16 Dec 2002 08:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266708AbSLPNNS>; Mon, 16 Dec 2002 08:13:18 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:17676 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S266688AbSLPNNR>; Mon, 16 Dec 2002 08:13:17 -0500
Message-Id: <200212161313.gBGDDgs12643@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Bourne <bourne@ToughGuy.net>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Unmounting a busy RO-Filesystem
Date: Mon, 16 Dec 2002 16:03:01 -0200
X-Mailer: KMail [version 1.3.2]
References: <3DFE789B.9020507@ToughGuy.net>
In-Reply-To: <3DFE789B.9020507@ToughGuy.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 December 2002 23:06, Bourne wrote:
> I have 3 partitions. /dev/hda3 for '/' , /dev/hda1 for /boot and
> /dev/hda2 for swap.
>
> I boot & then i do a CTRL+ALT+SYSRQ+U.  '/' and '/boot' are now
> remounted ReadOnly.
>
> 1) cd '/boot'
> 2) umount /boot ----> This gives me an error "Device Busy"

How do you imagine unmounting a directory when you are in it? ;)

> 3) cd /
> 4) umount / -------> No error

This is special case: "umount /" == "mount -o remount,ro /"

> 5) echo $? -----> outputs '0' indicating success. !!!!!!!!
>
> When i do the above by skipping the Sysrq part, i get the usual
> expected errors.

Without SysRq,

# mount -o remount,ro /

fails 'coz you have files open for writing.
You might ask how kernel can do that ro remount with SysRq?
It cheats! ;)
--
vda
