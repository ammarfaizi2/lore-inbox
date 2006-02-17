Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751471AbWBQQ1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751471AbWBQQ1B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161137AbWBQQ1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:27:00 -0500
Received: from mx1.suse.de ([195.135.220.2]:32443 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751574AbWBQQ06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:26:58 -0500
From: Andi Kleen <ak@suse.de>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH: 001/012] Memory hotplug for new nodes v.2. (pgdat allocation)
Date: Fri, 17 Feb 2006 17:16:33 +0100
User-Agent: KMail/1.8.2
Cc: Yasunori Goto <y-goto@jp.fujitsu.com>, Andrew Morton <akpm@osdl.org>,
       "Luck, Tony" <tony.luck@intel.com>,
       "Tolentino, Matthew E" <matthew.e.tolentino@intel.com>,
       Joel Schopp <jschopp@austin.ibm.com>, linux-ia64@vger.kernel.org,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       x86-64 Discuss <discuss@x86-64.org>
References: <20060217210749.406A.Y-GOTO@jp.fujitsu.com> <1140190792.21383.64.camel@localhost.localdomain>
In-Reply-To: <1140190792.21383.64.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602171716.34297.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 17 February 2006 16:39, Dave Hansen wrote:

> I'm a teensy bit concerned that this doesn't share enough code with the
> boot-time initialization.  For instance, the kthread_create() seems to
> be a pretty darn generic piece.  I'd feel a lot more at ease if this
> patch did something with _existing_ code instead of just adding.

Agreed. Having significantly different code paths for hot add and
for normal initialization isn't a good idea. It will just lead to 
long term code drift and problems.

So i would suggest to generalize the standard functions enough
to make them callable from a hotplug layer.

-Andi
