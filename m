Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751060AbWCYG1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbWCYG1i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 01:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751086AbWCYG1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 01:27:38 -0500
Received: from smtpout.mac.com ([17.250.248.46]:13524 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751060AbWCYG1h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 01:27:37 -0500
In-Reply-To: <200603242219.54677.rob@landley.net>
References: <200603141619.36609.mmazur@kernel.pl> <878xqzpl8g.fsf@hades.wkstn.nix> <D903C0E1-4F7B-4059-A25D-DD5AB5362981@mac.com> <200603242219.54677.rob@landley.net>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8A5F3A58-F954-4BEC-A085-2FF3D380B2F6@mac.com>
Cc: Nix <nix@esperi.org.uk>, Mariusz Mazur <mmazur@kernel.pl>,
       LKML Kernel <linux-kernel@vger.kernel.org>,
       llh-discuss@lists.pld-linux.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: State of userland headers
Date: Sat, 25 Mar 2006 01:27:15 -0500
To: Rob Landley <rob@thyrsus.com>
X-Mailer: Apple Mail (2.746.3)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 24, 2006, at 22:19:54, Rob Landley wrote:
> On Friday 24 March 2006 5:46 pm, Kyle Moffett wrote:
>> however.  Since the kabi/*.h headers would not be kernel-version- 
>> specific, they could be copied to a system running an older kernel  
>> and reused there without problems.
>
> Since when is the kernel ABI not kernel version specific?  You can  
> use an older ABI on a newer kernel, but you can't use a newer ABI  
> on an older kernel.

By the very definition of "ABI", it _must_ not be kernel version  
specific.  A program written for a newer ABI and compiled against it  
_must_ be able to gracefully handle syscalls not existing when run on  
an older kernel.  The program may fail to work entirely because the  
syscalls it needs are not present, but that's no different than a  
"Kernel does not have feature CONFIG_FOO enabled" issue.

>> Even though some of the syscalls and ioctls referenced in the kabi  
>> headers might not be present on the running kernel, portable  
>> programs are expected to be able to sanely handle older kernels.
>
> At the source level, maybe.  At the binary level?  Not really.

The ABI must be compatible at both source and binary interfaces,  
"Application _Binary_ Interface" is the name, after all.  It's OK to  
introduce new features so long as you can gracefully handle them not  
being present.  Look for example at what happens if I take V4L apps  
and run them on a 2.4.0 kernel without V4L.  They report that the  
kernel is too old or missing features, but aside from V4L not being  
present, everything just works.

As a result, I think that if we can clean up the headers in kernel,  
we can reuse those same headers for compiling userspace everywhere,  
even if the userspace is going to be run on an older kernel.

Cheers,
Kyle Moffett

