Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422634AbVKZCeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422634AbVKZCeu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Nov 2005 21:34:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422635AbVKZCet
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Nov 2005 21:34:49 -0500
Received: from eastrmmtao02.cox.net ([68.230.240.37]:23205 "EHLO
	eastrmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1422634AbVKZCet (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Nov 2005 21:34:49 -0500
In-Reply-To: <200511251620.12996.rob@landley.net>
References: <200511170629.42389.rob@landley.net> <200511251545.32343.rob@landley.net> <20051125220934.GA2268@elf.ucw.cz> <200511251620.12996.rob@landley.net>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4F23F6A0-EC33-43E0-B0D2-BCBFF25E5777@mac.com>
Cc: Pavel Machek <pavel@ucw.cz>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Fri, 25 Nov 2005 21:34:46 -0500
To: Rob Landley <rob@landley.net>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 25, 2005, at 17:20:12, Rob Landley wrote:

> On Friday 25 November 2005 16:09, Pavel Machek wrote:
>
>> Ouch, I guess I killed my .config :-(. It seems that interrupted
>> miniconfig.sh leaves .config in close to empty state...
>>
>
> That's why it insists you rename it in order to run it.
>
> I intend to fix that somewhat in a newer version of the sucker by  
> having the script intercept signals and restore .config on the way  
> out, but it can't be fully reliable (not against kill -9) because  
> kconfig overwrites .config and the script is repeatedly running  
> allnoconfig.  (I can probably bypass the makefile and feed it some  
> strange command line argument, but what Kconfig to run it on gets  
> us into architecture dependence issues the make file handles for  
> us...)
>

I got interested so I started writing a Perl-based replacement that  
actually reads the source config into program memory and writes  
copies out of that RAM each time.  I ran into a problem (although I  
can't reproduce it anymore) where the resultant configs had identical  
options but slightly altered whitespace or ordering, which naturally  
broke the diff method that miniconfig.sh used.


>> I'm not sure what I did wrong last time, it worked this time. My
>> miniconfig is 6K instead of 46K, good. Still its quite long. Thanks!
>>
>
> You mentioned you set a lot of options. :)
>
> I agree scripts/miniconfig.sh is clumsy.  I'm thinking about  
> improvements (both to how it works and to the user interface), but  
> I need to catch up on some other stuff first...
>

I have a bit of time to tinker.  I'll send you my perl version once I  
get it working and test it out a bit.  It shouldn't be too hard to  
add the ability to use .config and rewrite that when exiting.

One other minor nit:  If you pass a config file from a previous  
version to miniconfig.sh, it will return the full config file because  
nothing makes it match the original.  Theoretically it should  
probably allnoconfig with the full config first and use that for the  
rest, before removing lines.

Cheers,
Kyle Moffett


