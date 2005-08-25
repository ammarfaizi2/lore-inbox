Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbVHYWJH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbVHYWJH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 18:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVHYWJG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 18:09:06 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:43000 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S964922AbVHYWJF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 18:09:05 -0400
Message-ID: <430E4177.10600@mvista.com>
Date: Thu, 25 Aug 2005 15:08:55 -0700
From: Todd Poynor <tpoynor@mvista.com>
User-Agent: Mozilla Thunderbird 1.0+ (X11/20050531)
MIME-Version: 1.0
To: Jordan Crouse <jordan.crouse@amd.com>
CC: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: PowerOP Take 2 0/3 Intro
References: <20050825025158.GA28662@slurryseal.ddns.mvista.com> <20050825210940.GX31472@cosmic.amd.com>
In-Reply-To: <20050825210940.GX31472@cosmic.amd.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jordan Crouse wrote:
> Todd - do you have a ChangeLog from Take 1? :)

Right, here's what's changed in this version...

The generic structure of an operating point as an array of integers is 
dropped.  A struct powerop_point is now an entirely backend-defined 
struct of arbitrary fields.

There is no more PowerOP core layer; all data structures and functions 
for core functionality are provided by the machine-specific backend.

The diagnostic sysfs UI has been split out into a separate, optional 
patch.  A more full-featured UI allowing operating point creation and 
activation via sysfs has also been provided in that patch.  This UI 
primarily serves as an example for experimentation purposes, but is 
pretty close to what a basic userspace-based policy manager might need 
to switch operating points in response to infrequent changes in system 
state.

The UI also embodies the notion of a list of "named operating points" 
that could be registered by other means, such as loading a module with 
data structures that encode the desired operating points (as David 
Brownell has suggested).  The named operating points registered from 
such other interfaces can also be activated from the sysfs UI (that is, 
the hardware can be told to run at that operating point), as an example 
of how to tie in userspace policy managers with such a scheme.

The example platform backend this time is for an embedded system: the TI 
OMAP1 family of processors used for numerous mobile phones and PDAs.  It 
may better illustrate why managing multiple power parameters might be a 
useful capability.  I haven't put out an example of cpufreq integration 
this time, but the idea has changed little from before.

In case it's getting lost in all these details, the main point of all 
this is to pose the question: "are arbitrary power parameters arranged 
into a set with mutually consistent values (called here an operating 
point) a good low-level abstraction for system power management of a 
wide variety of platforms?"  Thanks,

-- 
Todd
