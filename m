Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWDXOtI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWDXOtI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 10:49:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbWDXOtH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 10:49:07 -0400
Received: from [212.33.164.160] ([212.33.164.160]:62476 "EHLO raad.intranet")
	by vger.kernel.org with ESMTP id S1750805AbWDXOtH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 10:49:07 -0400
From: Al Boldi <a1426z@gawab.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 1/1] threads_max: Simple lockout prevention patch
Date: Mon, 24 Apr 2006 17:46:42 +0300
User-Agent: KMail/1.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <200511142327.18510.a1426z@gawab.com> <200604241653.49647.a1426z@gawab.com> <1145887895.32427.5.camel@localhost>
In-Reply-To: <1145887895.32427.5.camel@localhost>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="windows-1256"
Content-Transfer-Encoding: 7bit
Message-Id: <200604241746.43005.a1426z@gawab.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka Enberg wrote:
> On 4/24/06, Al Boldi <a1426z@gawab.com> wrote:
> > > > Like so?
> > > >         if (nr_threads >= max_threads)
> > > >                 if (p->pid != su_pid)
> > > >                         goto bad_fork_cleanup_count;
> > >
> > > It's better to combine the two if statements into one with &&.
>
> > I thought of combining them too, but was afraid of some compile
> > optimization issues.  Remember, this code-path is executed for each and
> > every fork in the system, thus it's highly performance sensitive.
>
> There shouldn't be any difference.

There shouldn't, if things were perfect.

> What compiler optimizations are you referring to?

-O3 at least.

> Did you study the generated object code?

Not really.

But -O3 creates faster code w/ some strange flaws like failing nfs-boot.
Maybe that's fixed in the latest gcc, but gcc-3.2.2 was exhibiting this bug.
So this doesn't really help a developer to be confident about compiler 
optimization, thus taking the safe route for performance sensitive 
code-paths.

Thanks!

--
Al

