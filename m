Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965066AbVHPB33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965066AbVHPB33 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 21:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965067AbVHPB33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 21:29:29 -0400
Received: from smtpout.mac.com ([17.250.248.83]:28642 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965066AbVHPB33 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 21:29:29 -0400
In-Reply-To: <4277B1B44843BA48B0173B5B0A0DED4352817E@ausx3mps301.aus.amer.dell.com>
References: <4277B1B44843BA48B0173B5B0A0DED4352817E@ausx3mps301.aus.amer.dell.com>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DEFA2736-585A-4F84-9262-C3EB53E8E2A0@mac.com>
Cc: linux-kernel@vger.kernel.org, Douglas_Warzecha@Dell.com,
       Matt_Domsch@Dell.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC][PATCH 2.6.13-rc6] add Dell Systems Management Base Driver (dcdbas) with sysfs support
Date: Mon, 15 Aug 2005 21:29:23 -0400
To: Michael_E_Brown@Dell.com
X-Mailer: Apple Mail (2.733)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 15, 2005, at 18:58:56, Michael_E_Brown@Dell.com wrote:
>> Why can't you just implement the system management actions in
>> the kernel driver?  This is tantamount to a binary SMI hook to
>> userspace.  What functionality does this provide on a dell
>> system from an administrator's point of view?
>
> Kyle,
>     I'm sure that not everybody agrees with the whole concept of SMI
> calls. Nevertheless, these calls exist, and in order to have a  
> complete
> systems-management solution, we have to provide a way to do SMI calls.
> Now, we have developed a way to do these SMI calls from userspace
> without kernel support, but we are trying to be community-friendly and
> show our hooks in the open, rather than trying to sneak them in under
> the covers.


>     You might not like the concept of a generic hook for SMI calls
> in the kernel, but the alternatives are hardly better. One alternative
> is the already-mentioned method that we do things under the covers in
> userspace. Another alternative is that we write separate kernel code
> for each and every SMI call that exists in the Dell BIOS.

>     The second alternative is not entirely feasible. We have over 60
> SMI functions, and we would have to write a kernel-mode wrapper for
> each and every one. I hope you agree that code that doesn't exist is
> less buggy than code that is, and that code that is in userspace is a
> whole lot less likely to cause a kernel crash than code that is in
> the kernel.

I think the second alternative is actually feasible and preferable. The
point of the kernel is to provide safe and secure access to two things:
   1) Hardware through an abstraction layer
   2) Software services (like IP stack) that are not feasible to do in
      userspace.

A system that just provides a hunk of DMA RAM and the ability to  
generate
interrupts is definitely not 2, and does not really follow the ideal
behind 1 either.  I gave the firmware example earlier.  There are  
several
devices that provide access to update firmware by reading and writing a
firmware file directly in sysfs, then updating it on reboot if  
necessary.

>  We are trying to keep our kernel bloat down. We don't really think  
> that
> customers of IBM or HP really want their Red Hat kernels loaded  
> down with
> a bunch of Dell-only code.

That's what kconfig is for.  My G4 Powerbook doesn't have support for
hardware found in my G4 desktop any more than an IBM box should be  
forced
to have support for Dell hardware, yet all platforms work fine from the
same kernel tree.

>     Additionally, we are releasing an open source library (GPL/OSL
> dual  license) that can use these hooks to perform many systems
> management functions in userspace. See
> http://linux.dell.com/libsmbios/main/. We should have code in  
> libsmbios to
> do SMI using this driver within about two weeks.  We currently  
> writing the
> SMI hooks in libsmbios using this posted version of the driver. I  
> am the
> maintainer of this project, and it is my goal to have code in  
> libsmbios
> for every Dell SMI call.

That's a nice project.  I applaud Dell for it's openness, but that's  
not the
only issue here, the kernel needs good engineering too.

I would suggest that you try to implement as much as is possible in a  
kernel
driver.  Firmware loading support, for example, or hardware sensors,  
should
integrate well into sysfs and be accessible through existing tools if
possible.  Doug also mentions fan status and control in his mail.   
Could you
provide such access through existing fan status/control interfaces so  
that
existing tools work as well?

>     We would welcome feedback on a better way to implement this
> driver in the kernel, but the fact remains that we have to have a  
> way to do
> this, and we are open-sourcing all of the code necessary to get  
> this done.

Thank you for your effort.  You guys have made significant progress,  
but IMHO,
you've still got a ways to go.  Keep up the good work, though!

Cheers,
Kyle Moffett

--
Unix was not designed to stop people from doing stupid things,  
because that
would also stop them from doing clever things.
   -- Doug Gwyn


