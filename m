Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268372AbUI2OPy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268372AbUI2OPy (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 10:15:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268486AbUI2OPy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 10:15:54 -0400
Received: from maxipes.logix.cz ([81.0.234.97]:10946 "EHLO maxipes.logix.cz")
	by vger.kernel.org with ESMTP id S268447AbUI2ON0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 10:13:26 -0400
Date: Wed, 29 Sep 2004 16:13:25 +0200 (CEST)
From: Michal Ludvig <michal@logix.cz>
To: Andreas Happe <andreashappe@flatline.ath.cx>
Cc: James Morris <jmorris@redhat.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, Andreas Happe <crow@old-fsckful.ath.cx>
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
In-Reply-To: <20040929093613.GB3969@final-judgement.ath.cx>
Message-ID: <Pine.LNX.4.53.0409291602060.24379@maxipes.logix.cz>
References: <20040831175449.GA2946@final-judgement.ath.cx>
 <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com>
 <20040901082819.GA2489@final-judgement.ath.cx> <Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz>
 <20040907143509.GA30920@old-fsckful.ath.cx> <Pine.LNX.4.53.0409071659070.19015@maxipes.logix.cz>
 <20040910105502.GA4663@final-judgement.ath.cx> <20040927084149.GA3625@final-judgement.ath.cx>
 <Pine.LNX.4.53.0409271046280.12238@maxipes.logix.cz>
 <20040928123426.GA21069@final-judgement.ath.cx> <20040929093613.GB3969@final-judgement.ath.cx>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Sep 2004, Andreas Happe wrote:

> just took a glance at preferences for algorithms yesterday. came up with
> the attached code (does compile, don't think that it will boot, just
> attached to illustrade my thinkings).

I'll give it a try and read something more about kobjects and ksets as
well ;-)

> I inserted a cra_family list into cra_alg which stores all algorithms
> which share the same name but different module names. When selecting an
> algorithm the preference is looked after (it should be made a writeable
> sysfs attribute - would make runtime user selection of prefered
> algorithm very intuitive).

For now it could be a module option or even hardcoded in the .ko. It won't
be user-writable anyway, only root-writable. And if root wouldn't want to
use the most preferred module, he could simply not load it...

The reason why I wanted the cra_preference is a situation where a given
functionality is non-modular and compiled into the kernel and requires an
algorithm thet in turn will have to be compiled in as well. Distributors
would of course select the pure software implementation for this. But then
you install a cryptocard - without preferences you couldn't load a module
with driver for it.

> Main problems are removal of algorithms (havn't covered that yet) and
> the display of different algorithms with same names in sysfs as cra_name
> is the name of the directory (not module_name(alg->cra_module)).
>
> Creating a hierarchie cra_alg <>- cra_implementation would be the most
> clean solution. Just add a kset with the different cra_implementations
> (which would contain a kobject, preference, module pointer) to any
> given algorithm (which would contain all blocksize, blah data).

Michal Ludvig
-- 
* A mouse is a device used to point at the xterm you want to type in.
* Personal homepage - http://www.logix.cz/michal
