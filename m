Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264870AbTFESww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jun 2003 14:52:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264880AbTFESww
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jun 2003 14:52:52 -0400
Received: from [195.82.120.238] ([195.82.120.238]:30364 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id S264870AbTFESwv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jun 2003 14:52:51 -0400
Date: Thu, 5 Jun 2003 20:10:13 +0100
From: Dave Jones <davej@codemonkey.org.uk>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Subject: Re: [BK PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
Message-ID: <20030605191013.GA14113@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	pcihpd-discuss@lists.sourceforge.net
References: <20030605013147.GA9804@kroah.com> <20030605021452.GA15711@kroah.com> <20030605083815.GA16879@suse.de> <20030605084933.GI2329@kroah.com> <20030605085938.GC16879@suse.de> <20030605090645.GA2887@kroah.com> <20030605091802.GA17356@suse.de> <20030605171835.GC5424@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030605171835.GC5424@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 05, 2003 at 10:18:35AM -0700, Greg KH wrote:

 > > The fact that a tree-wide 'cleanup' like this goes in just a few hours
 > > after its posted before chance to comment is another argument, but
 > > concentrating on the technical point here, I still think this is a
 > > step backwards.
 > 
 > Why?  I just got rid of a function (well macro) that isn't even needed
 > (as proven by replacing it with an existing function.)  That's
 > technically a good thing :)

Not when that replacement reduces readability, which in the case of
agpgart is all I care about wrt these changes.

 > Now I can agree that some of those replacements could be done with a
 > different function call, as almost none of the replacements in the
 > driver/* tree really want to walk all of the pci devices in the tree.
 > They usually just want to walk all devices of a type of pci device (be
 > it capability, or other trait.)  I'd be glad to take changes of this
 > sort in the future.

Ok, for the ones I'm interested in, (agpgart), I don't see how things
can get much cleaner than they used to be.

07 - hammer. Needs to walk the whole list, matching pci devices on
     bus 0, func 3, slots >23 & <32
	 This set of rules is so specialised, I see it hard to concieve how
	 a generic helper function for the pci layer could be written.
08 - generic. Needs to know about every AGP device on the bus.
     ok, a for_each_agp_dev may actually make life easier here,
	 but as its the only place this happens, consider it inlined,
	 using pci_for_each_dev
09 - isoch. Could also use a 'for_each_agp_dev', but to be honest,
     it shouldn't be scanning at all, but being passed what it needs.

For the time being, I'm actually tempted to hack up a 'for_each_agp_dev'
for the latter two, but 07 still bugs me.

		Dave

