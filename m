Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVAKA6W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVAKA6W (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 19:58:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262559AbVAKA4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 19:56:48 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:39388 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262656AbVAKAEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 19:04:11 -0500
To: Dave <dave.jiang@gmail.com>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org, smaurer@teja.com,
       linux@arm.linux.org.uk, dsaxena@plexity.net, drew.moseley@intel.com
X-Message-Flag: Warning: May contain useful information
References: <8746466a050110153479954fd2@mail.gmail.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 10 Jan 2005 16:04:05 -0800
In-Reply-To: <8746466a050110153479954fd2@mail.gmail.com> (Dave's message of
 "Mon, 10 Jan 2005 16:34:03 -0700")
Message-ID: <52u0poygp6.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: clean way to support >32bit addr on 32bit CPU
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 11 Jan 2005 00:04:06.0049 (UTC) FILETIME=[10EC1910:01C4F771]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Dave> I have this ARM (XScale) based platform that supports 36bit
    Dave> physical addressing. Due to the way the ATU is designed, the
    Dave> outbound memory translation window is fixed outside the
    Dave> first 4GB of memory space, and thus the need to use 64bit
    Dave> addressing in order to access the PCI bus. After all said
    Dave> and done, the struct resource members start and end must
    Dave> support 64bit integer values in order to work. On a 64bit
    Dave> arch that would be fine since unsigned long is
    Dave> 64bit. However on a 32bit arch one must use unsigned long
    Dave> long to get 64bit. However, if we do that then it would make
    Dave> the 64bit archs to have 128bit start and end and probably
    Dave> wouldn't be something we'd want. What would be a nice clean
    Dave> way to support this that's acceptable to Linux? I guess this
    Dave> issue would be similar to x86-32 PAE would have?

Actually unsigned long long is still 64 bits even on 64-bit Linux
architectures.  However it might make more sense to use an explicit
size for the resource addresses, namely u64.

This XScale architecture seems similar to the PowerPC 440, which also
uses 36-bit addressing for various buses including PCI.  You might
want to take a look at arch/ppc for inspiration.

 - Roland
