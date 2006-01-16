Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750741AbWAPMLc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750741AbWAPMLc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:11:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750740AbWAPMLc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:11:32 -0500
Received: from uproxy.gmail.com ([66.249.92.199]:52367 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750741AbWAPMLb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:11:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cnquonhuc3Qi+FiUHyksqjh8kP6x5bXXv33GjaCyYve7rbAwBWm8dZj40YGatavnWHZ8mHbKgGZRTk6CtlYAMsYwwchUPUDs96Hg7V3vm2Qd6ADfJ+h+MlbxJto1rXHM+Zn4wBVa15/dQlY9ISVsMvv7GIXhd5+0O+TgRiEWOM4=
Message-ID: <21d7e9970601160411q6c08cd11o9db86efbb9df6f13@mail.gmail.com>
Date: Mon, 16 Jan 2006 23:11:29 +1100
From: Dave Airlie <airlied@gmail.com>
To: Dave Jones <davej@redhat.com>, Dave Airlie <airlied@gmail.com>,
       Andi Kleen <ak@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.15-git breaks Xorg on em64t
In-Reply-To: <20060116063653.GA3112@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060114065235.GA4539@redhat.com> <200601141943.28027.ak@suse.de>
	 <20060114225137.GB23021@redhat.com> <200601150105.08197.ak@suse.de>
	 <20060115070658.GB6454@redhat.com>
	 <21d7e9970601150136m25ef428es139a641e2619997@mail.gmail.com>
	 <20060116063653.GA3112@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  > > Another datapoint btw: I've another EM64T that works just fine.
>  > > The one that fails is the only one that isn't using onboard VGA,
>  > > this one has a PCIE Radeon.  Given it happens when X is starting up,
>  > > it could be that the X radeon driver does something special which
>  > > is why others aren't seeing this.
>  > >
>  >
>  > It might be due to the DRM update that went through, but I can't think
>  > what might have caused it, if you backout the DRM merge does it help
>  > any?
>
> As it turns out, -git11 with all the DRM bits backed out gives me
> a working X again.
>
>  > did the previous kernel have DRM support for that card?
>
> No. This is 1002:5b60 / 1002:5b70 based card.
>
> I had previously missed the 5b60 part in lspci output, so thinking
> there was no 5b70 addition, I hadn't considered this as a suspect.
> Mea Culpa.   Looks like Andi is off the hook :-)
>
> Any ideas for any debugging I can add ?

Disable dri in your xorg.conf first, (remove the Load "dri"), if that
works which it most likely will, then send me an Xorg.0.log, and a drm
debug trace (modprobe drm debug=1),

I'm going to be looking at a 64-bit machine with PCIE radeon in the
next day or two, I'll be getting one myself post LCA more than
likely...

I think more than likely we are hitting a problem where the DRM sets
up the radeon RAM controller and the X server sets it up
differently... benh has fixes for this but they need to go into the X
server driver....

Dave.

>
>                 Dave
>
>
