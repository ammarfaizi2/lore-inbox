Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317025AbSHAW0M>; Thu, 1 Aug 2002 18:26:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317182AbSHAW0M>; Thu, 1 Aug 2002 18:26:12 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:13302 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317025AbSHAW0L>; Thu, 1 Aug 2002 18:26:11 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0208011430450.1647-100000@penguin.transmeta.com> 
References: <Pine.LNX.4.33.0208011430450.1647-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, David Howells <dhowells@redhat.com>,
       alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Aug 2002 23:29:31 +0100
Message-ID: <11294.1028240971@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  Any regular file IO is supposed to give you the full result. 

read(2) is permitted to return -EINTR. Granted, we shouldn't allow it to be
interrupted and return a partial read after the point we start to
copy_to_user(), but before then it's fair game.

Regular file I/O through the page cache is inherently restartable, anyway, 
as long as you're careful about fpos.

There are better examples where you really can't have a cleanup path without
severe pain, even using ERESTARTNOINTR, and I was only joking about removing
TASK_UNINTERRUPTIBLE _entirely_ -- but the point remains that reducing its
usage would be nice.

--
dwmw2


