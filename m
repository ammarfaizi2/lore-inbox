Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWJJQbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWJJQbM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 12:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932197AbWJJQbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 12:31:12 -0400
Received: from mga05.intel.com ([192.55.52.89]:52107 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932167AbWJJQbL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 12:31:11 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="144212264:sNHT19784534"
Subject: Re: [PATCH] Fix WARN_ON / WARN_ON_ONCE regression
From: Tim Chen <tim.c.chen@linux.intel.com>
Reply-To: tim.c.chen@linux.intel.com
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Andrew Morton <akpm@osdl.org>, Jeremy Fitzhardinge <jeremy@goop.org>,
       herbert@gondor.apana.org.au, linux-kernel@vger.kernel.org,
       leonid.i.ananiev@intel.com
In-Reply-To: <1160485474.22525.6.camel@localhost.localdomain>
References: <1159916644.8035.35.camel@localhost.localdomain>
	 <4522FB04.1080001@goop.org>
	 <1159919263.8035.65.camel@localhost.localdomain>
	 <45233B1E.3010100@goop.org>
	 <1159968095.8035.76.camel@localhost.localdomain>
	 <20061004093025.ab235eaa.akpm@osdl.org>
	 <1159978929.8035.109.camel@localhost.localdomain>
	 <20061004103408.1a38b8ad.akpm@osdl.org>
	 <1160442541.4548.15.camel@localhost.localdomain>
	 <1160485474.22525.6.camel@localhost.localdomain>
Content-Type: text/plain
Organization: Intel
Date: Tue, 10 Oct 2006 08:41:46 -0700
Message-Id: <1160494906.4548.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-10 at 09:04 -0400, Steven Rostedt wrote:

> 
> Holy crap!  I wonder where else in the kernel gcc is doing this. (of
> course I'm using gcc4 so I don't know).  Is there another gcc attribute
> to actually tell gcc that a variable is really mostly read only (besides
> placing it in a mostly read only elf section)?
> 
> What was wrong with the original WARN_ON_ONCE with
> 
>   if (unlikely(condition) && __warn_once)
> 
> This didn't have the cache crash problem too, did it?
> I don't have a gcc3 around to test.

In the original WARN_ON_ONCE, gcc3 only writes to __warn_once when
(condition) is true.  So it does not cause cache bouncing by always
writing to __warn_once.

Tim
