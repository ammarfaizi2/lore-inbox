Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750787AbVLOS2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750787AbVLOS2L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 13:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbVLOS2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 13:28:11 -0500
Received: from mail.physik.uni-muenchen.de ([192.54.42.129]:17110 "EHLO
	mail.physik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S1750787AbVLOS2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 13:28:10 -0500
Message-ID: <43A1B5B9.2040307@cip.physik.uni-muenchen.de>
Date: Thu, 15 Dec 2005 19:28:09 +0100
From: Patrick Fritzsch <fritzsch@cip.physik.uni-muenchen.de>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050908)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: slow sync of fat 32 hotplugged devices
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,
I checked out suse10 lately and discovered some annoying behaviour in
hotplugging an USB Stick.

It seems that the hal daemon mounts a usbstick in fat32 mode, where
default the sync option ist on. Actually this is a nice behaviour,
because a cp to the stick should last so long until the file was
completly written.

Actually the performance is very bad. A 200 MB file needs around 10
Minutes in sync mode, while it needs around 1 Minute in not synchronous
mode + executing a sync command later.

I guess that the kernel checks after every block of the file, which is
written, if the stick has really written it, which leads to such a big
slowdown. There are already lots of comments of this in the web, where
the solution is always to disable the sync mode in the hal daemon device
files.

Wouldnt it be a nice behaviour, if you could mount a file in a new sync
mode, where it isnt synchronized during writing a file, only when a
close ioctl command was executed on a filehandle?
sync writing to hotplugged devices would be a lot faster then.

greetings,
patrick
