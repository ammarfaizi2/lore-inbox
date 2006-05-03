Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965038AbWECORe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965038AbWECORe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 10:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965094AbWECORe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 10:17:34 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:17526 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S965038AbWECORd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 10:17:33 -0400
Subject: Re: [PATCH] s390: Hypervisor File System
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Michael Holzheu <HOLZHEU@de.ibm.com>
Cc: =?ISO-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>, akpm@osdl.org,
       Greg KH <greg@kroah.com>, ioe-lkml@rameria.de,
       linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>,
       mschwid2@de.ibm.com, Pekka J Enberg <penberg@cs.Helsinki.FI>
In-Reply-To: <OFD9F4B481.11F464BA-ON42257163.004A4500-42257163.004AEB51@de.ibm.com>
References: <OFD9F4B481.11F464BA-ON42257163.004A4500-42257163.004AEB51@de.ibm.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Wed, 03 May 2006 16:17:40 +0200
Message-Id: <1146665860.2661.21.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-03 at 15:38 +0200, Michael Holzheu wrote:
> > On Wed, 3 May 2006 15:18:41 +0200, Michael Holzheu wrote:
> > >
> > o People are not forced to follow the convention.  If they don't and
> >   you break an existing application, you get the blame.
> 
> Sure, but this is really just a matter of definition. The kernel defines
> the ABI, right?. User space has to follow the rules. If they break the
> rules
> that's badluck for the userspace tools. Currently you can also
> get kernel information directly from /dev/mem. If an application
> does that, nobody would say, that we are not allowed to change
> kernel data structures because of that user space application.

The kernel defines the ABI, but what IS the ABI? Is a single space that
the current implementation delivers an indication that there needs to be
a single space between two values, or could there be an arbitrary number
of spaces and tabs? You certainly can't conclude that from the code.
For /proc files people tended to use sscanf to read lines from the
output. Is the format of a line fixed, or can it be extended by
additional fields? Does certain fields have to start at a specific
offset or not? How long can the different fields get? And so on.

> > o Now you have a dependency on the standard parser, which is in
> >   userspace.  Any bug in any version of the standard parser and...
> 
> At least this parser should be well tested, if everybody uses it.

And the user space then uses the parser only? Is now the parser
interface the "ABI" or the kernel interface that is in turn used by the
parser? And what happens if somebody comes up with a "better" parser
that does things subtly different? 

In short: keep the kernel interface as simple as you possibly can. That
is why the single value approach has been invented. A text file that
needs to get parsed is certainly not simple.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


