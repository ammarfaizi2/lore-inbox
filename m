Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266825AbUJGOxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266825AbUJGOxo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 10:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266896AbUJGOww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 10:52:52 -0400
Received: from jade.aracnet.com ([216.99.193.136]:5534 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S266825AbUJGOwM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 10:52:12 -0400
Date: Thu, 07 Oct 2004 07:49:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Simon Derr <Simon.Derr@bull.net>, Paul Jackson <pj@sgi.com>
cc: colpatch@us.ibm.com, pwil3058@bigpond.net.au, frankeh@watson.ibm.com,
       dipankar@in.ibm.com, akpm@osdl.org, ckrm-tech@lists.sourceforge.net,
       efocht@hpce.nec.com, lse-tech@lists.sourceforge.net, hch@infradead.org,
       steiner@sgi.com, jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <1250810000.1097160595@[10.10.2.4]>
In-Reply-To: <Pine.LNX.4.61.0410071439070.19964@openx3.frec.bull.fr>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><247790000.1091762644@[10.10.2.4]> <200408061730.06175.efocht@hpce.nec.com><20040806231013.2b6c44df.pj@sgi.com> <411685D6.5040405@watson.ibm.com><20041001164118.45b75e17.akpm@osdl.org> <20041001230644.39b551af.pj@sgi.com><20041002145521.GA8868@in.ibm.com> <415ED3E3.6050008@watson.ibm.com><415F37F9.6060002@bigpond.net.au> <821020000.1096814205@[10.10.2.4]><20041003083936.7c844ec3.pj@sgi.com> <834330000.1096847619@[10.10.2.4]><835810000.1096848156@[10.10.2.4]> <20041003175309.6b02b5c6.pj@sgi.com><838090000.1096862199@[10.10.2.4]> <20041003212452.1a15a49a.pj@sgi.com><843670000.1096902220@[10.10.2.4]> <Pine.LNX.4.61.0410051111200.19964@openx3.frec.bull.fr><58780000.1097004886@flay>
 <20041005172808.64d3cc2b.pj@sgi.com><1193270000.1097025361@[10.10.2.4]> <20041005190852.7b1fd5b5.pj@sgi.com><1097103580.4907.84.camel@arrakis> <20041007015107.53d191d4.pj@sgi.com> <Pine.LNX.4.61.0410071439070.19964@openx3.frec.bull.fr>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, 7 Oct 2004, Paul Jackson wrote:
> 
>> > I don't see what non-exclusive cpusets buys us.
>> 
>> One can nest them, overlap them, and duplicate them ;)
> 
> I would also add, if the decision comes to make 'real exclusive' cpusets, 
> my previous example, as a use for non-exclusive cpusets: 
> 
> we are running jobs that need to be 'mostly' isolated on some part of the 
> system, and run in a specific location. We use cpusets for that. But we 
> can't afford to dedicate a part of the system for administrative tasks 
> (daemons, init..). These tasks should not be put inside one of the 
> 'exclusive' cpusets, even temporary : they do not belong there. They 
> should just be allowed to steal a few cpu cycles from time to time : non 
> exclusive cpusets are the way to go.

That makes no sense to me whatsoever, I'm afraid. Why if they were allowed
"to steal a few cycles" are they so fervently banned from being in there?
You can keep them out of your userspace management part if you want.

So we have the purely exclusive stuff, which needs kernel support in the form
of sched_domains alterations. The rest of cpusets is just poking and prodding
at cpus_allowed, the membind API, and the irq binding stuff. All of which
you could do from userspace, without any further kernel support, right?
Or am I missing something?

M.


