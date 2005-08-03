Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVHCQyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVHCQyN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 12:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVHCQyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 12:54:13 -0400
Received: from smtpout.mac.com ([17.250.248.72]:9926 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262340AbVHCQyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 12:54:12 -0400
In-Reply-To: <1123069255.30257.27.camel@gaston>
References: <1122908972.18835.153.camel@gaston> <20050801203728.2012f058.Ballarin.Marc@gmx.de> <1122926885.30257.4.camel@gaston> <20050802095401.GB1442@elf.ucw.cz> <1123069255.30257.27.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D6591B2F-4E98-48A0-A3DD-71AAC564278E@mac.com>
Cc: Pavel Machek <pavel@ucw.cz>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Calling suspend() in halt/restart/shutdown -> not a good idea
Date: Wed, 3 Aug 2005 12:53:57 -0400
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 3, 2005, at 07:40:54, Benjamin Herrenschmidt wrote:
>> I'd like to get rid of shutdown callback. Having two copies of code
>> (one in callback, one in suspend) is ugly.
>
> Well, it's obviously not a good time for this. First, suspend and
> shutdown don't necessarily do the same thing, then it just doesn't  
> work
> in practice. So either do it right completely or not at all, but  
> 2.6.13
> isn't the place for an half-assed hack that looks like a solution to
> you.

One possible way to proceed might be to add a new callback that takes a
pm_message_t: powerdown()  If it exists, it would be called in both the
suspend and shutdown paths, before the suspend() and shutdown() calls to
that driver are made.  As drivers are fixed to clean up and combine that
code, they could put the merged result into the powerdown() function,
and remove their suspend() and shutdown() functions.

Cheers,
Kyle Moffett

--
I lost interest in "blade servers" when I found they didn't throw  
knives at
people who weren't supposed to be in your machine room.
   -- Anthony de Boer


