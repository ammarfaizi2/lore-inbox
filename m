Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319164AbSH2J7M>; Thu, 29 Aug 2002 05:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319167AbSH2J7M>; Thu, 29 Aug 2002 05:59:12 -0400
Received: from k100-159.bas1.dbn.dublin.eircom.net ([159.134.100.159]:7177
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S319164AbSH2J7L>; Thu, 29 Aug 2002 05:59:11 -0400
Message-ID: <3D6DF151.5080203@corvil.com>
Date: Thu, 29 Aug 2002 11:02:57 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Dominik Brodowski <devel@brodo.de>,
       cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.5.32] CPU frequency and voltage scaling (0/4)
References: <Pine.LNX.4.44.0208281649540.27728-100000@home.transmeta.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> On 29 Aug 2002, Alan Cox wrote:
> 
>>So what you are saying is that you want to be sure that something like
>>"please run at a low speed to save battery" is translated by smarter
>>cpus into "please save battery" and on spudstop the CPU would go "umm
>>duh ok 300MHz"
> 
> 
> Yup, exactly.
> 
> I suspect that this is also what most people actually want to use anyway:  
> you don't care that your CPU is a speedstep 1GHz/500Mhz or a 700/300 (or
> whatever the combinations are), you really want to just say "go to power
> save mode" vs "go to performance mode".
> 
> Sure, for speedstep, you can obviously trivially _emulate_ this in user 
> mode with the frequency approach, but for the generic case it isn't.
> 
> I don't know how many policies would be needed (too many just adds 
> complexity for no gain), but I _suspect_ that something like a 
> 
>  { min-Hz, max-Hz, policy }
> 
> triple with "policy" being just a few different values ("performance",
> "powersave") is sufficient. Clearly this triple trivially _becomes_ the
> "single MHz" by just making min and max be the same if you really want one
> particular MHz (at which time "policy" doesn't matter).
> 
> With something like the above, you could do something like
> 
> 	{ 0, ~0UL, "performance" }	=> generic highest performance setting
> 	{ 0, ~0UL, "power-save" }	=> generic power-save setting
> 	{ 300, 500, "performance" }	=> give me a performance setting in the specified range
> 	{ 1700, 1700, "performance" }	=> run at a fixed 1.7GHz

I would go for a quadruple:

  	{ 0, ~0UL, 0, "performance" }	=> generic highest performance setting
  	{ 0, ~0UL, 0, "power-save" }	=> generic power-save setting
  	{ 300, 500, 0, "performance" }	=> give me a performance setting in the  	{ 
1700, 1700, 70"performance" }	=> run at a fixed 1.7GHz
  	{ 0, ~0UL, 70, "performance" }	=> performance but don't go above 70°C

would you also want a hysteris value?

Pádraig.

> (maybe the "policy" thing actually makes a difference even for the
> fixed-frequency case: it can give hints about whether to allow C1-C3
> states when idle etc).
> 
> 		Linus

