Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265886AbUANAIK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 19:08:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266207AbUANAHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 19:07:08 -0500
Received: from main.gmane.org ([80.91.224.249]:39142 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266149AbUANAFU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 19:05:20 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: HPT372 DMA corruption
Date: Wed, 14 Jan 2004 01:05:17 +0100
Message-ID: <yw1xu12z9yyq.fsf@kth.se>
References: <20040109150501.A5891@timetrax.localdomain> <Pine.LNX.4.53.0401091517390.1022@chaos>
 <20040113183029.A16406@timetrax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:MWVFeZIWLmGcW8DmTUhH616lO+A=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chuck Berg <chuck@encinc.com> writes:

> On Fri, Jan 09, 2004 at 03:24:28PM -0500, Richard B. Johnson wrote:
> [cmp -l bad good]
>> >  89260029   0  31
>> >  89260030   0 327
>> >  89260031   0 200
>> >  89260032   0  13
>> 
>> Since whole bytes are not written, this looks strangely like
>> an attempt to DMA to cached RAM! Since the CPU didn't write
>
> I tested this by reading with O_DIRECT, and immediately after each read(),
> read all of a 1MB array (my cache is only 256kB), and then checking the
> data. The same corruption occurs. 
>
> Via had a DMA corruption bug a couple years ago with similar symptoms,
> apparently with the VT82C686B southbridge. Mine is a VT82C586B (which some
> people also reported problems with). My board dates long after these
> problems were discovered, so I sure hope it's not the same bug. I'll try
> upgrading my BIOS to the latest version in case Soyo's changelog is not
> entirely honest.

Well, VIA never did have a good reputation.

> I did learn some more about the pattern of corruption. The data is not
> being written to memory - the "bad" data is whatever happened to be there
> before. It usually happens in 4, but sometimes 64 or 32 byte chunks.

Is it always a multiple of 4 bytes?  Is there any pattern in the
position of the corruption, such as always aligned to some value?

> When I read from the device with O_DIRECT, the corruption only
> appears at the very end of the read. I've confirmed this for reads
> of 512 bytes through 256k at multiples of 512 bytes.

Could something be cutting off the DMA transfer too early?

-- 
Måns Rullgård
mru@kth.se

