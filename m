Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129345AbQKTUDa>; Mon, 20 Nov 2000 15:03:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129411AbQKTUDT>; Mon, 20 Nov 2000 15:03:19 -0500
Received: from edtn006530.hs.telusplanet.net ([161.184.137.180]:17931 "EHLO
	mail.harddata.com") by vger.kernel.org with ESMTP
	id <S129345AbQKTUDE>; Mon, 20 Nov 2000 15:03:04 -0500
Date: Mon, 20 Nov 2000 12:33:00 -0700
From: Michal Jaegermann <michal@harddata.com>
To: linux-kernel@vger.kernel.org
Cc: akenning@dog.topology.org
Subject: Re: easy-to-fix bug in /dev/null driver
Message-ID: <20001120123300.A19251@mail.harddata.com>
In-Reply-To: <20001120160638.A14325@dog.topology.org> <20001121005304.A15760@dog.topology.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.5us
In-Reply-To: <20001121005304.A15760@dog.topology.org>; from Alan Kennington on Tue, Nov 21, 2000 at 12:53:04AM +1030
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2000 at 12:53:04AM +1030, Alan Kennington wrote:
> 
> I still think that write_null() should be rewritten as:
> 
> ===================================================
> static ssize_t write_null(struct file * file, const char * buf,
>                           size_t count, loff_t *ppos)
> {
>         return (count <= 2147483647) ? count : 2147483647;
> }
> =================================================== 
> 
> This would fix the problem without introducing any new errors.
> (Unless someone change the definitions of ssize_t and size_t!!)

Someone already did.  Or, more precisely, there are platforms where
values used in 'return' above are bogus.

Shifting 1 up by sizeof(ssize_t) * 8 - 1 and subtracting one from
the result, in order to derive the maximal allowable value, might work.
I do not think that we have anything with non-8 bit bytes yet.

  Michal
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
