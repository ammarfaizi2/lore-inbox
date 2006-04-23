Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751107AbWDWRiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751107AbWDWRiq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Apr 2006 13:38:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbWDWRiq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Apr 2006 13:38:46 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:14258 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751107AbWDWRiq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Apr 2006 13:38:46 -0400
Date: Sun, 23 Apr 2006 19:38:41 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Lukasz Stelmach <stlman@poczta.fm>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: unix socket connection tracking
In-Reply-To: <444B4AE6.4090601@poczta.fm>
Message-ID: <Pine.LNX.4.61.0604231932400.13827@yvahk01.tjqt.qr>
References: <44480BD9.5080100@poczta.fm> <Pine.LNX.4.61.0604211452490.23180@yvahk01.tjqt.qr>
 <4448DF94.5030500@poczta.fm> <Pine.LNX.4.61.0604211610500.31515@yvahk01.tjqt.qr>
 <444A1B86.1060701@poczta.fm> <Pine.LNX.4.61.0604221531190.18093@yvahk01.tjqt.qr>
 <444B4AE6.4090601@poczta.fm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Please understand my situation. I've got GNOME running, gconfd-2 is a "registry"
>management process that accepts connections through a unix domain socket (named
>one) from many *unrelated* (child/parent) processes. In fact from most gnome
>applications. I *do* strace it to see what it does. It does some write(2)s to
>some sockets. I would like to know which socket leads where. Try to strace
>gconfd-2 and you'will see what I mean.
>

UNIX sockets do not necessarily have a path in the filesystem. In fact, 
every socket object you see in the filesystem gets mapped to an object 
within sockfs (which you can't mount). You recognize it as "[socket:147829]"
when looking in /proc/11249/fd/. You will never see /dev/log within
/proc/XX/fd.

You can look at the source of the `lsof` utility which does some socket 
resolution.

lsof:
syslog-ng 3656 root       3u  unix 0xdf70f5e0              6404 /dev/log
gconfd-2 11249 jengelh   14u  unix 0xd4e4f1e0            147829 socket




Jan Engelhardt
-- 
