Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262461AbUKQUJt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262461AbUKQUJt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 15:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262415AbUKQUJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 15:09:10 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:56415 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262449AbUKQUHc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 15:07:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=P9L1YZPNULsFWs1Py7g/376kpQPMIM0d8oeP67GqXAFHudz5PBFePw5abAWO+I2bvdIwNwNod61d0QhwDy0IaW7zMPWDklTxDAoEy95Aaoj84nmwWyXsI+vqxqG1njCkTf8LsqKcoVv2QyP0KBlVloSOgOM1elkIMS3l+CIJigg=
Message-ID: <58cb370e04111712074d85e17e@mail.gmail.com>
Date: Wed, 17 Nov 2004 21:07:32 +0100
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: "Steffen A. Mork" <linux-dev@morknet.de>
Subject: Re: [PATCH] dss1_divert ISDN module compile fix for kernel 2.6.8.1
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au, torvalds@osdl.org
In-Reply-To: <419B9E06.6020100@morknet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <419B662D.5020904@morknet.de>
	 <58cb370e0411170828365d1982@mail.gmail.com>
	 <419B9E06.6020100@morknet.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Nov 2004 19:52:54 +0100, Steffen A. Mork
<linux-dev@morknet.de> wrote:
> Dear Linus and Bartlomiej,
> 
> 
> 
> >>when I switched my installation from kernel 2.4 to 2.6 I
> >>recognized that the ISDN module dss1_divert was marked
> >>incompilable (config option CONFIG_CLEAN_COMPILE must
> >>be turned off). The compile problem was the obsolete using
> >>of kernel 2.4 critical sections. I replaced the cli() stuff
> >>with spinlocks as explained in the Documentation/spinlocks.txt
> >>file. After that the module compiles and runs as expected.
> >
> >
> > This looks wrong, you are using many private spinlocks instead
> > of one global spinlock.

Moreover, you must make sure that there is no other code (ie. in generic
ISDN code) doing cli() stuff on objects that you are protecting by a spinlock
etc., I've checked divert driver and it looks OK.

> OK, thank you. I went into the copy/paste trap. I corrected the patch to
> a global spinlock and tested it successfully.

Great.

> The corrected patch is applied to kernel 2.6.8.1 and should work for
> all 2.6 versions. You may also download the patch via http, too:
> 
> http://ls7-www.cs.uni-dortmund.de/~mork/dss1_divert.diff
> 
> Signed-off-by: Steffen A. Mork <linux-dev@morknet.de>

Please do "interdiff" between the old and the new patch
and send it to Linus (he has already merged the old patch).

Thanks.
Bartlomiej
