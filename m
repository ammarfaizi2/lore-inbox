Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268440AbUI2OMt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268440AbUI2OMt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:12:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268372AbUI2OMs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:12:48 -0400
Received: from colossus.systems.pipex.net ([62.241.160.73]:50839 "EHLO
	colossus.systems.pipex.net") by vger.kernel.org with ESMTP
	id S268440AbUI2OMG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:12:06 -0400
Message-ID: <415AC2B3.6070900@tungstengraphics.com>
Date: Wed, 29 Sep 2004 15:12:03 +0100
From: Keith Whitwell <keith@tungstengraphics.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8a3) Gecko/20040817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Discuss issues related to the xorg tree <xorg@freedesktop.org>
Cc: Christoph Hellwig <hch@infradead.org>,
       dri-devel <dri-devel@lists.sourceforge.net>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: New DRM driver model - gets rid of DRM() macros!
References: <9e4733910409280854651581e2@mail.gmail.com>	<20040929133759.A11891@infradead.org>	<415AB8B4.4090408@tungstengraphics.com>	<20040929143129.A12651@infradead.org> <415ABA34.9080608@tungstengraphics.com>
In-Reply-To: <415ABA34.9080608@tungstengraphics.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Whitwell wrote:
> Christoph Hellwig wrote:
> 
>> On Wed, Sep 29, 2004 at 02:29:24PM +0100, Keith Whitwell wrote:
>>
>>> Christoph Hellwig wrote:
>>>
>>>
>>>> - drm_flush is a noop.  a NULL ->flush does the same thing, just easier
>>>> - dito or ->poll
>>>> - dito for ->read
>>>
>>>
>>> Pretty sure you couldn't get away with null for these in 2.4, at least.
>>
>>
>>
>> Umm, of course you could.  There's only a hanfull instance defining a
>> ->flush at all.  Similarly all file_ops for regular files and many char
>> devices don't have ->poll.  no ->read is pretty rare but 2.4 chæcks it
>> aswell.
> 
> 
> I tried it, led to crashes (panics, I guess) & the change had to be 
> reverted.  On reverting the crashes stopped.  This was for poll and read:

Thinking about it, it may not have been a problem of crashing, but rather that 
  the behaviour visible from a program attempting to read (or poll) was 
different with noop versions of these functions to NULL versions, and that was 
causing problems.  This is 18 months ago, so yes, I'm being vague.

The X server does look at this file descriptor, which is where the problem 
would have arisen, but only the gamma & maybe ffb drivers do anything with it.

Keith

