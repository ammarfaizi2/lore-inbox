Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267096AbSLKJsB>; Wed, 11 Dec 2002 04:48:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267097AbSLKJsB>; Wed, 11 Dec 2002 04:48:01 -0500
Received: from willow.compass.com.ph ([202.70.96.38]:43012 "EHLO
	willow.compass.com.ph") by vger.kernel.org with ESMTP
	id <S267096AbSLKJsA>; Wed, 11 Dec 2002 04:48:00 -0500
Subject: Re: [Linux-fbdev-devel] Re: atyfb in 2.5.51
From: Antonino Daplas <adaplas@pol.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>,
       James Simmons <jsimmons@infradead.org>
In-Reply-To: <1039561870.538.28.camel@zion>
References: <15862.27438.787187.93003@argo.ozlabs.ibm.com> 
	<1039561870.538.28.camel@zion>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1039610834.1084.106.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 17:49:35 +0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 04:11, Benjamin Herrenschmidt wrote:
> 
> I don't know if happened with earlier fbdev versions for you, but one
> possibility is that X reconfigures the display base, and possibly more
> bits of the card's internal memory map. Either fbdev should restore
> that, or adapt to what X set. On R128's and radeon's, this is things
> like DISPLAY_BASE_ADDR.
>  
Although this is in the faqs for a long time, (behavior is undefined if
fbdev is used with software that touches the video card) this is an
issue that needs to be taken into consideration.  Without the set_var()
hook, fbcon will depend on the contents of info->var if there is a need
to touch the hardware or not.  And switching from X to the console will
not change the var, but since X actually did touch the hardware, you
just messed up your screen or worse, crashed the hardware.

Before, most drivers just unconditionally refresh the hardware at every
switch  during set_var(). I've been pointing this out for a long time
now, do we unconditionally do a check_var()/set_par() after every
console switch, or do we rely on fbdev and X cooperating with each
other? Or better, maybe fbcon has a way of knowing if the switch came
from  Xfree86.

Tony

