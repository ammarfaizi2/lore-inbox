Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268278AbUI2JgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268278AbUI2JgV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 05:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268280AbUI2JgV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 05:36:21 -0400
Received: from 217-114-210-112.kunde.vdserver.de ([217.114.210.112]:61705 "EHLO
	old-fsckful.ath.cx") by vger.kernel.org with ESMTP id S268278AbUI2JgT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 05:36:19 -0400
Date: Wed, 29 Sep 2004 11:36:13 +0200
From: Andreas Happe <andreashappe@flatline.ath.cx>
To: Michal Ludvig <michal@logix.cz>
Cc: James Morris <jmorris@redhat.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, Andreas Happe <crow@old-fsckful.ath.cx>
Subject: Re: [cryptoapi/sysfs] display cipher details in sysfs
Message-ID: <20040929093613.GB3969@final-judgement.ath.cx>
References: <20040831175449.GA2946@final-judgement.ath.cx> <Xine.LNX.4.44.0409010043020.30561-100000@thoron.boston.redhat.com> <20040901082819.GA2489@final-judgement.ath.cx> <Pine.LNX.4.53.0409061847000.25698@maxipes.logix.cz> <20040907143509.GA30920@old-fsckful.ath.cx> <Pine.LNX.4.53.0409071659070.19015@maxipes.logix.cz> <20040910105502.GA4663@final-judgement.ath.cx> <20040927084149.GA3625@final-judgement.ath.cx> <Pine.LNX.4.53.0409271046280.12238@maxipes.logix.cz> <20040928123426.GA21069@final-judgement.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20040928123426.GA21069@final-judgement.ath.cx>
X-Request-PGP: subkeys.pgp.net
X-Hangover: none
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

just took a glance at preferences for algorithms yesterday. came up with
the attached code (does compile, don't think that it will boot, just
attached to illustrade my thinkings).

I inserted a cra_family list into cra_alg which stores all algorithms
which share the same name but different module names. When selecting an
algorithm the preference is looked after (it should be made a writeable
sysfs attribute - would make runtime user selection of prefered
algorithm very intuitive).

Main problems are removal of algorithms (havn't covered that yet) and
the display of different algorithms with same names in sysfs as cra_name
is the name of the directory (not module_name(alg->cra_module)).

Creating a hierarchie cra_alg <>- cra_implementation would be the most
clean solution. Just add a kset with the different cra_implementations
(which would contain a kobject, preference, module pointer) to any
given algorithm (which would contain all blocksize, blah data).

	--Andreas
