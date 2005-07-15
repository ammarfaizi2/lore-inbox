Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbVGOTQz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbVGOTQz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Jul 2005 15:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVGOTQz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Jul 2005 15:16:55 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19601 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261157AbVGOTQr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Jul 2005 15:16:47 -0400
Date: Fri, 15 Jul 2005 12:16:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
cc: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Andrew Morton <akpm@osdl.org>, Jan Blunck <j.blunck@tu-harburg.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic_file_sendpage
In-Reply-To: <Pine.LNX.4.61.0507152100280.12882@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.58.0507151212400.19183@g5.osdl.org>
References: <42D79468.3050808@tu-harburg.de> <20050715040611.05907f4a.akpm@osdl.org>
 <20050715112255.GC2721@wohnheim.fh-wedel.de> <Pine.LNX.4.61.0507151511220.21786@yvahk01.tjqt.qr>
 <Pine.LNX.4.58.0507150904110.19183@g5.osdl.org> <Pine.LNX.4.61.0507152100280.12882@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 15 Jul 2005, Jan Engelhardt wrote:
> >
> >This is why I want to get rid of sendfile(). It's a fundamentally broken
> >interface. Really. In contrast, the pipe buffers _can_ be used for direct
> >socket->file interfaces.
> 
> How will userspace access these pipe buffers?

You can fill them from a user-space buffer with "write()", and you can
read them into a user-space buffer with "read()".

It's really a pipe.

The idea of the pipe buffers is that you can _also_ send them to other 
file descriptors, or fill them from other file descriptors, without having 
to copy the data to/from user space.

		Linus

---
See the example patch that I posted months ago (and that I referred to in 
my other email, here is that thing repeated in case you missed it):

> For anybody interested in zero-copy work, here's a LWN write-up of some of
> the original discussion:
> 
>         http://lwn.net/Articles/118750/
> 
> and my (very ugly) example patch can be found for example here:
> 
>         http://groups-beta.google.com/group/linux.kernel/msg/782bd9e5cb647207?hl=en&
> 
> (it's not a a complete implementation, but it shows how to go from a file
> _to_ a pipe buffer, but not back to a file again).

