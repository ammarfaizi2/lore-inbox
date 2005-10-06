Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751227AbVJFFFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751227AbVJFFFY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 01:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751228AbVJFFFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 01:05:24 -0400
Received: from relay03.pair.com ([209.68.5.17]:45832 "HELO relay03.pair.com")
	by vger.kernel.org with SMTP id S1751227AbVJFFFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 01:05:23 -0400
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Subject: Re: what's next for the linux kernel?
Date: Thu, 6 Oct 2005 00:04:46 -0500
User-Agent: KMail/1.8.1
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
References: <20051002204703.GG6290@lkcl.net> <200510041840.55820.chase.venters@clientec.com> <20051005102650.GO10538@lkcl.net>
In-Reply-To: <20051005102650.GO10538@lkcl.net>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510060005.09121.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 05 October 2005 05:26 am, Luke Kenneth Casson Leighton wrote:
> > Now I certainly wouldn't advocate a Windows-style registry,
> > because I think it's full of obvious problems.
>
>  such as? :)

If such a thing were even going to be attempted on UNIX, it would have to be 
so different than the NT approach that it would stop looking like a registry 
altogether.

For one thing, you need the ability to chroot / have multiple namespaces. It's 
totally possible that I as a user decide to install 78 different versions of 
Apache for some wild reason, and I expect my configuration settings to stay 
separate, damnit! 

Also, it would need to be rock-solid. Losing blocks on the disk should not 
mean losing the ability to boot the OS. Powering off in the middle of a write 
should not be fatal. 

What about applications attached to removable media? Should these applications 
assume that it is correct to store state in my registry? What happens when I 
then try to carry the media to another computer? If I wanted my settings to 
migrate, the application would need to be smart enough not to use the 
registry implementation, which makes it that much more worthless.

Why implement such cruft in the kernel? A user-space implementation is 
perfectly reasonable. An example that comes to mind is gconf, which uses XML 
files in a hierarchy to achieve something that looks sort of like a registry. 
Indeed, the requirements I briefly touch on above (which are just examples of 
the number of considerations I'm sure there really are) all point to an 
implementation we already have - a filesystem. Why reinvent the wheel?

Moreover, I think the idea of a system-wide registry is a bad idea altogether. 
In environments like GNOME or KDE it's generally OK because your applications 
are designed for the environment. Not so in the general Linux environment - 
we have tons and tons of applications we're capable of running that don't 
have the first clue about registries or why they would want it. So we're 
stuck either implementing it in all these applications (effectively forking 
them from the versions that used to work on every other UNIX), or they don't 
use the registry, in which case we've just added cruft that we don't even use 
(at the expense of confusing our end-users, well, to no end), or we choose to 
abandon these applications (not going to happen, ever).

KISS comes into play here, I think. A system registry is an interesting 
attempt to solve the universal configuration problem, but I think it does not 
adapt to the UNIX "way of thinking" well at all.

Regards,
Chase Venters
