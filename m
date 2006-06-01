Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751667AbWFACtu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbWFACtu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 May 2006 22:49:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWFACtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 May 2006 22:49:50 -0400
Received: from nz-out-0102.google.com ([64.233.162.192]:27366 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751667AbWFACtu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 May 2006 22:49:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GewVH84YyuZ8ai79iTDEu+38tB7a2YHNkGBcne+D27fDuRPlImiyDcs1yl6v4TVScl7zuIWIhZNOUkxby3q+jbwRxLGpfAepsRhL323Lv6p4GAN9V+Z9BCfW2K5y9Kb5iJQFx678IsQEXqDQG25n+eTYCdno3JvfHHva00XQp98=
Message-ID: <9e4733910605311949v521340ci13659e9c9139719c@mail.gmail.com>
Date: Wed, 31 May 2006 22:49:39 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "D. Hazelton" <dhazelton@enter.net>
Subject: Re: OpenGL-based framebuffer concepts
Cc: "Antonino A. Daplas" <adaplas@gmail.com>,
       "Dave Airlie" <airlied@gmail.com>, "Pavel Machek" <pavel@ucw.cz>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Kyle Moffett" <mrmacman_g4@mac.com>,
       "Manu Abraham" <abraham.manu@gmail.com>,
       "linux cbon" <linuxcbon@yahoo.fr>,
       "Helge Hafting" <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
In-Reply-To: <200605312236.27690.dhazelton@enter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>
	 <447E493E.1090808@gmail.com>
	 <9e4733910605311919x2cd1847cx90b5353cf6b325f6@mail.gmail.com>
	 <200605312236.27690.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/31/06, D. Hazelton <dhazelton@enter.net> wrote:
> As to having seperate devices per user - the only cases this would be really
> required are:
> 1) Multiple users logged onto different VT's
> 2) Remote users doing server-side acceleration of graphics
>
> For #1 there is no need for seperate devices, since both users are using the
> same display and input methods (unless configured different - say with
> multiple heads and input devices, in which case the second head would already
> have a node available for it).

WIth multiple users logged into each head the heads need to be
controlled independently. One user might set text mode and the other
1024x768 graphics. The IOCTL will need to list the different modes
available for each monitor. Some matrox cards support three heads so
they get three devices. Things are much simpler if there is one device
node per monitor/head.

This brings up the problem of merged fb support.

1) heads are owned by two different users, no merged fb modes available
2) heads are owned by same user, merged fb modes appear in the mode list
3) if a mode is in the list, then you can set it
4) setting a merged fb mode on one device node will make the other
device node return some kind of error if you try and use it.
5) A head owned by PAM ( no logged in user) functions as a wild card.
If you have control of the other head you can set merged fb mode and
disable PAM.

DRM will need some work to be able to deal with this.

-- 
Jon Smirl
jonsmirl@gmail.com
