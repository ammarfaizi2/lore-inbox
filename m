Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315666AbSEIJsD>; Thu, 9 May 2002 05:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315671AbSEIJsC>; Thu, 9 May 2002 05:48:02 -0400
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:6648 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S315666AbSEIJsB>; Thu, 9 May 2002 05:48:01 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <E175WFn-000265-00@the-village.bc.nu> 
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: vda@port.imtp.ilyichevsk.odessa.ua, dal_loma@yahoo.com (Amol Lad),
        linux-kernel@vger.kernel.org
Subject: Re: kill task in TASK_UNINTERRUPTIBLE 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 09 May 2002 10:47:28 +0100
Message-ID: <19637.1020937648@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


alan@lxorguk.ukuu.org.uk said:
>  Or waiting on a resource that isnt available - that can occur for
> example with NFS for long periods, or for a few minutes when burning a
> CD and the IDE bus is locked -

Often the main reason for sleeping in uninterruptible state during these 
periods is because the difficulty of performing a sane cleanup exceeds the 
boredom threshold of the programmer. There are plenty of places where 
TASK_UNINTERRUPTIBLE is used just because people have been lazy.

I'm guilty of it too - I use TASK_UNINTERRUPTIBLE for anything which can be
called from jffs2_read_inode() because I was too lazy to chase through a
mechanism by which ->read_inode() may return -ERESTARTSYS without creating a
permanent bad inode. But we're working on it, and this should get fixed in
2.5. 

--
dwmw2


