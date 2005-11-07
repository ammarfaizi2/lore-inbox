Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964899AbVKGS2K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVKGS2K (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 13:28:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbVKGS2K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 13:28:10 -0500
Received: from mail.kroah.org ([69.55.234.183]:38281 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S964899AbVKGS2J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 13:28:09 -0500
Date: Mon, 7 Nov 2005 10:27:27 -0800
From: Greg KH <greg@kroah.com>
To: linas <linas@austin.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org,
       johnrose@austin.ibm.com, linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/42]: PCI:  PCI Error reporting callbacks
Message-ID: <20051107182727.GD18861@kroah.com>
References: <20051103235918.GA25616@mail.gnucash.org> <20051104005035.GA26929@mail.gnucash.org> <20051105061114.GA27016@kroah.com> <17262.37107.857718.184055@cargo.ozlabs.ibm.com> <20051107175541.GB19593@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051107175541.GB19593@austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2005 at 11:55:41AM -0600, linas wrote:
> On Mon, Nov 07, 2005 at 10:25:39AM +1100, Paul Mackerras was heard to remark:
> > Greg KH writes:
> > 
> > > > +enum pcierr_result {
> > > > +	PCIERR_RESULT_NONE=0,        /* no result/none/not supported in device driver */
> > > > +	PCIERR_RESULT_CAN_RECOVER=1, /* Device driver can recover without slot reset */
> > > > +	PCIERR_RESULT_NEED_RESET,    /* Device driver wants slot to be reset. */
> > > > +	PCIERR_RESULT_DISCONNECT,    /* Device has completely failed, is unrecoverable */
> > > > +	PCIERR_RESULT_RECOVERED,     /* Device driver is fully recovered and operational */
> > > > +};
> > > 
> > > No, do not create new types of error or return codes.  Use the standard
> > > -EFOO values.  You can document what they should each return, and mean,
> > > but do not create new codes.
> > 
> > Actually, these are not error or return codes, but rather requested
> > actions 
> 
> Yes. 

Ok, then make them be stronger, and not return an int, as everyone will
get that wrong.

> In one incarnation, they were #defines.  The enum was supposed to be 
> the return value of the error notification callbacks.  
> 
> I can prepare a new patch: would you prefer:
> 
> 1) lose typing: #defines and int return value?
> 
> 2) strong typing: enum and enum return value?

3) realy strong typing that sparse can detect.

enums don't really work, as you can get away with using an integer and
the compiler will never complain.  Please use a typedef (yeah, I said
typedef) in the way that sparse will catch any bad users of the code.

> I often prefer strong typing.
> 
> And do you want a patch now, or later?

Depends on when you want to see this make it into mainline :)

thanks,

greg k-h
