Return-Path: <linux-kernel-owner+w=401wt.eu-S1161117AbXAEOrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161117AbXAEOrt (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 09:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161118AbXAEOrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 09:47:49 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:42138 "HELO
	embla.aitel.hist.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1161117AbXAEOrs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 09:47:48 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Jan 2007 09:47:47 EST
Message-ID: <459E62FF.4010404@aitel.hist.no>
Date: Fri, 05 Jan 2007 15:38:55 +0100
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Icedove 1.5.0.9 (X11/20061220)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
CC: Hua Zhong <hzhong@gmail.com>, Christoph Hellwig <hch@infradead.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'Linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: open(O_DIRECT) on a tmpfs?
References: <003f01c7302f$e72164b0$0200a8c0@nuitysystems.com> <Pine.LNX.4.64.0701041911470.27405@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0701041911470.27405@blonde.wat.veritas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hugh Dickins wrote:
> On Thu, 4 Jan 2007, Hua Zhong wrote:
>   
>> So I'd argue that it makes more sense to support O_DIRECT
>> on tmpfs as the memory IS the backing store.
>>     
>
> A few more voices in favour and I'll be persuaded.  Perhaps I'm
> out of date: when O_DIRECT came in, just a few filesystems supported
> it, and it was perfectly normal for open O_DIRECT to be failed; but
> I wouldn't want tmpfs to stand out now as a lone obstacle.
>   
Having tmpfs suppoting O_DIRECT makes sense.
For me, O_DIRECT says "write directly to the device
and don't return till its done."  Which is what tmpfs
always do anyway.

The support could probably be as simple as ignoring
the flag entirely, mask it away in open() or something like that.


Arguments about "O_DIRECT says don't cache it and tmpfs
_is_ the cache" don't work.  O_DIRECT says "write straight
to the device" and the device just happens to be pagecache
memory.  The tmpfs file sure isn't cached elsewhere in
addition to its tmpfs pages.

Helge Hafting

