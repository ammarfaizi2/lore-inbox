Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265303AbUKAOyy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265303AbUKAOyy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 09:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265166AbUKAOtx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 09:49:53 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:62911 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261785AbUKAOtO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 09:49:14 -0500
Date: Mon, 1 Nov 2004 15:49:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: John M Collins <jmc@xisl.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fchown on unix domain sockets?
In-Reply-To: <200411011441.56524.jmc@xisl.com>
Message-ID: <Pine.LNX.4.53.0411011546050.30106@yvahk01.tjqt.qr>
References: <200410312255.00621.jmc@xisl.com> <Pine.LNX.4.53.0411011517570.29275@yvahk01.tjqt.qr>
 <200411011441.56524.jmc@xisl.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> As some manpage might say, the socket thing you see in "ls -l" is just a
>> reference thing. When you connect to it, ls -l /proc/pidofprogram/fd/ does
>> not show the path, but [socket:xxxx] which shows that the filesystem object
>> is not used anymore.
>
>When I connect to it is the point. I want to set the permissions etc so that
>only the progams that are supposed to be talking to it talk to it.

How about setting the permissions beforehand?

>> >I don't mind it not working but I think it should report an error. This is
>> > on 2.6.3 kernel.
>>
>> What would you like it to do? EINVAL like the others or change the actual
>> inode's permission?
>
>I don't mind. I think it's a meaninful thing to want to do, but if you can't
>do it that way, fine, just let me know with some error code.

There is no chmod op in struct proto_ops in include/linux/net.h.
Thus, all socket types should behave the same when fchmod() is used on their
FDs.

To summarize in short, you could only fchmod() a socket if you open()ed it
rather than by socket(), but otoh, open() is denied for sockets. What a
deadlock ;-)

I think it's this line in fs/open.c:
        file = fget(fd);
Since you (AFAIK) can't get a "struct file" from a socketfd.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
