Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275572AbTHMVGb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 17:06:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275573AbTHMVGb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 17:06:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:44558 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S275572AbTHMVG0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 17:06:26 -0400
Date: Wed, 13 Aug 2003 22:06:19 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Greg KH <greg@kroah.com>, "David S. Miller" <davem@redhat.com>,
       rddunlap@osdl.org, davej@redhat.com, willy@debian.org,
       linux-kernel@vger.kernel.org,
       kernel-janitor-discuss@lists.sourceforge.net
Subject: Re: C99 Initialisers
Message-ID: <20030813220619.F20676@flint.arm.linux.org.uk>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>, Greg KH <greg@kroah.com>,
	"David S. Miller" <davem@redhat.com>, rddunlap@osdl.org,
	davej@redhat.com, willy@debian.org, linux-kernel@vger.kernel.org,
	kernel-janitor-discuss@lists.sourceforge.net
References: <20030813004941.GD2184@redhat.com> <32835.4.4.25.4.1060743746.squirrel@www.osdl.org> <3F39AFDF.1020905@pobox.com> <20030813031432.22b6a0d6.davem@redhat.com> <20030813173150.GA3317@kroah.com> <3F3A79CA.6010102@pobox.com> <20030813180245.GC3317@kroah.com> <3F3A82C3.5060006@pobox.com> <20030813193855.E20676@flint.arm.linux.org.uk> <3F3A952C.4050708@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3F3A952C.4050708@pobox.com>; from jgarzik@pobox.com on Wed, Aug 13, 2003 at 03:44:44PM -0400
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 13, 2003 at 03:44:44PM -0400, Jeff Garzik wrote:
> Russell King wrote:
> > But what's the point of the extra complexity?  People already put
> > references to other structures in the driver_data element, and
> > enums, so completely splitting the device IDs from the module
> > source is not going to be practical.
> 
> enums are easy  putting direct references would be annoying, but I also 
> argue it's potentially broken and wrong to store and export that 
> information publicly anyway.

Until new_id occurred, driver_data wasn't public, so this is a new
problem.

> The use of enums instead of pointers is practically required because
> there is a many-to-one relationship of ids to board information structs.

Hmm.  Now that driver_data is public, people will bitch when the enums
change.  This is _NOT_ something what I want to deal with - if I want
to add a new TI bridge type, I want to add the new TI enumeration
identifier along side the other TI enumeration identifiers, not at the
end.  I don't want to worry about whether the user is using the enum
values or not.  (eg, so I can use expressions like: 
 if (id->driver_data >= first_ti_id && id->driver_data <= last_ti_id))

By separating this, it effectively taking away some of the driver authors
freedoms to make choices like this, and this /will/ make driver code more
ugly.

> > Are you thinking of a parser which outputs C code for the module to
> > include?  That might be made to work, but it doesn't sound as elegant
> > as the solution being described previously in this thread.
> > 
> > "Make the easy things easy (PCI_DEVICE(vendor,device)) and make the
> > not so easy things possible (the long form)"
> 
> That ignores the people who also need to get at the data, which must 
> first be compiled from C into object code, then extracted via modutils, 
> then turned into a computer readable form again, then used.

Could you describe the "user" side of your idea more?  ie, what would
get installed onto the filesystem, and how would the tables be used?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

