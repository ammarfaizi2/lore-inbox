Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263080AbSIPVTe>; Mon, 16 Sep 2002 17:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263082AbSIPVTe>; Mon, 16 Sep 2002 17:19:34 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:24273 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S263080AbSIPVTd> convert rfc822-to-8bit; Mon, 16 Sep 2002 17:19:33 -0400
Content-Type: text/plain; charset=US-ASCII
From: James Cleverdon <jamesclv@us.ibm.com>
Reply-To: jamesclv@us.ibm.com
Organization: IBM xSeries Linux Solutions
To: Dave Jones <davej@suse.de>
Subject: Re: [PATCH] Summit patch for 2.5.34
Date: Mon, 16 Sep 2002 14:24:14 -0700
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com,
       torvalds@transmeta.com, alan@redhat.com, mingo@redhat.com
References: <200209122035.14678.jamesclv@us.ibm.com> <20020916175545.A21875@suse.de>
In-Reply-To: <20020916175545.A21875@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209161424.14865.jamesclv@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 September 2002 08:55 am, Dave Jones wrote:
> On Thu, Sep 12, 2002 at 08:35:14PM -0700, James Cleverdon wrote:
>  > Patch that allows IBM x440 boxes to on-line all CPUs and interrupt
>  > routing for x360s.   Fixed x360 ID bug.
>
> Couple questions/comments.
>
> - Is this the same summit code as is in 2.4-ac ?
>   (Ie, the one that boots on non summit systems too)

Yes, save for the dynamic TPR enhancement.  (Already addressed by Alan, etc, 
in other postings.)

> - I believe the way forward here is to work with James Bottomley,
>   who has a nice abstraction of the areas your patch touches for
>   his Voyager sub-architecture.
>   Linus has however been completley silent on the x86-subarch idea
>   despite heavyweights like Alan and Ingo adding their support...
>   If you go this route, James' base needs to go in first
>   (converting just the in-kernel visws support). After which, adding
>   support for Voyager, Summit and any other wacky x86esque hardware
>   is a simple non-intrusive patch that touches subarch specific areas.
> - Some of the code you've added looks along the lines of..
>
>    if (numaq)
>       foo();
>    else if (summit)
>       foo2();
>    else
>       foo3();
>
>   Would it be over-abstracting to have some form of APIC struct,
>   defining pointers to various routines instead of lots of ugly
>   if's/switches/fall-through's.
>
> However, the last point may be completley pointless after adapting to
> use what James B has come up with..
>
>         Dave

All the if/else chains are in init code, where a few more microseconds for 
some extra branches isn't important.  However, a nice sub-arch abstraction 
would be welcome.

Thanks!

-- 
James Cleverdon
IBM xSeries Linux Solutions
{jamesclv(Unix, preferred), cleverdj(Notes)} at us dot ibm dot com

