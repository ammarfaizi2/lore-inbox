Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317182AbSHAWqu>; Thu, 1 Aug 2002 18:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317258AbSHAWqu>; Thu, 1 Aug 2002 18:46:50 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:29430 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317182AbSHAWqs>; Thu, 1 Aug 2002 18:46:48 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <Pine.LNX.4.33.0208011538220.1277-100000@penguin.transmeta.com> 
References: <Pine.LNX.4.33.0208011538220.1277-100000@penguin.transmeta.com> 
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, David Howells <dhowells@redhat.com>,
       alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Aug 2002 23:50:11 +0100
Message-ID: <11617.1028242211@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


torvalds@transmeta.com said:
>  It's not the kernel side that is not restartable. It's the _user_
> side. 

As I said, you can't allow it to be interrupted after you've started the 
copy_to_user(). Show me how the userspace program can prove the signal 
arrived _after_ the 'int 0x80' had trapped into the kernel rather then 
beforehand, and I'll accept that you can't allow read() to be interrupted
even before the copy_to_user() starts.

But I also agree that there are other, better, examples of why
TASK_UNINTERRUPTIBLE has to be used sometimes. Page faults in 
copy_{from,to}_user are probably one such.

It's just that it doesn't have to be scattered all over the place just
because people are too lazy to do the cleanup code.

Yeah -- sometimes it's hard. So go shopping.

--
dwmw2


