Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVCKUaC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVCKUaC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 15:30:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVCKU1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 15:27:42 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:26256 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261563AbVCKUSL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 15:18:11 -0500
Message-ID: <4231FE29.7090109@tmr.com>
Date: Fri, 11 Mar 2005 15:23:05 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rob Landley <rob@landley.net>
CC: user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>,
       akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [uml-devel] [PATCH 3/9] UML - "Hardware" random number generator
References: <200503100215.j2A2FuDN015227@ccure.user-mode-linux.org><200503100215.j2A2FuDN015227@ccure.user-mode-linux.org> <200503101341.37346.rob@landley.net>
In-Reply-To: <200503101341.37346.rob@landley.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley wrote:
> On Wednesday 09 March 2005 09:15 pm, Jeff Dike wrote:
> 
>>This implements a hardware random number generator for UML which attaches
>>itself to the host's /dev/random.
> 
> 
> Direct use of /dev/random always makes me nervous.  I've had a recurring 
> problem with /dev/random blocking, and generally configure as much as 
> possible to use /dev/urandom instead.  It's really easy for a normal user to 
> drain the /dev/random entropy pool on a server (at least one that doesn't 
> have a sound card you can tell it to read white noise from).  cat /dev/random 
> 
>>/dev/null
> 
> 
> I like /dev/urandom because it'll feed you as much entropy as it's got, but 
> won't block, and will presumably round-robin insert real entropy in the 
> streams that multiple users get from /dev/urandom.  (I realize this may not 
> be the best place to get gpg keys from.)
> 
> I'm just thinking about those UML hosting farms, with several UML instances 
> per machine, on machines which haven't got a keyboard attached constantly 
> feeding entropy into the pool.  If just ONE of them is serving ssl 
> connections from its own /dev/urandom, that would drain the /dev/random 
> entropy pool on the host machine almost immediately...
> 
> Admittedly if UML used /dev/urandom instead of /dev/random, it wouldn't know 
> how much "real" randomness it was getting and how much synthetic randomness, 
> but this makes predicting the numbers it's producing easier how?

Use of a "hardware" RNG patch without a real hardware RNG could do all 
that. I would add a caution to the help warning of this problem if you 
lack real hardware RNG capability. The really paranoid could insist that 
at least one hardware driver be configured, but how much do you need to 
protect people from themselves?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
