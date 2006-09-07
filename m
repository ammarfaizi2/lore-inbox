Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWIGSeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWIGSeR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Sep 2006 14:34:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751830AbWIGSeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Sep 2006 14:34:17 -0400
Received: from smtpout.mac.com ([17.250.248.178]:21741 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751832AbWIGSeP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Sep 2006 14:34:15 -0400
In-Reply-To: <m3r6yn4jxg.fsf@code.and.org>
References: <20060905212643.GA13613@clipper.ens.fr> <m3r6yn4jxg.fsf@code.and.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <ED485CED-AE69-466E-876C-2CC9DADC5576@mac.com>
Cc: David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: patch to make Linux capabilities into something useful (v 0.3.1)
Date: Thu, 7 Sep 2006 14:33:56 -0400
To: James Antill <james@and.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 07, 2006, at 14:21:15, James Antill wrote:
> David Madore <david.madore@ens.fr> writes:
>
>> Hi.
>>
>> As we all know, capabilities under Linux are currently crippled to  
>> the point of being useless.  Attached is a patch (against 2.6.18- 
>> rc6) which attempts to make them work in a reasonably useful way  
>> and at the same time not break anything.  On top of the  
>> "additional" capabilities that lead up to root, it also adds  
>> "regular" capabilities which all processes have by default and  
>> which can be removed from specifically untrusted programs.
>
> Just a minor comment, can you break out the OPEN into at least  
> OPEN_R, OPEN_NONFILE_W and OPEN_W (possibly OPEN_A, but I don't  
> want that personally). The case I'm thinking about are network  
> daemons that need to open+write to the syslog socket but only have  
> read access elsewhere.
>
> Also there is much more than just bind9 using capabilities, the  
> obvious ones that come to mind are NOATIME and AUDIT.

To be honest, once you get to the point of having an OPEN_NONFILE_W  
capability you should really just be using SELinux.  Instead of  
spewing policy all over your filesystem xattrs you put it all into a  
single set of fairly admin-readable policy files, and it includes  
more fine-grained operations than you have space for in 32 bits of  
"un"-capabilities.  It also conveniently supports the existing pseudo- 
POSIX capabilities.  You can effectively say "root, netadmin, and  
netuser users are allowed to run ping programs which automatically  
transition into the ping domain and get CAP_NET_RAW privileges" in  
your binary policy, then just leave ping as chmod "755" and be done  
with it.

Cheers,
Kyle Moffett

