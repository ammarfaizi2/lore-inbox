Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264196AbUD0Q6n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbUD0Q6n (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Apr 2004 12:58:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264198AbUD0Q6n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Apr 2004 12:58:43 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:20387 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S264196AbUD0Q6i
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Apr 2004 12:58:38 -0400
Date: Tue, 27 Apr 2004 12:58:19 -0400
From: Marc Boucher <marc@linuxant.com>
To: linux-kernel@vger.kernel.org
Cc: torvalds@osdl.org, rusty@rustcorp.com.au, pmarques@grupopie.com,
       c-d.hailfinger.kernel.2004@gmx.net, jon787@tesla.resnet.mtu.edu,
       malda@slashdot.org
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040427165819.GA23961@valve.mbsi.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040427161853.GC28206@tesla.resnet.mtu.edu>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

On Tue, Apr 27, 2004 at 04:09:36AM +0200, Carl-Daniel Hailfinger wrote:
> Hi,
> 
> LinuxAnt offers binary only modules without any sources.

Not true. Linuxant modules come with full source for operating-system specific
code.

> To circumvent our
> MODULE_LICENSE checks LinuxAnt has inserted a "\0" into their declaration:
>
> MODULE_LICENSE("GPL\0for files in the \"GPL\" directory; for others, only
> LICENSE file applies");


Paulo Marques said:
> The way I see it, they know a C string ends with a '\0'. This is like saying 
> that a English sentence ends with a dot. If they wrote "GPL\0" they are 
> effectively saying that the license *is* GPL period.
> 
> So, where the source code? :)

Unfortunately Linuxant cannot release the source for the proprietary portions
of the Conexant HCF and HSF softmodem drivers, because it does not own these
parts and the terms under which they have been licensed from Conexant prohibit
it.

We have tried to attenuate the inconvenience of these restrictions by isolating
the proprietary code and releasing source for all operating-system specific
code, so that people can rebuild the modules for any kernel.

I believe that this is a fair compromise. Otherwise, it wouldn't be possible to
use Conexant softmodems under Linux right now, since 1) the hardware is quite
obscure, 2) no-one has fully implemented the modulations (such as V.92 etc..)
and related protocols (V.44/V.42[bis]) for free, because this stuff is quite
complex and involves many patents. Before blaming Conexant for protecting their
intellectual property, one should note that as far as I know none of the
other softmodem manufacturers (Lucent/Agere, SmartLink, Motorola, PC-Tel etc..)
have ever accepted to give the source code away for their proprietary
implementations of modem modulations either.  

Willy Tarreau <willy () w ! ods ! org> wrote:

> Funny, this reminds me of VGA BIOSes which put "IBM Compatible" at the right
> location, because lots of programs were looking for "IBM" to check if this
> way such a bios. Same check, same workaround :-) I hope they have patented
> this trick so that they will be the only ones using it :-)
> 
> > The attached patch blacklists all modules having "Linuxant" or "Conexant"
> > in their author string. This may seem a bit broad, but AFAIK both
> > companies never have released anything under the GPL and have a strong
> > history of binary-only modules.
> 
> What would be smarter would be to try to understand why they do this.
> 

Exactly. Linuxant's intent is NOT to circumvent any license checks (see
below for why this specific workaround was put in) which would be unnecessary
since the drivers in question do not use any GPL_ONLY functions, as far as
I know.

> At
> the moment, it seems to me that their only problem is to taint the kernel.

Actually, we also have no desire nor purpose to prevent tainting. The purpose
of the workaround is to avoid repetitive warning messages generated when
multiple modules belonging to a single logical "driver"  are loaded (even when
a module is only probed but not used due to the hardware not being present).
Although the issue may sound trivial/harmless to people on the lkml, it was a
frequent cause of confusion for the average person.

Other Linuxant drivers (like DriverLoader and Riptide) do not need nor use this
workaround because they are not composed of multiple modules and one set of
warning messages is usually bearable. 

> Why ? I don't this that any old modutils/module-utils found in any distros
> don't load properly such modules. So perhaps they only want not to taint
> the kernel because it appears dirty to their customers who will not receive
> any more support from LKML. So perhaps what we really need is to add a new
> MODULE_SUPPORT field stating where to get support from in case of bugs,
> oopses or panics on a tainted kernel. Thus, the module author would be able
> to insert something such as "support_XXX@author.com" which will be displayed
> on each oops/panic/etc... Even if this is a long list because the customer
> uses connexant, nvidia, checkpoint and I don't know what, at least he will
> get 3 email addresses for his support. And it might reassure these authors
> to know that the customer will ask them before asking us with our automatic
> replies "unload your binary modules...".

Linuxant would very much welcome such steps to improve the current situation,
and is willing to eliminate workarounds once they are no longer necessary.

Sincerely,
Marc

--
Marc Boucher
President
Linuxant inc.
http://www.linuxant.com
