Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751162AbVHUWWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751162AbVHUWWe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 18:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVHUWWe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 18:22:34 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:41407 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S1751162AbVHUWWd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 18:22:33 -0400
Date: Mon, 22 Aug 2005 00:22:29 +0200
From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
Subject: Re: 2.6.13-rc6-mm1
Message-ID: <20050821222229.GC6935@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Forwarded message from Benoit Boissinot <benoit.boissinot@ens-lyon.org> -----
sorry, i forgot to reply all...

From: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: 2.6.13-rc6-mm1
User-Agent: Mutt/1.5.10i

On Sun, Aug 21, 2005 at 06:11:57PM -0400, Jon Smirl wrote:
> On 8/21/05, Benoit Boissinot <benoit.boissinot@ens-lyon.org> wrote:
> > On Sun, Aug 21, 2005 at 01:40:31PM -0400, Jon Smirl wrote:
> > > On 8/21/05, Benoit Boissinot <bboissin@gmail.com> wrote:
> > > [snip]
> > >
> > > Somewhere there is a mistake in the white space processing code of the
> > > firmware driver. Before this patch we had inconsistent handling of
> > > whitespace and sysfs attributes. This patch forces it to be consistent
> > > and will shake out all of the places in the drivers where it is
> > > handled wrong. Sysfs attributes are now stripped of leading and
> > > trailing white space before being handed to the device driver.
> > 
> > ok, i found it. If i do echo 1, it will read '1\n', will
> > remove the '\n' and send '1' to ops->store.
> > Then it will re-read '\n' and send '' to ops->store.
> > And it will loop...
> 
> Look at the length being passed in, isn't it set to zero for the second case?
> 
yes, it is set to zero, but the '\n' will be stripped and stay in the buffer.
Since flush_write_buffer returns 0, ppos will not be incremented and we
have an endless loop.

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS

----- End forwarded message -----

-- 
powered by bash/screen/(urxvt/fvwm|linux-console)/gentoo/gnu/linux OS
