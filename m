Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263671AbUEGQRH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263671AbUEGQRH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 12:17:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263684AbUEGQRH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 12:17:07 -0400
Received: from outgoingmail.adic.com ([63.81.117.28]:22972 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S263671AbUEGQRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 12:17:03 -0400
Message-ID: <409BB532.50904@xfs.org>
Date: Fri, 07 May 2004 11:11:30 -0500
From: Steve Lord <lord@xfs.org>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Dave Jones <davej@redhat.com>, Paul Jakma <paul@clubi.ie>,
       Valdis.Kletnieks@vt.edu, Andrew Morton <akpm@osdl.org>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.6-rc3-mm2 (4KSTACK)
References: <20040505013135.7689e38d.akpm@osdl.org> <200405051312.30626.dominik.karall@gmx.net> <200405051822.i45IM2uT018573@turing-police.cc.vt.edu> <20040505215136.GA8070@wohnheim.fh-wedel.de> <200405061518.i46FIAY2016476@turing-police.cc.vt.edu> <1083858033.3844.6.camel@laptop.fenrus.com> <Pine.LNX.4.58.0405070136010.1979@fogarty.jakma.org> <20040507065105.GA10600@devserv.devel.redhat.com> <20040507151317.GA15823@redhat.com> <409BAFAC.70601@xfs.org> <20040507155941.GA17850@devserv.devel.redhat.com>
In-Reply-To: <20040507155941.GA17850@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Fri, May 07, 2004 at 10:47:56AM -0500, Steve Lord wrote:
> 
>>>-	if (mlen > sizeof(buf))
>>>+	obj.data = kmalloc(1024, GFP_KERNEL);
>>>+	if (!obj.data)
>>>+		return -ENOMEM;
>>>+
>>>+	if (mlen > 1024) {
>>
>>That's what I hate about all of this, just think how much stack that
>>kmalloc can take in low memory situations.... it might end up in
>>writepage on another nfs file....
> 
> 
> it clearly needs to be GFP_NOFS

That was not really my point, consider any memory allocation on the
stack which is being replaced with an allocate to save space. Then replace
the saved stack space with the potential stack space used to
free memory by writing it out via a filesystem. You cannot make all
the allocations in the kernel GFP_NOFS.

Now at least if the memory is allocated high enough up in the
call chain it fixes the problems of a function with a large
stack frame with a deep stack underneath it. It does not fix
anything if the function is already deep in the stack.

All this is doing is papering over the cracks.

Steve


