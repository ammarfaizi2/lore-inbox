Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932559AbWG0KH3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932559AbWG0KH3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 06:07:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932560AbWG0KH3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 06:07:29 -0400
Received: from calypso.frankengul.org ([213.41.240.201]:5047 "EHLO
	calypso.frankengul.org") by vger.kernel.org with ESMTP
	id S932559AbWG0KH3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 06:07:29 -0400
Date: Thu, 27 Jul 2006 12:07:27 +0200
To: Adam Henley <adamazing@gmail.com>
Cc: debian-sparc@lists.debian.org, linux-kernel@vger.kernel.org
Subject: Re: Weird kernel 2.6.17.[67] behaviour
Message-ID: <20060727100727.GA8408@frankengul.org>
References: <20060726135526.GA11310@frankengul.org> <44C7F794.3080304@frankengul.org> <c526a04b0607261641n7f09242h86025282153e4c91@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c526a04b0607261641n7f09242h86025282153e4c91@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060403
From: seb@frankengul.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2006 at 12:41:56AM +0100, Adam Henley wrote:
> On 27/07/06, Sébastien Bernard <seb@frankengul.org> wrote:
> >seb@frankengul.org a écrit :
> >> I got a perfectly workable kernel 2.6.17.1 using mkinitramfs on my U60.
> >>
> >> Can you shed some lights on this dark corner of linux ?
> >>
> >>       Seb
> 
> I can't shed any more light on it, but I can look too :o)

:). It was just a poetic licence.

> 
> The original mailing of the patch to the list is below:
> http://www.uwsg.iu.edu/hypermail/linux/kernel/0607.1/1694.html
> 
> [snip>
> The prctl() system call should never allow to set "dumpable" to the
> value 2. Especially not for non-privileged users.
> 
> This can be split into three cases:
>  1) running as root -- then core dumps will already be done as root,
>     and so prctl(PR_SET_DUMPABLE, 2) is not useful
>  2) running as non-root w/setuid-to-root -- this is the debatable case
>  3) running as non-root w/setuid-to-non-root -- then you definitely
>     do NOT want "dumpable" to get set to 2 because you have the
>     privilege escalation vulnerability
> <snip]
> 
> Is it that something else is misbehaving and trying to dump core as root?
> 

Well, I'm not arguing that the fix is a wrong fix.

I'm seeing that, on sparc64-smp arch with debian etch, this patch causes
a very strange sideeffect I was describing in my first mail.

The boot hangs, the cursor (in the framebuffer) stops blinking, nothing
is displayed, and the machine seems frozen until I hit a key or a button
mouse (which is on sparc causing the same interruption), and then the
machine resume the boot sequence as if nothing really happened.

I've been able to isolate that line to be the origin of this behaviour
but it could be as well a bug revealed by this modification.

	Seb
