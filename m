Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWG1B4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWG1B4k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 21:56:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWG1B4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 21:56:39 -0400
Received: from sccrmhc14.comcast.net ([204.127.200.84]:64188 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S932107AbWG1B4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 21:56:37 -0400
Subject: Re: [RFC][PATCH] A generic boolean (version 6)
From: Nicholas Miell <nmiell@comcast.net>
To: ricknu-0@student.ltu.se
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jeff@garzik.org>,
       Alexey Dobriyan <adobriyan@gmail.com>,
       Vadim Lobanov <vlobanov@speakeasy.net>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Shorty Porty <getshorty_@hotmail.com>,
       Peter Williams <pwil3058@bigpond.net.au>, Michael Buesch <mb@bu3sch.de>,
       Pekka Enberg <penberg@cs.helsinki.fi>,
       Stefan Richter <stefanr@s5r6.in-berlin.de>, larsbj@gullik.net,
       Paul Jackson <pj@sgi.com>
In-Reply-To: <1154050195.44c968932df8d@portal.student.luth.se>
References: <1153341500.44be983ca1407@portal.student.luth.se>
	 <1153945705.44c7d069c5e18@portal.student.luth.se>
	 <200607270448.03257.arnd.bergmann@de.ibm.com>
	 <1153978047.2807.5.camel@entropy>
	 <1154030149.44c91a453d6b0@portal.student.luth.se>
	 <1154031240.2535.1.camel@entropy>
	 <1154050195.44c968932df8d@portal.student.luth.se>
Content-Type: text/plain
Date: Thu, 27 Jul 2006 18:56:32 -0700
Message-Id: <1154051792.2535.9.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5.0.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 03:29 +0200, ricknu-0@student.ltu.se wrote:
> Citerar Nicholas Miell <nmiell@comcast.net>:
> 
> > On Thu, 2006-07-27 at 21:55 +0200, ricknu-0@student.ltu.se wrote:
> > > Citerar Nicholas Miell <nmiell@comcast.net>:
> > > 
> > > > If _Bool does end up in the user-kernel ABI, be advised that validating
> > > > them will be tricky ("b == true || b == false" or "!!b" won't work), and
> > > 
> > > Why would !!b not work?
> > > I don't think it should end up in the ABI (at least, not yet). Just asking
> > > because I'm curious. :)
> > > 
> > 
> > The compiler knows that "b = !!b;" is a no-op.
> 
> In what gcc version? Using 4.0.2 myself and got that if b equals 12 (using a
> pointer to add the value to the boolean) then !!b equals 1.

gcc version 4.1.1 20060525 (Red Hat 4.1.1-1) compiles:

#include <stdbool.h>
bool validBool(bool b) { return (b == true || b == false); }
bool normalizeBool(bool b) { return !!b; }

to:

validBool:
        movl    $1, %eax
        ret

normalizeBool:
        movzbl  %dil, %eax
        ret

-- 
Nicholas Miell <nmiell@comcast.net>

