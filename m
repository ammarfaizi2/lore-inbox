Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750702AbVIUAbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750702AbVIUAbN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 20:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVIUAbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 20:31:13 -0400
Received: from smtpout.mac.com ([17.250.248.73]:1730 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750702AbVIUAbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 20:31:13 -0400
In-Reply-To: <2CB9FE03B6DBB54AAD7193A44499D6242C9B96@satluj1.lums.edu.pk>
References: <2CB9FE03B6DBB54AAD7193A44499D6242C9B96@satluj1.lums.edu.pk>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <497A33BB-A83C-437A-ADD7-1E747EA860BA@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>, Dave Airlie <airlied@linux.ie>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: In-kernel graphics subsystem
Date: Tue, 20 Sep 2005 20:30:31 -0400
To: Athar Hameed <06020051@lums.edu.pk>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 20, 2005, at 20:05:15, Athar Hameed wrote:
> We have this idea of integrating a graphics subsystem with the  
> kernel and doing away with the X server.

Don't, please!  Graphics cards are way too complex to consider  
putting a whole OpenGL or windowing layer into the kernel.

> We are not really sure if this is a wise thing to do.

It's not.

> It hasn't been done before.

It has.  See http://fbui.org/  Please note that most kernel  
developers do not think it's a good idea.  We have several interfaces  
(framebuffer, DRM, etc) provided to userspace to make it really easy  
to do such things there.

If you want to do something useful for graphics in the Linux kernel,  
you might ask Dave Arlie what he needs help with (I've CCed him).  I  
think that the current list (not in any kind of order), includes a  
generic platform-independent VGA arbiter and a safe kernel/userspace  
API for submitting commands to graphics cards so that the X server  
doesn't need to mmap /dev/mem and manually bang on the PCI busses.   
Also, a reliable system to freeze GPU activity, reset the GPU, and  
display a panic message would be helpful.  Dave can probably give you  
more information about this stuff.

You might also think about a console program that uses the  
framebuffer and input subsystem, so that it is possible to put  
multiple graphics cards in a single box and have multiple independent  
consoles (One on each GPU).

If you feel like doing something X.org related, you could go ask on  
the x.org mailing lists, I'm sure they'd welcome the extra help.

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so simple that there are obviously no deficiencies. And the  
other way is to make it so complicated that there are no obvious  
deficiencies.  The first method is far more difficult.
   -- C.A.R. Hoare


