Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282347AbRKXCdv>; Fri, 23 Nov 2001 21:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282348AbRKXCdl>; Fri, 23 Nov 2001 21:33:41 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:56335 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S282347AbRKXCdY>; Fri, 23 Nov 2001 21:33:24 -0500
Message-ID: <3BFF06CA.71B99D3C@zip.com.au>
Date: Fri, 23 Nov 2001 18:32:42 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oliver Xymoron <oxymoron@waste.org>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: ext3: kjournald and spun-down disks
In-Reply-To: <3BFEF71A.F32176FE@zip.com.au> <Pine.LNX.4.40.0111231939000.4162-100000@waste.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oliver Xymoron wrote:
> 
> > Tell me if this is joyful:
> 
> Haven't tried it yet, but I'm afraid I don't see what makes it actually
> sync with the dirty buffer flush. Wouldn't it be better to export a chain
> of flush funcs hung off a timer?

It doesn't sync with kupdate.

If you want to do that, just defeat the journal timer altogether. So:

        transaction->t_expires = jiffies + 1000000000;

in get_transaction().   That way, kupdate's write_super() will
run a commit every bdf_prm.b_un.interval jiffies.

-
