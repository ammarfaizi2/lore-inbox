Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262547AbTCIRLR>; Sun, 9 Mar 2003 12:11:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262548AbTCIRLR>; Sun, 9 Mar 2003 12:11:17 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:12049 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S262547AbTCIRLN>; Sun, 9 Mar 2003 12:11:13 -0500
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA aic7770 broken
References: <wrp65qscwxx.fsf@hina.wild-wind.fr.eu.org>
	<229560000.1047229710@aslan.scsiguy.com>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 09 Mar 2003 18:20:05 +0100
Message-ID: <wrp1y1gcv96.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <229560000.1047229710@aslan.scsiguy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Justin" == Justin T Gibbs <gibbs@scsiguy.com> writes:

Justin> Take a look in kernel/resource.c.  request_region returns
Justin> *non-zero* if the region is already in use.  The driver
Justin> doesn't want to try and probe a region that is in use by
Justin> another device. Your patch is incorrect.

request_region returns a pointer to the newly allocated resource when
it succeds, and NULL when it failed. It's the opposite logic
check_region uses.

Or am I *that* blind ?

Without this patch, the driver happily requests all EISA IO space, and
exits without any probing.

>> But the driver crashes badly while probing the card, somewhere in
>> ahc_runq_tasklet.
>> 
>> Any idea ?

Justin> Not without more information.

Ok, what can I do ?

System is a dual PII-300, with two integrated PCI AIC-7xxx.
Moreover, I have one 1740 and one 2740, which crashes at probe time.

Is there any trace you want me to put in ?

Thanks,

        M.
-- 
Places change, faces change. Life is so very strange.
