Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261796AbVASReW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261796AbVASReW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 12:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261803AbVASRcp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 12:32:45 -0500
Received: from palrel13.hp.com ([156.153.255.238]:48260 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S261792AbVASRbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 12:31:13 -0500
Date: Wed, 19 Jan 2005 09:31:11 -0800
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>,
       netdev@oss.sgi.com
Subject: Re: [BUG] MODULE_PARM conversions introduces bug in Wavelan driver
Message-ID: <20050119173111.GB25969@bougret.hpl.hp.com>
Reply-To: jt@hpl.hp.com
References: <20050119004722.GA26468@bougret.hpl.hp.com> <1106102553.20879.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1106102553.20879.4.camel@localhost.localdomain>
User-Agent: Mutt/1.3.28i
Organisation: HP Labs Palo Alto
Address: HP Labs, 1U-17, 1501 Page Mill road, Palo Alto, CA 94304, USA.
E-mail: jt@hpl.hp.com
From: Jean Tourrilhes <jt@hpl.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2005 at 01:42:33PM +1100, Rusty Russell wrote:
> On Tue, 2005-01-18 at 16:47 -0800, Jean Tourrilhes wrote:
> > 	Hi Rusty,
> > 
> > 	(If you are not the culprit, please forward to the guilty party).
> 
> Almost certainly me.  We gave people warning, we even marked MODULE_PARM
> deprecated, but eventually I had to roll through and try to autoconvert.

	I have nothing against the change to module_param_array(), and
I even think that it's a good idea. Just doing my job of peer review.

> > 	I personally introduced the "double char array" module
> > parameter, 'c', to fix that. I even sent you the patch to add 'c'
> > support in your new module loader (see set_obsolete()). Would it be
> > possible to carry this feature with the new module_param_array ?
> > 	Thanks in advance...
> 
> Actually, it's designed so you can extend it yourself: at its base,
> module_param_call() is just a callback mechanism.

	Yes, I could do my little hack in my corner, but I think it
would be counter productive. I'm sure that compared to adding a check
on strlen, it would be more bloat. But, more importantly, I would make
the code more obscure and unmaintanable.

	But, I think you are missing the point I'm making. We are
striving to make APIs that are simple, efficient and avoid users to
make stupid mistakes. The conversion from MODULE_PARM to module_param
goes exactly in this direction, as it adds more type safety. This is
good, as module_param is probably the most used user/kernel interface.
	I believe that buffer overrun is the number one security
problem in Linux. It seems that it even happens to the best of us. So,
it would seem to me that making the module_param API a bit more bullet
proof with regard to buffer overrun might be a good idea.
	So, I'm not advocating that you build this feature just for
me, but that you make it the standard and force people to use it.

> Thanks!
> Rusty.

	Have fun...

	Jean
