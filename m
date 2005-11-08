Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbVKHBMT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbVKHBMT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 20:12:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbVKHBMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 20:12:19 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:56314 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965027AbVKHBMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 20:12:19 -0500
Subject: Re: typedefs and structs [was Re: [PATCH 16/42]: PCI:  PCI Error
	reporting callbacks]
From: Steven Rostedt <rostedt@goodmis.org>
To: linas <linas@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net,
       linux-pci@atrey.karlin.mff.cuni.cz, johnrose@austin.ibm.com,
       linuxppc64-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <20051107204136.GG19593@austin.ibm.com>
References: <20051103235918.GA25616@mail.gnucash.org>
	 <20051104005035.GA26929@mail.gnucash.org>
	 <20051105061114.GA27016@kroah.com>
	 <17262.37107.857718.184055@cargo.ozlabs.ibm.com>
	 <20051107175541.GB19593@austin.ibm.com> <20051107182727.GD18861@kroah.com>
	 <20051107185621.GD19593@austin.ibm.com> <20051107190245.GA19707@kroah.com>
	 <20051107193600.GE19593@austin.ibm.com> <20051107200257.GA22524@kroah.com>
	 <20051107204136.GG19593@austin.ibm.com>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Mon, 07 Nov 2005 20:11:13 -0500
Message-Id: <1131412273.14381.142.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-11-07 at 14:41 -0600, linas wrote:

> 
> > > Also, "grep typedef include/linux/*" shows that many kernel device
> > > drivers use this convention.
> > 
> > They are wrong and should be fixed.
> 
> What, precisely, is wrong?

I can't seem to find it on google, but IIRC Linus stated that he didn't
want any more structures defined with typedefs.  If it is a structure,
simple keep it one, and don't use typedef to get rid of "struct".

This was for the simple reason, too many developers were passing
structures by value instead of by reference, just because they were
using a type that they didn't realize was a structure. And to make
things worse, these structures started to get bigger.

So in my every day programming, I switched to not typedef structures
anymore, and I even found some places that I passed structures by value
when it would have been much more efficient by reference.

The only exceptions that I can see where you typedef a structure is for
use with arch dependent types, like atomic_t. 

-- Steve


