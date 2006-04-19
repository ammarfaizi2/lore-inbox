Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750731AbWDSMlP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750731AbWDSMlP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 08:41:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWDSMlP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 08:41:15 -0400
Received: from pproxy.gmail.com ([64.233.166.177]:62662 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750731AbWDSMlO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 08:41:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JK/yRttg9L9Ec7p87Ueug3LUGSWag773guyxJMLyI2vFLcIIw8uep3oiA8enOmk66EKo++6rd52fRbWPVM1QqFAr6JaM6iVZNziJTwOz3Ro9h35PUj6tRjrR1oxj14swPT6p17VWkKU0dQ8tNP0rtCejJdfCu7O3IT3YMSj6rkM=
Message-ID: <35fb2e590604190541v714d3604w544a83876e5db14a@mail.gmail.com>
Date: Wed, 19 Apr 2006 13:41:13 +0100
From: "Jon Masters" <jonathan@jonmasters.org>
To: "Duncan Sands" <duncan.sands@math.u-psud.fr>
Subject: Re: [PATCH] MODULE_FIRMWARE for binary firmware(s)
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
In-Reply-To: <200604191107.10562.duncan.sands@math.u-psud.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060418234156.GA28346@apogee.jonmasters.org>
	 <200604191107.10562.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/19/06, Duncan Sands <duncan.sands@math.u-psud.fr> wrote:

> Hi Jon,

Hi Duncan.

> > However, there is right now little mechanism in place to automatically
> > determine which binary firmware blobs must be included with a kernel in
> > order to satisfy the prerequisites of these drivers. This affects
> > vendors, but also regular users to a certain extent too.
> >
> > The attached patch introduces MODULE_FIRMWARE as a mechanism for
> > advertising that a particular firmware file is to be loaded - it will
> > then show up via modinfo and could be used e.g. when packaging a kernel.

> I haven't really understood what problem this solves.  Is this just a
> standardised form of documentation, or are you imagining that an automatic
> tool will use this to auto include a minimal set of firmware files in an
> initrd?

I'm imagining that the resultant modinfo output can be used by a tool
for anyone to package up the correct firmware to go with a given
driver. Right now, there's no way to do that - i.e. we've gone
backwards from a standpoint of coupling a kernel with firmware. I
completely understand why firmware doesn't really belong in the
kernel, so let's add this :-)

> I'm thinking of something like this: (1) redhat (or whoever) ships
> firmware files for every driver under the sun in /lib/firmware; (2) redhat
> wants to allow users to have a customized initrd with only essential drivers;
> (3) the tool goes through the list of essential drivers, looks up the firmware
> string via MODULE_FIRMWARE, finds the file in /lib/firmware, and includes it
> in the initrd.

That kind of thing. It's not just Red Hat who benefit - anyone who
wants to package up a kernel and do something with it will want to
know about firmware they might need. Including everything in
/lib/firmware "just in case" is as ugly as having userspace tools with
duplicated logic that need to understand about the internals of a
driver module.

Jon.
