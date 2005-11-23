Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932079AbVKWQwg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932079AbVKWQwg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:52:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbVKWQwg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:52:36 -0500
Received: from terminus.zytor.com ([192.83.249.54]:6032 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932079AbVKWQwf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:52:35 -0500
Message-ID: <43849E1C.3030102@zytor.com>
Date: Wed, 23 Nov 2005 08:51:40 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gerd Knorr <kraxel@suse.de>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andi Kleen <ak@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
References: <200511100032.jAA0WgUq027712@zach-dev.vmware.com>	 <20051111103605.GC27805@elf.ucw.cz> <4374F2D5.7010106@vmware.com>	 <Pine.LNX.4.64.0511111147390.4627@g5.osdl.org>	 <4374FB89.6000304@vmware.com>	 <Pine.LNX.4.64.0511111218110.4627@g5.osdl.org>	 <20051113074241.GA29796@redhat.com>	 <Pine.LNX.4.64.0511131118020.3263@g5.osdl.org>	 <Pine.LNX.4.64.0511131210570.3263@g5.osdl.org> <4378A7F3.9070704@suse.de>	 <Pine.LNX.4.64.0511141118000.3263@g5.osdl.org> <4379ECC1.20005@suse.de>	 <437A0649.7010702@suse.de> <437B5A83.8090808@suse.de>	 <438359D7.7090308@suse.de>  <p7364qjjhqx.fsf@verdi.suse.de> <1132764133.7268.51.camel@localhost.localdomain> <43849C23.3040001@suse.de>
In-Reply-To: <43849C23.3040001@suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerd Knorr wrote:
> 
> Patching in/out SMP-locking with more than one active CPU would be a 
> pretty silly idea in the first place ;)
> 

No, doing this crap with CPU hotplug is a silly idea.  Patching on a 
real UP system, and then throwing out the tables, makes sense.  Keeping 
two sets of tables for a minimal performance improvement in a very rare 
configuration (CPU hotplug is the exception, not the rule) is just plain 
stupid.  You probably lose as much performance from the memory hogged up 
in the tables as you gain from it, and on every system where you have 
the tables at all you take the hit.

	-hpa
