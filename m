Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268582AbUI2O5m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268582AbUI2O5m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268637AbUI2Oyk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:54:40 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:29605 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S268502AbUI2O1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:27:17 -0400
Message-ID: <415AC640.3090407@tungstengraphics.com>
Date: Wed, 29 Sep 2004 15:27:12 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Discuss issues related to the xorg tree <xorg@freedesktop.org>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
References: <9e4733910409280854651581e2@mail.gmail.com> <20040929133759.A11891@infradead.org> <415AB8B4.4090408@tungstengraphics.com> <20040929143129.A12651@infradead.org> <415ABA34.9080608@tungstengraphics.com> <415AC2B3.6070900@tungstengraphics.com> <20040929151601.A13135@infradead.org>
In-Reply-To: <20040929151601.A13135@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Wed, Sep 29, 2004 at 03:12:03PM +0100, Keith Whitwell wrote:
> 
>>Thinking about it, it may not have been a problem of crashing, but rather that 
>>  the behaviour visible from a program attempting to read (or poll) was 
>>different with noop versions of these functions to NULL versions, and that was 
>>causing problems.  This is 18 months ago, so yes, I'm being vague.
>>
>>The X server does look at this file descriptor, which is where the problem 
>>would have arisen, but only the gamma & maybe ffb drivers do anything with it.
> 
> 
> Indeed, for read you're returning 0 now instead of the -EINVAL from common
> code when no ->read is present.  I'd say the current drm behaviour is a bug,
> but if X drivers rely on it.

I'd agree, but it's a widely distributed bug.  I guess we can fix it in the X 
server, but even better would be to rip out the code as it's fundamentally 
misguided, based on a wierd idea that the kernel would somehow ask the X 
server to perform a context switch between two userspace clients...

Keith
