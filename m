Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317674AbSHCSYe>; Sat, 3 Aug 2002 14:24:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317675AbSHCSYe>; Sat, 3 Aug 2002 14:24:34 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:50672 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S317674AbSHCSYc>; Sat, 3 Aug 2002 14:24:32 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200208021738.g72HcCm02802@fachschaft.cup.uni-muenchen.de> 
References: <200208021738.g72HcCm02802@fachschaft.cup.uni-muenchen.de>  <Pine.LNX.4.44.0208020920120.18265-100000@home.transmeta.com> 
To: Oliver Neukum <Oliver.Neukum@lrz.uni-muenchen.de>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Benjamin LaHaise <bcrl@redhat.com>,
       Roman Zippel <zippel@linux-m68k.org>,
       David Howells <dhowells@redhat.com>, alan@redhat.com,
       linux-kernel@vger.kernel.org
Subject: Re: manipulating sigmask from filesystems and drivers 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 03 Aug 2002 19:27:58 +0100
Message-ID: <19180.1028399278@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Oliver.Neukum@lrz.uni-muenchen.de said:
>  So IMHO it would be better to limit this new kind of waiting to
> reading. 

You can do it for write() in the case where no data have yet been written, 
i.e. in prepare_write() first time round the loop. In fact, you can even 
return -ERESTARTNOINTR in that case, just as you can for read() where no 
data have yet been copied into userspace. Whether we want to special-case 
the first time round the loop just to give better responsiveness in the 
common case is debatable though.

You can also do it for open() in 2.5. (in 2.4 the read_inode API gave the
file system no choice but to return a full real inode or a bad one which
remained and prevented subsequent lookups of the same inode.)

--
dwmw2


