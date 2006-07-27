Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWG0F1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWG0F1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 01:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWG0F1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 01:27:46 -0400
Received: from alnrmhc11.comcast.net ([206.18.177.51]:64896 "EHLO
	alnrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1750795AbWG0F1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 01:27:46 -0400
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
From: Nicholas Miell <nmiell@comcast.net>
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Cc: ricknu-0@student.ltu.se, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <200607270448.03257.arnd.bergmann@de.ibm.com>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	 <1153945705.44c7d069c5e18@portal.student.luth.se>
	 <200607270448.03257.arnd.bergmann@de.ibm.com>
Content-Type: text/plain
Date: Wed, 26 Jul 2006 22:27:27 -0700
Message-Id: <1153978047.2807.5.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-07-27 at 04:48 +0200, Arnd Bergmann wrote:
> On Wednesday 26 July 2006 22:28, ricknu-0@student.ltu.se wrote:
> > Have not found any (real) reason letting the cpp know about false/true. As I
> > said in the last version, the only reason seem to be for the userspace. Well, as
> > there is no program of my knowlage that needs it, they were removed.
> > 
> If we don't expect this to show up in the ABI (which I hope is true), then
> the definition should probably be inside of #ifdef __KERNEL__. Right
> now, it's inside of (!__KERNEL_STRICT_NAMES), which is not exactly the
> same.
> 

If _Bool does end up in the user-kernel ABI, be advised that validating
them will be tricky ("b == true || b == false" or "!!b" won't work), and
the compiler could in theory generate code which tests truthfulness by
comparing to 1 in one place and non-zero in another.

My brief IRC conversation with gcc people regarding validating untrusted
_Bool resulted in the instruction to never store a value in a _Bool
until after it has been validated. 

-- 
Nicholas Miell <nmiell@comcast.net>

