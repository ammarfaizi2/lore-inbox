Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbTIKUnp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 16:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbTIKUmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 16:42:16 -0400
Received: from lidskialf.net ([62.3.233.115]:17127 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S261530AbTIKUln convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 16:41:43 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: jbarnes@sgi.com (Jesse Barnes)
Subject: Re: [PATCH] deal with lack of acpi prt entries gracefully
Date: Thu, 11 Sep 2003 21:40:08 +0100
User-Agent: KMail/1.5.3
Cc: andrew.grover@intel.com, linux-kernel@vger.kernel.org
References: <20030909201310.GB6949@sgi.com> <200309102230.29794.adq_dvb@lidskialf.net> <20030910213821.GA17356@sgi.com>
In-Reply-To: <20030910213821.GA17356@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200309112140.08967.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 Sep 2003 10:38 pm, Jesse Barnes wrote:
> On Wed, Sep 10, 2003 at 10:30:29PM +0100, Andrew de Quincey wrote:
> > So, exactly as your patch did, you just want it to drop back if there
> > were no PCI routing entries found by ACPI... sounds sensible enough.
> >
> > Can you confirm I have this right?
>
> Yep, that's it.  The code should do that, but we get there before the
> list has been initialized, so we just hang.

I'm not sure if this is automatically fixed or not yet.

With the new patch:

1) If ACPI fails to parse a table, it disables ACPI, and so disables any 
attempt to use ACPI for PRT routing.

2) If ACPI is enabled, and enters the function you patched, code further in 
checks if the routing tables have any entries. If not, it rejects the 
attempt.

>From your patch, I get the impression (1) is what you were patching for.. am I 
right? In that case, there shouldn't be a problem.

