Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbUDOBpf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 21:45:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262800AbUDOBpf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 21:45:35 -0400
Received: from gizmo11ps.bigpond.com ([144.140.71.21]:56463 "HELO
	gizmo11ps.bigpond.com") by vger.kernel.org with SMTP
	id S262453AbUDOBpc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 21:45:32 -0400
From: Ross Dickson <ross@datscreative.com.au>
Reply-To: ross@datscreative.com.au
Organization: Dat's Creative Pty Ltd
To: Len Brown <len.brown@intel.com>,
       Christian =?iso-8859-1?q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>,
       linux-nforce-bugs@nvidia.com
Subject: Re: IO-APIC on nforce2 [PATCH]
Date: Thu, 15 Apr 2004 11:48:53 +1000
User-Agent: KMail/1.5.1
Cc: linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
References: <200404131117.31306.ross@datscreative.com.au> <200404142157.34502.christian.kroener@tu-harburg.de> <1081988224.15062.75.camel@dhcppc4>
In-Reply-To: <1081988224.15062.75.camel@dhcppc4>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200404151148.53187.ross@datscreative.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 15 April 2004 10:17, Len Brown wrote:
> On Wed, 2004-04-14 at 15:57, Christian Kröner wrote:
> 
> > This is simply great, any uncommon hi-load disappeared.
> > Will something like this get into mainline soon, maybe with automatic chipset 
> > detection?
> 
> I'm okay putting the bootparam and the workaround into the kernel,
> for it is generic and we may find other platforms need it.

Great, it sure is simpler and cleaner than my workaround. Thanks.

> 
> But I don't have a clean way to make it automatic.
> This is a BIOS bug, so chipset ID will not always work.

True it is a bios thing but I have yet to see an nforce2 MOBO that is not 
routed in this way. I am thinking it is internal to the chipset. I have seen
none route it into io-apic pin2.

> Maciej wrote
>  Well, the question is whether the timer->INTIN0 routing is hardwired
> inside the nforce2 chipset or is it external and thus board-dependent.  
> Any way to get this clarified by the chipset's manufacturer?

Nvidia is the first Company in my 20+ years of working life to totally not 
respond to my attempts to communicate and I have had dealings with
numerous semiconductor firms and agents. I doubt that my email source 
would be blocked and I have also tried their form mail. Do real people
work there? Maybe I have to phone or fax them from here in Australia?
-or place an order for 10,000 chips? Maybe we need a worldwide union of
Linux support staff to exhibit collective sales pressure. Enough ranting....

I am also cautioned by Maciej's comments indicating that maybe the 
override appears in the nforce2 bios because there is no other way of 
saying this is a feature that nvidia could not get to work properly?...

On the flip side in favour of this routing the clock skew may be restricted
to only to 2.6.1 kerns, I do not have it on my patched 2.4 kerns, it may
be fine on 2.6.5.

Here is a link to the old thread with the skew issues.
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-01/3129.html
Christian - would you please check if you get clock skew as described in
that thread?

> 
> We could list the BIOS in dmi_scan(), but I hate doing
> that b/c then the vendor releases a new version of their
> broken BIOS and the automatic workaround no longer works...
> 
> -Len
> 

Unfortunately the hard lockups in the BUG report won't be fixed by this io-apic
work. I think Shuttle is the only manufacturer to ship a bios update which has
taken a board with existing lockup problems and fixed it. So far nobody has
posted how this magic was done?
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-01/5003.html

In the mean time I and others with lockups have had success with my C1 idle 
patch but I have left it manual with kern arg for the same reason - no clean
way to automate it. Some nforce2 need it, others don't. Want me to finish 
cleaning it up for possible inclusion?
http://linux.derkeiler.com/Mailing-Lists/Kernel/2004-04/1707.html

-Ross.




