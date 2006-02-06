Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWBFUGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWBFUGm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 15:06:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWBFUGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 15:06:42 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:39348 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932360AbWBFUGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 15:06:40 -0500
Date: Mon, 6 Feb 2006 21:05:06 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Paul Jackson <pj@sgi.com>
Cc: ak@suse.de, clameter@engr.sgi.com, akpm@osdl.org, dgc@sgi.com,
       steiner@sgi.com, Simon.Derr@bull.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-ID: <20060206200506.GA13466@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com> <200602061811.49113.ak@suse.de> <Pine.LNX.4.62.0602061017510.16829@schroedinger.engr.sgi.com> <200602061936.27322.ak@suse.de> <20060206184330.GA22275@elte.hu> <20060206120109.0738d6a2.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060206120109.0738d6a2.pj@sgi.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -2.2
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-2.2 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	0.6 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Paul Jackson <pj@sgi.com> wrote:

> Ingo wrote:
> > we should default to local.
> 
> Agreed.  There is much software and systems management expectations 
> sitting on top of this, that have certain expectations of the default 
> memory placement behaviour, to a rough degree, of the system.
> 
> They are expecting node-local placement.
> 
> We would only change that default if it was shown to be substantially 
> wrong headed in a substantial number of cases.  It has not been so 
> shown.  It is either an adequate or quite desirable default for most 
> cases.
> 
> Rather we need to consider optional behaviour, for use on workloads 
> for which other policies are worth developing and invoking.

yes. And it seems that for the workloads you cited, the most natural 
direction to drive the 'spreading' of resources is from the VFS side.  
That would also avoid the problem Andrew observed: the ugliness of a 
sysadmin configuring the placement strategy of kernel-internal slab 
caches. It also feels a much more robust choice from the conceptual POV.

	Ingo
