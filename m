Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757537AbWKXA4H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757537AbWKXA4H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 19:56:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757535AbWKXA4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 19:56:07 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:62108 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1757531AbWKXA4E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 19:56:04 -0500
Date: Fri, 24 Nov 2006 11:55:28 +1100
From: David Chinner <dgc@sgi.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Ingo Oeser <netdev@axxeo.de>, David Chinner <dgc@sgi.com>,
       David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
       chatz@melbourne.sgi.com, linux-kernel@vger.kernel.org, xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, netdev@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: 2.6.19-rc6 : Spontaneous reboots, stack overflows - seems to implicate xfs, scsi, networking, SMP
Message-ID: <20061124005528.GF11034@melbourne.sgi.com>
References: <9a8748490611211551v2ebe88fel2bcf25af004c338a@mail.gmail.com> <20061122.201013.112290046.davem@davemloft.net> <20061123070837.GV11034@melbourne.sgi.com> <200611231416.03387.netdev@axxeo.de> <1164307020.3147.3.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1164307020.3147.3.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 23, 2006 at 07:37:00PM +0100, Arjan van de Ven wrote:
> On Thu, 2006-11-23 at 14:16 +0100, Ingo Oeser wrote:
> > Hi there,
> > 
> > David Chinner schrieb:
> > > If the softirqs were run on a different stack, then a lot of these
> 
> softirqs DO run on their own stack!

So they run on a separate stack for 4k stacks on x86?

They don't run on a separate stack for 8k stacks on x86 -
Jesper's traces show that - so this may indicate an issue
with the methodology used to generate the stack overflow
traces inteh first place. i.e. if 4k stacks use a separate
stack, then most of the reported overflows are spurious
and would not normally occur on 4k stack systems..

Can you confirm this, Arjan?

Also, that means that while XFS is apparently only using <1500 bytes
of stack through this path according to the static stack checker
tool, there's more than 2k of extra stack usage that the tool is not
telling me about. i.e. XFS and whatever is above/below it should
have a full 4k to work with. I'd really like to know where that
extra stack space is being used....

Cheers,

Dave.
-- 
Dave Chinner
Principal Engineer
SGI Australian Software Group
