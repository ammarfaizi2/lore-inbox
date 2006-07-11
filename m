Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750919AbWGKOnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbWGKOnJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 10:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750929AbWGKOnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 10:43:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:20111 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750919AbWGKOnH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 10:43:07 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=O+giu2m3l73GJNl1N33HHxws/S2Ei7IPnCvNZv5UkEIWfY+0b7+fhq8TsF/nCjICL7MEjuEiIQwJ/vXj3Byc79wk3BxAopc3JI0krjgt9Auwu85VxZM+ClYzbjYI6ZY59WdGHw/zlEI7KPJeqAIEmpMn2hvC2dz8t9ey7xC0THo=
Message-ID: <9e4733910607110743w29573c02h981324a110adba11@mail.gmail.com>
Date: Tue, 11 Jul 2006 10:43:05 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Antonino A. Daplas" <adaplas@gmail.com>
Subject: Re: [PATCH] fbdev: Statically link the framebuffer notification functions
Cc: "Andrew Morton" <akpm@osdl.org>, rdunlap@xenotime.net, mreuther@umich.edu,
       linux-kernel@vger.kernel.org, zap@homelink.ru
In-Reply-To: <44B3B6ED.9020705@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200607100833.00461.mreuther@umich.edu>
	 <200607102327.38426.mreuther@umich.edu>
	 <20060710215253.1fcaab57.rdunlap@xenotime.net>
	 <44B34D68.3080602@gmail.com> <20060711032817.94c78ae0.akpm@osdl.org>
	 <44B39D4D.8060209@gmail.com>
	 <9e4733910607110621i720db936sebdd0bcb60fab4ad@mail.gmail.com>
	 <44B3AA51.1040003@gmail.com>
	 <9e4733910607110646m7f95581cl52669daddf5f2fa1@mail.gmail.com>
	 <44B3B6ED.9020705@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> Jon Smirl wrote:
> > On 7/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> Jon Smirl wrote:
> >> > On 7/11/06, Antonino A. Daplas <adaplas@gmail.com> wrote:
> >> >> The backlight and lcd subsystems can be notified by the framebuffer
> >> layer
> >> >> of blanking events.  However, these subsystems, as a whole, can
> >> function
> >> >> independently from the framebuffer layer. But in order to enable to
> >> >> the lcd and backlight subsystems, the framebuffer has to be compiled
> >> >> also,
> >> >> effectively sucking in a huge amount of unneeded code. Besides, the
> >> >> dependency
> >> >> is introducing a lot of compilation problems.
> >> >
> >> > This code is effectively rebuilding a fb specific version of
> >> > inter_module_get/put., something that was removed earlier.
> >>
> >> Huh? I don't see any semblance of inter_module_* or symbol_* in there.
> >> Read the patch again.
> >
> > You are providing a fixed point to do a rendezvous between modules
> > without refcount tracking. That's what inter_module did.
>
> No, you're confused on inter_module. inter_module_* allows 2 or more
> modules to share data. The danger is that one module may disappear
> while the other is still accessing the data.
>
> In this case, there is absolutely no data sharing. One module can
> safely unload without affecting the other. The only danger is
> that one might be in a midst of a calling the callout function while
> the other is unregistering its notifier block. But then the notifier
> chain already protects this from happening.

The code looks ok but this sure smells like inter_module_*. I guess
inter_module had to deal with arbitrary users and this code is dealing
with a fixed set of clients which makes it more manageable.

Have you considered making this a generic service and not fb specific?

-- 
Jon Smirl
jonsmirl@gmail.com
