Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750877AbWG0Am0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbWG0Am0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 20:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751127AbWG0Am0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 20:42:26 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:43748 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750877AbWG0Am0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 20:42:26 -0400
Date: Thu, 27 Jul 2006 02:42:20 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Fwd: Using select in boolean dependents of a tristate symbol
In-Reply-To: <d120d5000607191317k2e773af3ta5034a37db5ad97d@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0607270225540.6761@scrub.home>
References: <d120d5000607131232i74dfdb9t1a132dfc5dd32bc4@mail.gmail.com> 
 <d120d5000607131235r5cc9b558xfd04a1f3118d8124@mail.gmail.com> 
 <Pine.LNX.4.64.0607140033030.12900@scrub.home>  <200607132231.46776.dtor@insightbb.com>
  <Pine.LNX.4.64.0607141115010.12900@scrub.home>
 <d120d5000607191317k2e773af3ta5034a37db5ad97d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 19 Jul 2006, Dmitry Torokhov wrote:

> Another question for you  - what is the best way to describe
> dependancy of a sub-option on a subsystem so you won't end up with the
> subsystem as a module and user built in. Something like
> 
> config IBM_ASM
>        tristate "Device driver for IBM RSA service processor"
>        depends on X86 && PCI && EXPERIMENTAL
> ...
> config IBM_ASM_INPUT
>        bool "Support for remote keyboard/mouse"
>        depends on IBM_ASM && (INPUT=y || INPUT=IMB_ASM)
> 
> But the above feels yucky. Could we have something like:
> 
>         depends on matching(INPUT, IBM_ASM)

This is not really descriptive of what it does, is it?
Linus suggested a syntax like (IBM_ASM && IMB_ASM<=INPUT)
Another alternative which works now is to just disable the one invalid 
case explicitely:

	depends on IBM_ASM && INPUT
	depends on !(IBM_ASM=y && INPUT=m)

bye, Roman
