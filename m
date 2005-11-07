Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbVKGRzu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbVKGRzu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 12:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbVKGRzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 12:55:50 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.145]:38833 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965051AbVKGRzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 12:55:49 -0500
Date: Mon, 7 Nov 2005 11:55:41 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: Greg KH <greg@kroah.com>, linuxppc64-dev@ozlabs.org,
       johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/42]: PCI:  PCI Error reporting callbacks
Message-ID: <20051107175541.GB19593@austin.ibm.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17262.37107.857718.184055@cargo.ozlabs.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
From: linas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 10:25:39AM +1100, Paul Mackerras was heard to remark:
> Greg KH writes:
> 
> > > +enum pcierr_result {
> > > +	PCIERR_RESULT_NONE=0,        /* no result/none/not supported in device driver */
> > > +	PCIERR_RESULT_CAN_RECOVER=1, /* Device driver can recover without slot reset */
> > > +	PCIERR_RESULT_NEED_RESET,    /* Device driver wants slot to be reset. */
> > > +	PCIERR_RESULT_DISCONNECT,    /* Device has completely failed, is unrecoverable */
> > > +	PCIERR_RESULT_RECOVERED,     /* Device driver is fully recovered and operational */
> > > +};
> > 
> > No, do not create new types of error or return codes.  Use the standard
> > -EFOO values.  You can document what they should each return, and mean,
> > but do not create new codes.
> 
> Actually, these are not error or return codes, but rather requested
> actions 

Yes. 

> (maybe somewhat misnamed).  

As to naming, my mind went blank on coming up with a good name,
and the results was a poor name.

I now note that "EDAC" ("Error Detection ad Correction") is now taken.

How about "PECS" ("PCI Error Correction System") ? 

I guess "PCI Error Detection And Recovery System" (PEDERAST) might
have an inappropriate set of connotations.

> We can map them on to -EFOO values
> but it will be rather strained (-ECONNRESET for "please reset the
> slot", anyone? :).

Yes, that would only lead to confusion.

> > Also, you create an enum, but yet do not use it in your function
> > callback definition, which means you really didn't want to create it in
> > the first place...
> 
> Yes, they could be #defines.

In one incarnation, they were #defines.  The enum was supposed to be 
the return value of the error notification callbacks.  

I can prepare a new patch: would you prefer:

1) lose typing: #defines and int return value?

2) strong typing: enum and enum return value?

I often prefer strong typing.

And do you want a patch now, or later?

--linas

