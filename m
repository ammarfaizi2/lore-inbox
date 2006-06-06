Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWFFV4z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWFFV4z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jun 2006 17:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWFFV4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jun 2006 17:56:55 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:64175 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S1751188AbWFFV4y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jun 2006 17:56:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fIttNXY1X7xCA8346YQFM8KPvwxJZnjN0st3CbcmROPXC5CqXzy/l5hoPTHO5vbcWG1YTBIgElP2z/DRvH+pVzUrlblj3Vr+XYYbgG0j9hBmaWxrVfBuNJl/ePC2k8eC37VFexMACkTa9LhTYeF3F9je0BEsoWXPFYyEP/5ILtI=
Message-ID: <9e4733910606061455l2ab3a217q431a90a6c3555813@mail.gmail.com>
Date: Tue, 6 Jun 2006 17:55:37 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Dave Airlie" <airlied@gmail.com>
Subject: Re: [PATCH 0/7] Detaching fbcon
Cc: "Antonino A. Daplas" <adaplas@gmail.com>, "Andrew Morton" <akpm@osdl.org>,
       "Linux Fbdev development list" 
	<linux-fbdev-devel@lists.sourceforge.net>,
       "Linux Kernel Development" <linux-kernel@vger.kernel.org>
In-Reply-To: <21d7e9970606061439m6e914bf8ya5567b672d5e14bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44856223.9010606@gmail.com>
	 <9e4733910606060910m44cd4edfs8155c1fe031b37fe@mail.gmail.com>
	 <9e4733910606060919p2a137e07wd58b51a227f5aa5e@mail.gmail.com>
	 <4485DB6C.704@gmail.com>
	 <9e4733910606061400i172d20a7qa9583b9b9245f6f9@mail.gmail.com>
	 <21d7e9970606061439m6e914bf8ya5567b672d5e14bb@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/6/06, Dave Airlie <airlied@gmail.com> wrote:
> > > >
> > How is the stack maintained of what was previously bound to console?
> > What if I unbind fbcon on a system that doesn't have VGAcon for a backup?
>
> You could try actually reading the patches...

I was working on a patch for this but now I've lost interest.

Detach should be an attribute off from /dev/console. /dev/console is
using the standard device support and appears at
/sys/class/tty/console so /sys/class/tty/console/detach can be added
as an attribute. /sys/class/tty/console could have another attribute
which lists the available drivers. One solution would be for the
attribute to list the names of the available drivers that have
registered with console and then copy one of those names back to the
attribute to select where console is bound.

In my opinion attach/detach does not belong as an attribute on fbcon,
it is part of /dev/console. The fact that fbcon has to ask console to
unbind from it implies these attributes are in the wrong place.

-- 
Jon Smirl
jonsmirl@gmail.com
