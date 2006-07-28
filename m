Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161328AbWG1Wbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161328AbWG1Wbj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 18:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161330AbWG1Wbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 18:31:39 -0400
Received: from a222036.upc-a.chello.nl ([62.163.222.36]:31975 "EHLO
	laptopd505.fenrus.org") by vger.kernel.org with ESMTP
	id S1161328AbWG1Wbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 18:31:38 -0400
Subject: Re: [patch 5/5] Add the -fstack-protector option to the CFLAGS
From: Arjan van de Ven <arjan@linux.intel.com>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20060728215852.GA1164@mars.ravnborg.org>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
	 <200607282045.05292.ak@suse.de>
	 <1154112511.6416.46.camel@laptopd505.fenrus.org>
	 <200607282100.01783.ak@suse.de> <20060728212643.GA32455@mars.ravnborg.org>
	 <1154122845.6416.61.camel@laptopd505.fenrus.org>
	 <20060728215852.GA1164@mars.ravnborg.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sat, 29 Jul 2006 00:31:30 +0200
Message-Id: <1154125890.6416.68.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 23:58 +0200, Sam Ravnborg wrote:
> On Fri, Jul 28, 2006 at 11:40:45PM +0200, Arjan van de Ven wrote:
> > On Fri, 2006-07-28 at 23:26 +0200, Sam Ravnborg wrote:
> > > On Fri, Jul 28, 2006 at 09:00:01PM +0200, Andi Kleen wrote:
> > > > On Friday 28 July 2006 20:48, Arjan van de Ven wrote:
> > > > > On Fri, 2006-07-28 at 20:45 +0200, Andi Kleen wrote:
> > > > > > > +ifdef CONFIG_CC_STACKPROTECTOR
> > > > > > > +CFLAGS += $(call cc-ifversion, -lt, 0402, -fno-stack-protector)
> > > > > > > +CFLAGS += $(call cc-ifversion, -ge, 0402, -fstack-protector)
> > > > > >
> > > > > > Why can't you just use the normal call cc-option for this?
> > > > >
> > > > > this requires gcc 4.2; cc-option is not useful for that.
> > > > 
> > > > The CC option thing is also very ugly.
> > > The check is executed once pr. kernel compile - or at least once pr.
> > > line. The reson to use cc-ifversion is that we need to check for a
> > > specific gcc version and not just support for a specific argument type.
> > > 
> > > That said - checking for a version is not as reliable as checking if a
> > > certain feature is really supported but Arjan suggested testing for
> > > version >= 4.2 should do it.
> > 
> > 
> > it's not hard to run a shell script that returns supported or not. I can
> > do the shell script no problem... but I would prefer that you then do
> > the Makefile foo for it :)
> > Would that work?
> Yep - no problem. If you give me a day or two to do it.

sure no problem.

the following line is enough actually:

echo "int foo(void) { char X[200]; return 3; }" | gcc -S -xc -c -O0 -mcmodel=kernel -fstack-protector - -o - | grep -q "%gs"

echo $? (eg return value) gives 0 for the "works" case, "1" for the
"wrong gcc" case...

