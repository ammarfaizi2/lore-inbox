Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261227AbVBMBFa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261227AbVBMBFa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Feb 2005 20:05:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVBMBFa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Feb 2005 20:05:30 -0500
Received: from rproxy.gmail.com ([64.233.170.204]:1946 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261227AbVBMBFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Feb 2005 20:05:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=HsydXXo19O1l29t853/vWAhr4bNxCPYZOVfuva6LCzrI4jZKKfWKs0D5flSYDPFmn6hgeN8AHTe4oW9Slrcke9TDM8S/JhlK0rwQ/d+hnujkIhinrTpZ2hKI0HTdy0tcTgOmWyaXUcFn3MpnyUU7sZbA+Jeo0P19Vvv0JzxDDGc=
Message-ID: <5a4c581d0502121705276972a@mail.gmail.com>
Date: Sun, 13 Feb 2005 02:05:21 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
Reply-To: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.11-rc3-bk9 (radeon) hangs hard my laptop
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1108293146.6700.10.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <5a4c581d0502120649423a2504@mail.gmail.com>
	 <5a4c581d05021207593fae0c93@mail.gmail.com>
	 <5a4c581d050212135716fa6a17@mail.gmail.com>
	 <1108291975.6698.7.camel@gaston>
	 <5a4c581d05021216095ec00bf9@mail.gmail.com>
	 <1108293146.6700.10.camel@gaston>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 13 Feb 2005 22:12:26 +1100, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Sun, 2005-02-13 at 01:09 +0100, Alessandro Suardi wrote:
> > On Sun, 13 Feb 2005 21:52:55 +1100, Benjamin Herrenschmidt
> > <benh@kernel.crashing.org> wrote:
> > >
> > > > It's definitely the new radeon changes - replacing
> > > >  drivers/video/aty/* and include/video/radeon.h in the
> > > >  -bk9 tree with the ones from -bk8 causes the hang to
> > > >  not reproduce anymore. CC'd Ben and edited subject
> > > >  to more accurately reflect the issue.
> > >
> > > Grrr...
> > >
> > > Can you try booting with radeonfb.default_dynclk=-1 and if it doesn't
> > > help, radeonfb.default_dynclk=0 on the kernel command line ?
> >
> > I'm currently booted with -bk9 with default_dynclk = -1 :)
> 
> Excellent. You can help me track it down then. Can you look at
> radeon_pm.c, function
> 
> radeon_pm_enable_dynamic_mode()
> 
> The code for your chip is after the comment "/* Others */" (the M7 is an
> RV200 chip). Can you comment out the various bits in there and see if
> you can locate which one is causing your problem ?

Commenting out pllCLK_PWRMGT_CNTL alone -> still hangs
Commenting out pllCLK_PIN_CNTL in addition -> works
 
Do you want me to build a kernel with only the pllCLK_PIN_CNTL
 instruction commented out or is this enough info ?

Thanks,

--alessandro

  "There is no distance that I don't see
  I do have a will - No limit to my reach"
  
    (Wallflowers, "Empire In My Mind")
