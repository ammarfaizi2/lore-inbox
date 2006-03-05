Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWCEIhA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWCEIhA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 03:37:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752082AbWCEIg6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 03:36:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:6593 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750704AbWCEIg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 03:36:57 -0500
Date: Sun, 5 Mar 2006 00:34:57 -0800
From: Andrew Morton <akpm@osdl.org>
To: Benoit Boissinot <bboissin@gmail.com>
Cc: linux-kernel@vger.kernel.org, stefan@loplof.de, jketreno@linux.intel.com,
       "John W. Linville" <linville@tuxdriver.com>,
       Jeff Garzik <jeff@garzik.org>
Subject: Re: 2.6.16-rc5-mm2
Message-Id: <20060305003457.48478db0.akpm@osdl.org>
In-Reply-To: <20060305081442.GH29560@ens-lyon.fr>
References: <20060303045651.1f3b55ec.akpm@osdl.org>
	<20060305081442.GH29560@ens-lyon.fr>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benoit Boissinot <bboissin@gmail.com> wrote:
>
> On 3/3/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.16-rc5/2.6.16-rc5-mm2/
> >
> >
> > - Should be a bit better than 2.6.16-rc5-mm1, but I still had to fix a ton
> >   of things to get this to compile and boot.  We're not being careful enough.
> >
> > - The procfs rework is getting there, but some problems probably still remain.
> >
> > - There will be a number of new warnings at boot time when initcalls fail.
> >   Generally that's OK: it usually indicates that you linked something into
> >   vmlinux which you're not actually using.  But sometimes it can indicate
> >   kernel bugs.
> >
> > - The (much-shrunk) audit git tree is back.
> >
> ...
> 
> >
> > Changes since 2.6.16-rc5-mm1:
> >
> >
> ...
> >  git-netdev-all.patch
> 
> commit 23afaec4441baf0579fa115b626242d4d23704dd
> Author: Stefan Rompf <stefan@loplof.de>
> Date:   Tue Feb 7 03:42:23 2006 +0800
> 
>     [PATCH] ipw2200: Fix WPA network selection problem
> 
> reverting this patch permits me to have access to the WEP network here.
> Otherwise wpa_supplicant cannot establish a connection.
> 

That check was changed from

	"If this STA doesn't use WPA and that AP does, then bale"

into

	"If this STA does use WPA and that AP doesn't then bale".

So a theory would be that your AP isn't filling in those WPA length fields.
I see no reason why we should permit that to disable WEP?
