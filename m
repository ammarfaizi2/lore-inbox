Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262388AbVCBRoT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262388AbVCBRoT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 12:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVCBRnv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 12:43:51 -0500
Received: from alog0429.analogic.com ([208.224.222.205]:54956 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262380AbVCBRnG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 12:43:06 -0500
Date: Wed, 2 Mar 2005 12:41:47 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Muthian Sivathanu <muthian_s@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 journal commit performance
In-Reply-To: <20050302165814.70651.qmail@web53704.mail.yahoo.com>
Message-ID: <Pine.LNX.4.61.0503021237110.5955@chaos.analogic.com>
References: <20050302165814.70651.qmail@web53704.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2005, Muthian Sivathanu wrote:

> Hi,
>
> I have a question on ext3 journal commit code.  When a
> transaction is committed in the ordered mode, ext3
> first issues the data writes, waits for them to
> finish, then issues the journal writes, waits for them
> to finish, and then writes out the commit record.
>
> It appears that the first wait (for the data blocks)
> is unnecessary because all that is required is that

Wrong. If you perform two buffered writes back-to-back
will you guarantee that they are both on the disk when
the second finishes? Not on your life! They can (read will)
be reordered depending upon the closest seek. So it is
mandatory that one wait to make sure that both writes
occur in order.

> before the commit, both the data and the metadata
> blocks should be on disk.  This extra wait can
> potentially reduce performance in cases where the
> journal is on a separate disk, because you lose
> parallelism between data writes and the metadata
> writes.
>
> Does anyone have an idea as to why this extra wait was
> introduced?
>
> thanks very much,
> Muthian
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
