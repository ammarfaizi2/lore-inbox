Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266550AbUFQPcm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266550AbUFQPcm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 11:32:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266528AbUFQPcl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 11:32:41 -0400
Received: from cantor.suse.de ([195.135.220.2]:43736 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S266546AbUFQPb7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 11:31:59 -0400
To: Finn Thain <ft01@webmastery.com.au>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: make checkstack on m68k
References: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be>
	<je3c4uqum0.fsf@sykes.suse.de>
	<Pine.LNX.4.58.0406180048180.13963@bonkers.disegno.com.au>
From: Andreas Schwab <schwab@suse.de>
X-Yow: Hmmm...  a PINHEAD, during an EARTHQUAKE, encounters an ALL-MIDGET
 FIDDLE
 ORCHESTRA...  ha..  ha..
Date: Thu, 17 Jun 2004 17:31:58 +0200
In-Reply-To: <Pine.LNX.4.58.0406180048180.13963@bonkers.disegno.com.au> (Finn
 Thain's message of "Fri, 18 Jun 2004 01:17:31 +1000 (EST)")
Message-ID: <jeoenip5e9.fsf@sykes.suse.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Finn Thain <ft01@webmastery.com.au> writes:

> On Thu, 17 Jun 2004, Andreas Schwab wrote:
>
>> Geert Uytterhoeven <geert@linux-m68k.org> writes:
>>
>> > I tried to add m68k support to `make checkstack', but got stuck due to my
>> > limited knowledge of complex perl expressions. I actually need to catch both
>> > expressions (incl. the one I commented out). Anyone who can help?
>>
>> Untested:
>>
>>   $re = qr/.*(?:linkw %fp,|addw )#-([0-9]{1,4})(?:,%sp)?$/o;
>>
>> Andreas.
>
> I think that should be addaw, not addw.

Right, typo.

> And it may be necessary to remove the $ anchor at the end.

That won't work, because we must be sure to require ",%sp" when addaw is
matched since we don't want to match, say, "addaw #-1024,%a0".  We know
that this is the whole line to be matched.

> Your solution makes very nice use of the fact that objdump produces
> exactly one comma for those opcodes :)

We know exactly the format of the output produced by objdump.  So even
though the regex is able to match some random junk we know that objdump
would never produce that.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux AG, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
