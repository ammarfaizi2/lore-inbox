Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262629AbVCPPPP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262629AbVCPPPP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 10:15:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262631AbVCPPOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 10:14:47 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:6114 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262617AbVCPPNL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 10:13:11 -0500
In-Reply-To: <20050316025339.318fc246.sfr@canb.auug.org.au>
References: <20050315143412.0c60690a.sfr@canb.auug.org.au> <0961a209ce72bb9f2a01b163aa6e6fbd@penguinppc.org> <20050316025339.318fc246.sfr@canb.auug.org.au>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <303a387c46a384eb8afa7cce8c7e3225@penguinppc.org>
Content-Transfer-Encoding: 7bit
Cc: akpm@osdl.org, linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
From: Hollis Blanchard <hollis@penguinppc.org>
Subject: Re: [PATCH] PPC64 iSeries: cleanup viopath
Date: Wed, 16 Mar 2005 09:12:51 -0600
To: Stephen Rothwell <sfr@canb.auug.org.au>
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 15, 2005, at 9:53 AM, Stephen Rothwell wrote:

> On Tue, 15 Mar 2005 08:32:27 -0600 Hollis Blanchard 
> <hollis@penguinppc.org> wrote:
>>
>> On Mar 14, 2005, at 9:34 PM, Stephen Rothwell wrote:
>>>
>>> Since you brought this file to my attention, I figured I might as 
>>> well
>>> do
>>> some simple cleanups.  This patch does:
>>> 	- single bit int bitfields are a bit suspect and Anndrew pointed
>>> 	  out recently that they are probably slower to access than ints
>>
>>> --- linus/arch/ppc64/kernel/viopath.c	2005-03-13 04:07:42.000000000
>>> +1100
>>> +++ linus-cleanup.1/arch/ppc64/kernel/viopath.c	2005-03-15
>>> 14:02:48.000000000 +1100
>>> @@ -56,8 +57,8 @@
>>>   * But this allows for other support in the future.
>>>   */
>>>  static struct viopathStatus {
>>> -	int isOpen:1;		/* Did we open the path?            */
>>> -	int isActive:1;		/* Do we have a mon msg outstanding */
>>> +	int isOpen;		/* Did we open the path?            */
>>> +	int isActive;		/* Do we have a mon msg outstanding */
>>>  	int users[VIO_MAX_SUBTYPES];
>>>  	HvLpInstanceId mSourceInst;
>>>  	HvLpInstanceId mTargetInst;
>>
>> Why not use a byte instead of a full int (reordering the members for
>> alignment)?
>
> Because "classical" boleans are ints.
>
> Because I don't know the relative speed of accessing single byte 
> variables.

I didn't see the original observation that bitfields are slow. If the 
argument was that loading a bitfield requires a load then mask, then 
you'll be happy to find that PPC has word, halfword, and byte load 
instructions. So loading a byte (unsigned, as Brad pointed out) should 
be just as fast as loading a word.

> It really makes little difference, I was just trying to get rid of the
> silly signed single bit bitfields ...

I understand. I was half being nitpicky, and half wondering if there 
was an actual reason I was missing.

-Hollis

