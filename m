Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWGKWEl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWGKWEl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 18:04:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbWGKWEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 18:04:40 -0400
Received: from terminus.zytor.com ([192.83.249.54]:23985 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932178AbWGKWE1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 18:04:27 -0400
Message-ID: <44B41FB1.7050704@zytor.com>
Date: Tue, 11 Jul 2006 15:01:21 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, Sam Ravnborg <sam@ravnborg.org>,
       hch@infradead.org, dwmw2@infradead.org, bunk@stusta.de,
       linux-kernel@vger.kernel.org, torvalds@osdl.org, akpm@osdl.org
Subject: Re: RFC: cleaning up the in-kernel headers
References: <20060711160639.GY13938@stusta.de> <1152635323.3373.211.camel@pmac.infradead.org> <20060711173301.GA27818@infradead.org> <20060711193423.GA9685@mars.ravnborg.org> <20060711194107.GA10733@mars.ravnborg.org> <20060711134106.18f6dd2e.rdunlap@xenotime.net> <20060711213733.GB21448@wohnheim.fh-wedel.de>
In-Reply-To: <20060711213733.GB21448@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Tue, 11 July 2006 13:41:06 -0700, Randy.Dunlap wrote:
>> On Tue, 11 Jul 2006 21:41:07 +0200 Sam Ravnborg wrote:
>>
>>>> JÃrn Engel IIRC created a perl scrip that did this a year or two ago.
>>>> Try googling a bit.
>>> http://lkml.org/lkml/2003/10/1/74
>> That is version 2 of the script.  There are also versions 3 & 4.
>>
>> http://marc.theaimsgroup.com/?l=linux-kernel&w=2&r=1&s=check+headers+for+complete+includes&q=t
> 
> Boy, it took me a while to remember what I did back then.  In
> principle, the script just compiles trivial c files with a single
> #include <linux/foo.h>
> inside.
> 
> Not too bad in principle, but there were two problems I couldn't
> solve:
> 1. One of the goals should be to make a compile faster, not slower.
> Adding further includes hardly helps.
> 2. It is practically impossible to test every possible combination of
> #ifdefs in the various headers pulled in.
> 

#1 I doubt the time taken to look at include files that are #ifndef'd in 
their entirety is significant (I think there is special code in gcc to 
handle this case fast.)

#2 is actually a non-issue.  If each file is usable standalone (and have 
a multiple inclusion guard), then the include order shouldn't matter. 
Not that one can't create contrived cases where it would matter, but one 
can't solve every problem...

	-hpa
