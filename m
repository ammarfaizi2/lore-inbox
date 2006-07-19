Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030286AbWGSUu7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030286AbWGSUu7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 16:50:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030306AbWGSUu7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 16:50:59 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:37462 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030286AbWGSUu7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 16:50:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MTNNBeUDjUbS7xOAZ8INkPQIIqctEWvPDZLDKfCF8SzAdCgaUkYczD8sWTkSPIcEDVcey+SBZMtjjOA/BD5xnS3Uon6O+/jJjGTvbACyhLnEfDis7+IGjWC8auXqYUxEhsvhtznFWs14e2znsBsBeGo7YWp/cwyx5XDOnVW1A3w=
Message-ID: <d120d5000607191350u6856b63etba9ffc353632a360@mail.gmail.com>
Date: Wed, 19 Jul 2006 16:50:56 -0400
From: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: Fwd: Using select in boolean dependents of a tristate symbol
Cc: "Roman Zippel" <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
In-Reply-To: <200607192041.k6JKfK6u005519@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d120d5000607131232i74dfdb9t1a132dfc5dd32bc4@mail.gmail.com>
	 <d120d5000607131235r5cc9b558xfd04a1f3118d8124@mail.gmail.com>
	 <Pine.LNX.4.64.0607140033030.12900@scrub.home>
	 <200607132231.46776.dtor@insightbb.com>
	 <Pine.LNX.4.64.0607141115010.12900@scrub.home>
	 <d120d5000607191317k2e773af3ta5034a37db5ad97d@mail.gmail.com>
	 <200607192041.k6JKfK6u005519@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/06, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Wed, 19 Jul 2006 16:17:38 EDT, Dmitry Torokhov said:
>
> > Another question for you  - what is the best way to describe
> > dependancy of a sub-option on a subsystem so you won't end up with the
> > subsystem as a module and user built in. Something like
> >
> > config IBM_ASM
> >         tristate "Device driver for IBM RSA service processor"
> >         depends on X86 && PCI && EXPERIMENTAL
> > ...
> > config IBM_ASM_INPUT
> >         bool "Support for remote keyboard/mouse"
> >         depends on IBM_ASM && (INPUT=y || INPUT=IMB_ASM)
> >
> > But the above feels yucky. Could we have something like:
> >
> >          depends on matching(INPUT, IBM_ASM)
>
> What feels yucky is the dependency of a 'bool' on a tristate.  Does the
> ASM_INPUT get used in places where the source file can only be a builtin,
> not a module?
>

In this case ASM_INPUT enables an optional part of a bigger module
(IBM_ASM). Sometimes it is done because optional part is too small to
be split into a separately loadable module or because it is difficult
to implement "attaching" of the optional part at the later time if it
is compiled as a module.

-- 
Dmitry
