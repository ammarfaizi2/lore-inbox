Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbVHUVmo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbVHUVmo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Aug 2005 17:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751183AbVHUVmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Aug 2005 17:42:43 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:45517 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751175AbVHUVmm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Aug 2005 17:42:42 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Qfqfj9WQ6LhlgOEWg/uyosm61Vywh+cPKRj976Z1hnqO00mKEMh2v1n9wiVnyqfZdYcm9ziPgFw8XE4q8hGb4LOaoyhL4GtOrplLLooXvJjtr9Fszjp0QJKBc6sFYpqAFLsguSKKAKciaJMz/wSrscp+6sEpXWTxfKvYSLPB0ko=
Message-ID: <9e47339105082110405b2a48c8@mail.gmail.com>
Date: Sun, 21 Aug 2005 13:40:31 -0400
From: Jon Smirl <jonsmirl@gmail.com>
To: Benoit Boissinot <bboissin@gmail.com>
Subject: Re: 2.6.13-rc6-mm1
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Greg KH <greg@kroah.com>
In-Reply-To: <40f323d005082109303c0865a3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050819043331.7bc1f9a9.akpm@osdl.org>
	 <40f323d005082109303c0865a3@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/21/05, Benoit Boissinot <bboissin@gmail.com> wrote:
> On 8/19/05, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.13-rc6/2.6.13-rc6-mm1/
> >
> > - Lots of fixes, updates and cleanups all over the place.
> >
> > - If you have the right debugging options set, this kernel will generate
> >   a storm of sleeping-in-atomic-code warnings at boot, from the scsi code.
> >   It is being worked on.
> >
> >
> > Changes since 2.6.13-rc5-mm1:
> > [...]
> > +gregkh-driver-sysfs-strip_leading_trailing_whitespace.patch
> > [...]
> 
> 
> it broke loading of firmware for me.(dmesg was flooded with
> "firmware_loading_store:  unexpected value (0)")
> 
> firmware.agent uses echo so there is a trailing newline. If i changes
> firmware.agent to uses echo -n it works correctly.
> 
> Is this a bug or the correct behaviour ?

Somewhere there is a mistake in the white space processing code of the
firmware driver. Before this patch we had inconsistent handling of
whitespace and sysfs attributes. This patch forces it to be consistent
and will shake out all of the places in the drivers where it is
handled wrong. Sysfs attributes are now stripped of leading and
trailing white space before being handed to the device driver.

Fbdev sysfs attributes are also broken for white space handling and
need to be fixed. Overall the patch should be correct and it is the
drivers that are broken.

-- 
Jon Smirl
jonsmirl@gmail.com
