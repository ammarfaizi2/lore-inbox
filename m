Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268299AbUJDSZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268299AbUJDSZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 14:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268409AbUJDSZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 14:25:26 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.105]:60144 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268299AbUJDSXk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 14:23:40 -0400
Date: Mon, 04 Oct 2004 11:17:51 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>
cc: pwil3058@bigpond.net.au, frankeh@watson.ibm.com, dipankar@in.ibm.com,
       akpm@osdl.org, ckrm-tech@lists.sourceforge.net, efocht@hpce.nec.com,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [ckrm-tech] Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <118120000.1096913871@flay>
In-Reply-To: <20041004085327.727191bf.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><20040805190500.3c8fb361.pj@sgi.com><247790000.1091762644@[10.10.2.4]><200408061730.06175.efocht@hpce.nec.com><20040806231013.2b6c44df.pj@sgi.com><411685D6.5040405@watson.ibm.com><20041001164118.45b75e17.akpm@osdl.org><20041001230644.39b551af.pj@sgi.com><20041002145521.GA8868@in.ibm.com><415ED3E3.6050008@watson.ibm.com><415F37F9.6060002@bigpond.net.au><821020000.1096814205@[10.10.2.4]><20041003083936.7c844ec3.pj@sgi.com><834330000.1096847619@[10.10.2.4]><835810000.1096848156@[10.10.2.4]><20041003175309.6b02b5c6.pj@sgi.com><838090000.1096862199@[10.10.2.4]><20041003212452.1a15a49a.pj@sgi.com><843670000.1096902220@[10.10.2.4]> <20041004085327.727191bf.pj@sgi.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--On Monday, October 04, 2004 08:53:27 -0700 Paul Jackson <pj@sgi.com> wrote:

> Martin writes:
>> OK, then your "exclusive" cpusets aren't really exclusive at all, since
>> they have other stuff running in them.
> 
> What's clear is that 'exclusive' is not a sufficient precondition for
> whatever it is that CKRM needs to have sufficient control.
> 
> Instead of trying to wrestle 'exclusive' into doing what you want, do me
> a favor, if you would.  Help me figure out what conditions CKRM _does_
> need to operate within a cpuset, and we'll invent a new property that
> satisfies those conditions.

Oh, I'm not even there yet ... just thinking about what cpusets needs
independantly to operate efficiently - I don't think cpus_allowed is efficient.

Whatever we call it, the resource management system definitely needs the 
ability to isolate a set of resources (CPUs, RAM) totally dedicated to
one class or group of processes. That's what I see as the main feature
of cpusets right now, though there may be other things there as well that
I've missed? At least that's the main feature I personally see a need for ;-)
 
> See my earlier posts in the last hour for my efforts to figure out what
> these conditions might be.  I conjecture that it's something along the
> lines of:
> 
>     Assuring each CKRM instance that it has control of some
>     subset of a system that's separate and non-overlapping,
>     with all Memory, CPU, Tasks, and Allowed masks of said
>     Tasks either wholly owned by that CKRM instance, or
>     entirely outside.

Mmm. Looks like you're trying to do multiple CKRMs, one inside each cpuset,
right? Not sure that's the way I'd go, but maybe it makes sense.

The way I'm looking at it, which is probably wholly insufficient, if not
downright wrong, we have multiple process groups, each of which gets some 
set of resources. Those resources may be dedicated to that class (a la 
cpusets) or not. One could view this as a set of resource groupings, and
set of process groupings, where one or more process groupings is bound to
a resource grouping.

The resources are cpus & memory, mainly, in my mind (though I guess IO,
etc fit too). The resource sets are more like cpusets, and the process
groups a bit more like CKRM, except they seem to overlap (to me) when
the sets in cpusets are non-exclusive, or when CKRM wants harder performance
guarantees.

Feel free to point out where I'm full of shit / missing the point ;-)

M.

