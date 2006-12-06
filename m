Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937749AbWLFWdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937749AbWLFWdM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:33:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937750AbWLFWdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:33:12 -0500
Received: from mx1.redhat.com ([66.187.233.31]:47210 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937749AbWLFWdK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:33:10 -0500
Message-ID: <457743E5.4010109@redhat.com>
Date: Wed, 06 Dec 2006 17:27:49 -0500
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org,
       linux1394-devel <linux1394-devel@lists.sourceforge.net>
Subject: Re: [PATCH 0/3] New firewire stack
References: <20061205052229.7213.38194.stgit@dinky.boston.redhat.com> <20061205184921.GA5029@martell.zuzino.mipt.ru> <4575FF08.2030100@redhat.com> <45768116.8040804@s5r6.in-berlin.de>
In-Reply-To: <45768116.8040804@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
...
>> Another point is the various streaming drivers.  There used to be 5 different
>> userspace streaming APIs in the linux1394: raw1394, video1394, amdtp, dv1394
>> and rawiso.  Recently, amdtp (audio streaming) has been removed, since with
>> the rawiso interface, this can be done in userspace.  However the remaining 4
>> interfaces have slightly disjoint feature sets and can't really be phased out.
> 
> The old iso API of (lib)raw1394 has been marked deprecated and
> undocumented in libraw1394's documentation for some time, and will go
> away in 2007.
> 
> Dv1394 might go away in 2007 too if there is enough effort to move
> high-profile users over to rawiso a.k.a. the current iso API of
> (lib)raw1394.
> 
> I suppose video1394 might get a viable migration path with your new
> driver, if you and interested developers put effort into development
> (and help with deployment) of a proper replacement.

As discussed on linux1394-devel, it may be possible to do a thin video1394 
compatibility driver for this one, but since the biggest user of this 
interface is libdc1394, it is probably better to just write a new iso 
streaming backend for this library. libdc1394 already supports different 
streaming backends.  For non-libdc1394 users of video1394, the interface I'm 
providing is very close to the video1394 ioctl interface, so porting should be 
easy enough.

>>  In the long run, supporting 4 different interfaces that does almost the same
>> thing isn't feasible.  The streaming interface in my new stack (only
>> transmission implemented at this point) can replace all of these interfaces.
> 
> You have to look at the matter not only from the POV of API design but
> also of deployment and support.

My POV here *is* about deployment and support, but from the kernel side of 
things.  If you commit yourself to long time support for the firewire stack, 
would you prefer 4 slightly different streaming drivers with different user 
space interfaces, or just one userspace driver with one userspace interface, 
that enables the 4 different types of streaming to be done in userspace?  The 
design of the streaming interfaces have been focused on enabling all these 
ad-hoc, in-kernel drivers to move to userspace, to make it feasible to 
actually support the stack.

Kristian
