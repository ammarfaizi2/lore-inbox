Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262055AbTJSSV3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 14:21:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262061AbTJSSV3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 14:21:29 -0400
Received: from flock1.newmail.ru ([212.48.140.157]:29602 "HELO
	flock1.newmail.ru") by vger.kernel.org with SMTP id S262055AbTJSSV1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 14:21:27 -0400
From: Sinelnikov Evgeny <linux4sin@mail.ru>
Organization: Saratov State University
To: cpb@log2.net
Subject: Re: util-linux-2.12: did you find a fix?
Date: Sun, 19 Oct 2003 22:26:11 +0400
User-Agent: KMail/1.5.3
References: <20031019060328.25277.qmail@log2.net>
In-Reply-To: <20031019060328.25277.qmail@log2.net>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200310192226.11583.linux4sin@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>     I read your email on LKML about the problem compiling util-linux-2.12
> with linux-2.6.0-test5 headers (the problem with _IOC_TYPECHECK).
> Did you find a way to fix the problem? If you solved it, could you tell
> me how to fix the util-linux problem?

I solved it so:
asm/ioctl.h:
...............
/* used to create numbers */
#define _IO(type,nr)            _IOC(_IOC_NONE,(type),(nr),0)
#define _IOR(type,nr,size)      
_IOC(_IOC_READ,(type),(nr),(_IOC_TYPECHECK(size)))
#define _IOW(type,nr,size)      
_IOC(_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
#define _IOWR(type,nr,size)     
_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),(_IOC_TYPECHECK(size)))
#define _IOR_BAD(type,nr,size)  _IOC(_IOC_READ,(type),(nr),sizeof(size))
#define _IOW_BAD(type,nr,size)  _IOC(_IOC_WRITE,(type),(nr),sizeof(size))
#define _IOWR_BAD(type,nr,size) 
_IOC(_IOC_READ|_IOC_WRITE,(type),(nr),sizeof(size))
.....................
I patched all files that contains next defines:
_IOR, _IOW or _IOWR
with
_IOR_BAD, _IOW_BAD, _IOWR_BAD

Really it is not right. 
But it would be so if I complie with 2.4.x headers

sizeof(sizeof(anymore)) is sizeof(int). And threre was int. Thus it was right 
only there.

Sin (Sinelnikov Evgeny)

