Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932069AbWC3Gdb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWC3Gdb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 01:33:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWC3Gdb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 01:33:31 -0500
Received: from javad.com ([216.122.176.236]:17424 "EHLO javad.com")
	by vger.kernel.org with ESMTP id S932069AbWC3Gda (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 01:33:30 -0500
From: Sergei Organov <osv@javad.com>
To: linux@horizon.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Lifetime of flash memory
References: <20060329155610.4903.qmail@science.horizon.com>
Date: Thu, 30 Mar 2006 10:33:12 +0400
In-Reply-To: <20060329155610.4903.qmail@science.horizon.com>
	(linux@horizon.com's message of "29 Mar 2006 10:56:10 -0500")
Message-ID: <87acb85tnb.fsf@javad.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

linux@horizon.com writes:

>>> Due to the multiplexing scheme used in high-density NAND flash devices,
>>> even the non-programmed cells are exposed to a fraction of the programming
>>> voltage and there are very low limits on the number of write cycles to
>>> a page before it has to be erased again.  Exceeding that can cause some
>>> unwanted bits to change from 1 to 0.  Typically, however, it is enough
>>> to write each 512-byte portion of a page independently.
>
>> Well, I'm not sure. The Toshiba and Samsung NANDs I've read manuals for
>> seem to limit number of writes to a single page before block erase, --
>> is 512-byte portion some implementation detail I'm not aware of?
>
> No.  I just meant that I generally see "you may program each 2K page a
> maximum of 4 times before performing an erase cycle", and I assume the
> spec came from 2048/512 = 4, so you can program each 512-byte sector
> separately.

I've a file system implementation that writes up to 3 times to the first
3 bytes of the first page of a block (clearing more and more bits every
time), and it seems to work in practice, so maybe this number (4) came
from another source? Alternatively, it works by accident and then I need
to reconsider the design.

-- Sergei.
