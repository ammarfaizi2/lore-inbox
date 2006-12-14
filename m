Return-Path: <linux-kernel-owner+w=401wt.eu-S1751975AbWLNXfO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751975AbWLNXfO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 18:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751973AbWLNXfO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 18:35:14 -0500
Received: from smtp131.iad.emailsrvr.com ([207.97.245.131]:37091 "EHLO
	smtp131.iad.emailsrvr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751976AbWLNXfM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 18:35:12 -0500
Message-ID: <4581DFC2.1000304@gentoo.org>
Date: Thu, 14 Dec 2006 18:35:30 -0500
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061111)
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: davej@codemonkey.org.uk, linux list <linux-kernel@vger.kernel.org>
Subject: Re: amd64 agpgart aperture base value
References: <4580C954.103@gentoo.org> <20061214132224.GD17565@redhat.com>
In-Reply-To: <20061214132224.GD17565@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:
> On Wed, Dec 13, 2006 at 10:47:32PM -0500, Daniel Drake wrote:
> 
>  > In amd64-agp.c, would it be dangerous to remove the "aperture base > 4G" 
>  > thing and instead simply only read the rightmost 7 bits to ensure the 
>  > aperture base is always in range? (This is coming from someone with 
>  > little AGPGART understanding...)
> 
> Ignoring the high bits is the wrong thing to be doing.
> The BIOS placed the aperture in one place, and by masking bits, you're going
> to be assuming its somewhere else, and scribbling over who knows what.

So, you think that the aperture moving to a different location on every 
boot is what the BIOS desires? Is it normal for it to move so much?

The current patch drops the upper bits and results in the aperture 
always being in the same place, and this appears to work. If the BIOS 
did really put the aperture beyond 4GB but my patch is making Linux put 
it somewhere else, does it surprise you that things are still working 
smoothly?

Is it even possible for the aperture to start beyond 4GB when the system 
has less than 4GB of RAM?

> If the aperture is placed above 4G, we should deal with it. Currently, we
> don't. (See the AGP patches Linus merged just before 2.6.19 was released
> that work around this for intel-agp).
> 
> Just needs someone to find the time to write the code to do it, and test it.

Looks like some understanding of AGP is required too. I'll have a closer 
look another time.

Thanks,
Daniel

