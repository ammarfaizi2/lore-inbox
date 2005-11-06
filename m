Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbVKFXe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbVKFXe5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Nov 2005 18:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751286AbVKFXe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Nov 2005 18:34:57 -0500
Received: from ozlabs.org ([203.10.76.45]:20166 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751281AbVKFXe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Nov 2005 18:34:57 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17262.37107.857718.184055@cargo.ozlabs.ibm.com>
Date: Mon, 7 Nov 2005 10:25:39 +1100
From: Paul Mackerras <paulus@samba.org>
To: Greg KH <greg@kroah.com>
Cc: linas@austin.ibm.com, linuxppc64-dev@ozlabs.org, johnrose@austin.ibm.com,
       linux-pci@atrey.karlin.mff.cuni.cz,
       bluesmoke-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/42]: PCI:  PCI Error reporting callbacks
In-Reply-To: <20051105061114.GA27016@kroah.com>
References: <20051103235918.GA25616@mail.gnucash.org>
	<20051104005035.GA26929@mail.gnucash.org>
	<20051105061114.GA27016@kroah.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH writes:

> > +enum pcierr_result {
> > +	PCIERR_RESULT_NONE=0,        /* no result/none/not supported in device driver */
> > +	PCIERR_RESULT_CAN_RECOVER=1, /* Device driver can recover without slot reset */
> > +	PCIERR_RESULT_NEED_RESET,    /* Device driver wants slot to be reset. */
> > +	PCIERR_RESULT_DISCONNECT,    /* Device has completely failed, is unrecoverable */
> > +	PCIERR_RESULT_RECOVERED,     /* Device driver is fully recovered and operational */
> > +};
> 
> No, do not create new types of error or return codes.  Use the standard
> -EFOO values.  You can document what they should each return, and mean,
> but do not create new codes.

Actually, these are not error or return codes, but rather requested
actions (maybe somewhat misnamed).  We can map them on to -EFOO values
but it will be rather strained (-ECONNRESET for "please reset the
slot", anyone? :).

> Also, you create an enum, but yet do not use it in your function
> callback definition, which means you really didn't want to create it in
> the first place...

Yes, they could be #defines.

Paul.
