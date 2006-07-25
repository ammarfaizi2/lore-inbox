Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbWGYJuw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWGYJuw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 05:50:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751544AbWGYJuw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 05:50:52 -0400
Received: from ezoffice.mandriva.com ([84.14.106.134]:50188 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP
	id S1751542AbWGYJuv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 05:50:51 -0400
From: Arnaud Patard <apatard@mandriva.com>
To: Greg KH <gregkh@suse.de>, Andrew de Quincey <adq_dvb@lidskialf.net>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: Linux 2.6.17.7
Organization: Mandriva
References: <20060725034247.GA5837@kroah.com>
Date: Tue, 25 Jul 2006 11:55:05 +0200
In-Reply-To: <20060725034247.GA5837@kroah.com> (Greg KH's message of "Mon, 24
	Jul 2006 20:42:47 -0700")
Message-ID: <m33bcqdn5y.fsf@anduin.mandriva.com>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH <gregkh@suse.de> writes:

Hi,

> We (the -stable team) are announcing the release of the 2.6.17.7 kernel.

Sorry, but doesn't compile if DVB_BUDGET_AV is set :(


> Andrew de Quincey:
>       v4l/dvb: Fix budget-av frontend detection
>       v4l/dvb: Fix CI on old KNC1 DVBC cards

This patch is the culprit. With it, the build fails with the errors : 
drivers/media/dvb/ttpci/budget-av.c: In function 'frontend_init':
drivers/media/dvb/ttpci/budget-av.c:1063: error: 'struct budget_av' has no member named 'reinitialise_demod'
drivers/media/dvb/ttpci/budget-av.c:1068: error: request for member tuner_ops' in something not a structure or union
drivers/media/dvb/ttpci/budget-av.c:1068: error: 'philips_cu1216_tuner_set_params' undeclared (first use in this function)
drivers/media/dvb/ttpci/budget-av.c:1068: error: (Each undeclared identifier is reported only once
drivers/media/dvb/ttpci/budget-av.c:1068: error: for each function it appears in.)

The needed changes were introduced post 2.6.17 :
5c1208ba457a1668c81868060c08496a2d053be0
7eef5dd6daecf3ee305116c9cf41ae7166270c4c
e87d41c4952ceef7a9f760f38f9343d015279662

This would be great to see this fixed for the next -stable release :)

Regards,
Arnaud Patard

