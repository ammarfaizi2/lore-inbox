Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314161AbSDMAcf>; Fri, 12 Apr 2002 20:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314162AbSDMAce>; Fri, 12 Apr 2002 20:32:34 -0400
Received: from mail3.aracnet.com ([216.99.193.38]:46468 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S314161AbSDMAcd>; Fri, 12 Apr 2002 20:32:33 -0400
From: "M. Edward Borasky" <znmeb@aracnet.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>,
        "Ravi Wijayaratne" <ravi_wija@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: /proc/stat page in and out values
Date: Fri, 12 Apr 2002 17:32:39 -0700
Message-ID: <HBEHIIBBKKNOBLMPKCBBGEDDELAA.znmeb@aracnet.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <Pine.LNX.4.33L2.0204121422160.31668-100000@dragon.pdx.osdl.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a follow-on answer to this set of questions. Briefly, in
/proc/stat, there are two lines: page <in> <out> and swap <in> <out>. The
"page" values are in kilobytes and the "swap" values are in pages. *And*,
every byte in the "swap" values is double-counted in the "page" values as
well. So, to interpret these numbers, multiply the "page" values by 1024 and
the "swap" values by the page size in bytes. Then subtract the swap values
from the "page" values, and you'll have the number of bytes to and from swap
space and the number of bytes to and from everything else.

One other little note: later on in /proc/stat, there will be a line
containing entries for the individual disks. Those entries count operations,
reads, writes, read "blocks" and write "blocks". In these entries, a "block"
is 512 bytes.

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org
> [mailto:linux-kernel-owner@vger.kernel.org]On Behalf Of Randy.Dunlap
> Sent: Friday, April 12, 2002 2:23 PM
> To: Ravi Wijayaratne
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: /proc/stat page in and out values
>
>
> On Fri, 12 Apr 2002, Ravi Wijayaratne wrote:
>
> | In /proc/stat the record as
> |
> | page x y
> |
> | which indicates cumulative page in and out values.
> | To my best undertstanding this info is stored in
> | kstat.pgpgin and kstat.pgpgout.
> |
> | However the values are incremented in submit_bh in
> | ll_rw_blk.c. So are we actually counting the buffers
> | we write in and out or the pages; or is it the same ?
>
> Please see if
>   http://marc.theaimsgroup.com/?l=linux-kernel&m=101770318012189&w=2
> answers your questions.
>
> --
> ~Randy
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>

