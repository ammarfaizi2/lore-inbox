Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289685AbSBKORf>; Mon, 11 Feb 2002 09:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289697AbSBKORZ>; Mon, 11 Feb 2002 09:17:25 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11527 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S289685AbSBKORP>; Mon, 11 Feb 2002 09:17:15 -0500
Date: Mon, 11 Feb 2002 14:17:05 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ingo Molnar <mingo@elte.hu>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: RFC: scheduler, and per-arch switch_to
Message-ID: <20020211141705.C21300@flint.arm.linux.org.uk>
In-Reply-To: <3C67C740.43AAD437@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C67C740.43AAD437@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Mon, Feb 11, 2002 at 08:29:36AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 11, 2002 at 08:29:36AM -0500, Jeff Garzik wrote:
> Do we really care about the third arg to the switch_to() macro?
> 
> IMHO it would be nice to define the architecture context switch
> interface like
> 
>   void switch_to(struct thread_info *from, struct thread_info *to);
> 
> because we don't really seem to do much with the third arg, AFAICS.

It used to be a method to get the previously running task struct so some
cleanup could be done after the actual switch.  Before you think about
"oh, that's prev anyway" think about what happens when "prev" is in some
random compiler defined CPU register, and your switch_to function saves
and restores all CPU registers.

In our current implementation, it looks like the third arg is no longer
necessary - Ingo?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

