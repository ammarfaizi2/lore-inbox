Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753399AbWKCRgJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbWKCRgJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 12:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753402AbWKCRgJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 12:36:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23453 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1753399AbWKCRgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 12:36:07 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: tim.c.chen@linux.intel.com
Cc: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, ak@suse.de,
       discuss@x86-64.org
Subject: Re: 2.6.19-rc1: x86_64 slowdown in lmbench's fork
References: <1162485897.10806.72.camel@localhost.localdomain>
	<m1d5851yxd.fsf@ebiederm.dsl.xmission.com>
	<1162492453.10806.75.camel@localhost.localdomain>
	<20061103021145.GD13381@stusta.de>
	<1162570216.10806.79.camel@localhost.localdomain>
Date: Fri, 03 Nov 2006 10:35:36 -0700
In-Reply-To: <1162570216.10806.79.camel@localhost.localdomain> (Tim Chen's
	message of "Fri, 03 Nov 2006 08:10:16 -0800")
Message-ID: <m1lkmsxwk7.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Chen <tim.c.chen@linux.intel.com> writes:

> On Fri, 2006-11-03 at 03:11 +0100, Adrian Bunk wrote:
>
>> 
>> What's your CONFIG_NR_CPUS setting that you are seeing such a big
>> regression?
>> 
>
> CONFIG_NR_CPUS is set to 8.  

Ugh.  This simply changes NR_IRQS from 256 to 512.  Changing
the size of data from 1K to 2K.

So unless there is some other array that is sized by NR_IRQs
in the context switch path which could account for this in
other ways.  It looks like you just got unlucky.

The only hypothesis that I can seem to come up with is that maybe
you are getting an extra tlb now that you didn't use to.  
I think the per cpu area is covered by huge pages but maybe not.

Eric
