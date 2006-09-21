Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWIVDmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWIVDmT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 23:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932257AbWIVDmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 23:42:19 -0400
Received: from victor.provo.novell.com ([137.65.250.26]:63972 "EHLO
	victor.provo.novell.com") by vger.kernel.org with ESMTP
	id S932256AbWIVDmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 23:42:18 -0400
Message-ID: <45130531.2040508@novell.com>
Date: Thu, 21 Sep 2006 14:33:37 -0700
From: Crispin Cowan <crispin@novell.com>
User-Agent: Thunderbird 1.5 (X11/20060317)
MIME-Version: 1.0
To: Stephen Smalley <sds@tycho.nsa.gov>
CC: David Madore <david.madore@ens.fr>,
       Linux Kernel mailing-list <linux-kernel@vger.kernel.org>,
       LSM mailing-list <linux-security-module@vger.kernel.org>
Subject: Re: capabilities patch: trying a more "consensual" approach
References: <20060911212826.GA9606@clipper.ens.fr>	 <20060915225213.GA15173@clipper.ens.fr> <1158584371.18951.227.camel@moss-spartans.epoch.ncsc.mil>
In-Reply-To: <1158584371.18951.227.camel@moss-spartans.epoch.ncsc.mil>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Smalley wrote:
> On Sat, 2006-09-16 at 00:52 +0200, David Madore wrote:
>   
>> Now, if I understand correctly, the various alloc_security() LSM hooks
>> do not stack well: if I want my module to be stackable after SElinux
>> (and I do), I can't hook task_alloc_security() to create my variable,
>> so I need to store these "cuppabilities" in a globally visible task
>> field.  Do I understand correctly?  How acceptable is this?  (We can
>> assume that 32 bits will be wide enough, so I'm not talking about
>> adding huge amounts of data to the task struct.)
>>     
> No, I think that is a losing strategy, and it defeats the purpose of
> having LSM in the first place.  For now, I'd suggest just _not_
> supporting stacking with SELinux until such a time as you've
> successfully gotten your module merged, then later you can take up the
> best way to support such stacking (whether via direct modification of
> SELinux to enable chaining off of its security structures, or via the
> "stacker" module previously implemented by Serge that lacks a real
> motivating user, although that is contentious).
>   
I mostly agree with Stephen. I agree with both the approach of modifying
SELinux so that its task security blobs chain to yours, and I agree with
the suggestion of letting Stacker do it. I also suggest you consider the
inverse stack of making your module stack with SELinux instead of vice
versa (chain in the opposite order) and I suggest you consider making
your module stack with AppArmor.

The only part I question is why you would need to wait for your module
to start development on any of these approaches. Especially the Stacker
approach.

On that point, now that LSM is staying, and there are a multitude of
modules proposed for mainstream, perhaps it is time to reconsider
merging Stacker. There was a *lot* of effort invested there benchmarking
various schemes. With multiple modules coming in, and stacking a
recurring problem, perhaps we need it now.

Crispin

-- 
Crispin Cowan, Ph.D.                      http://crispincowan.com/~crispin/
Director of Software Engineering, Novell  http://novell.com
     Hack: adroit engineering solution to an unanticipated problem
     Hacker: one who is adroit at pounding round pegs into square holes


