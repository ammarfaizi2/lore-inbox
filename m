Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129599AbQKCHGE>; Fri, 3 Nov 2000 02:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129834AbQKCHFy>; Fri, 3 Nov 2000 02:05:54 -0500
Received: from p3EE0A497.dip.t-dialin.net ([62.224.164.151]:20471 "EHLO fuji")
	by vger.kernel.org with ESMTP id <S129599AbQKCHFk>;
	Fri, 3 Nov 2000 02:05:40 -0500
Date: Fri, 3 Nov 2000 08:05:24 +0100
From: Marc Lehmann <pcg@goof.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Paul Marquis <pmarquis@iname.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: select() bug
Message-ID: <20001103080524.E29820@fuji.laendle>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Paul Marquis <pmarquis@iname.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3A01FC44.8A43FE8B@iname.com> <E13rUD4-00026g-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E13rUD4-00026g-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Nov 02, 2000 at 11:55:52PM +0000
X-Operating-System: Linux version 2.2.17 (root@fuji) (gcc version pgcc-2.95.2 19991024 (release)) 
X-Copyright: copyright 2000 Marc Alexander Lehmann - all rights reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2000 at 11:55:52PM +0000, Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> > - If I'm correct that pipes have a 4K kernel buffer, then writing 1
> > byte shouldn't cause this situation, as the buffer is well more than
> > half empty.  Is this still a bug?
> 
> The pipe code uses totally full/empty. Im not sure why that was chosen

Just a quick guess: maybe because of the POSIX atomicity guarantees (if
select returned, write might have to block which is not what is expected),
and maybe this limitation was used not only on write but on read (Although
it's not necessary on the read side, AFAIK).

-- 
      -----==-                                             |
      ----==-- _                                           |
      ---==---(_)__  __ ____  __       Marc Lehmann      +--
      --==---/ / _ \/ // /\ \/ /       pcg@opengroup.org |e|
      -=====/_/_//_/\_,_/ /_/\_\       XX11-RIPE         --+
    The choice of a GNU generation                       |
                                                         |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
