Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261749AbVBICIW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261749AbVBICIW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Feb 2005 21:08:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261746AbVBICHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Feb 2005 21:07:45 -0500
Received: from palrel13.hp.com ([156.153.255.238]:53148 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261745AbVBICHb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Feb 2005 21:07:31 -0500
Date: Tue, 8 Feb 2005 18:07:13 -0800
To: Chris Wright <chrisw@osdl.org>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.4] Wireless Extension v17 (resend)
Message-ID: <20050209020713.GA12770@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20050208181637.GB29717@bougret.hpl.hp.com> <20050208180116.GA10695@logos.cnet> <20050208215112.GB3290@bougret.hpl.hp.com> <20050208184145.GD10799@logos.cnet> <20050209003746.GB9792@bougret.hpl.hp.com> <20050208175129.G469@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050208175129.G469@build.pdx.osdl.net>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2005 at 05:51:29PM -0800, Chris Wright wrote:
> * Jean Tourrilhes (jt@hpl.hp.com) wrote:
> > 	The first is the handling of spyoffset which is potentially
> > unsafe. Unfortunately, the fix involve some API/infrastructure change,
> > so is not transparent. Fortunately drivers are clever enough to not
> > trigger this bug.
> > 	The second is a potential leak of kernel data to user space in
> > private handler handling. Few drivers use that feature, there is no
> > risk of crash or direct attack, so I would not worry about it.
> 
> Hmm, having ability to read kernel data is not so nice.

	It's not like you can read any arbitrary address, exploiting
such a flaw is in my mind theoritical. Let's not overblow things,
there are some real bugs to take care of.

>  prism54 uses
> this, and is a reasonably popular card.  Looks to me like this should be
> plugged.  Is the patch below sufficient? (stolen from full 2.6 patch)

	Yep, except that you have an extra chunk that should not be
in. You probably did not use the latest version of the patch (and that
was not in the one sent to Marcelo). I would not like to introduce a
real bug in 2.4.X :-(

> thanks,
> -chris

	This chunk is erroneous :

> @@ -731,7 +749,7 @@ static inline int ioctl_private_call(str
>  				return -EFAULT;
>  
>  			/* Does it fits within bounds ? */
> -			if(iwr->u.data.length > (descr->set_args &
> +			if(iwr->u.data.length > (descr->get_args &
>  						 IW_PRIV_SIZE_MASK))
>  				return -E2BIG;
>  		} else {

	Have fun...

	Jean
