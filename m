Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264489AbTFLGds (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 02:33:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264744AbTFLGds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 02:33:48 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:17105 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id S264489AbTFLGdq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 02:33:46 -0400
Date: Thu, 12 Jun 2003 08:47:26 +0200
From: Vojtech Pavlik <vojtech@ucw.cz>
To: =?iso-8859-2?Q?Mika_Penttil=E4?= <mika.penttila@kolumbus.fi>
Cc: "Bryan O'Sullivan" <bos@serpentine.com>, ak@suse.de, vojtech@suse.cz,
       discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] New x86_64 time code for 2.5.70
Message-ID: <20030612084726.D12126@ucw.cz>
References: <1055357432.17154.77.camel@serpentine.internal.keyresearch.com> <3EE79FD1.8060503@kolumbus.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <3EE79FD1.8060503@kolumbus.fi>; from mika.penttila@kolumbus.fi on Thu, Jun 12, 2003 at 12:32:01AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 12, 2003 at 12:32:01AM +0300, Mika Penttilä wrote:
> /*
> + * Read the period, compute tick and quotient.
> + */
> +
> +	id = hpet_readl(HPET_ID);
> +
> +	if (!(id & HPET_ID_VENDOR) || !(id & HPET_ID_NUMBER) ||
> +	    !(id & HPET_ID_LEGSUP))
> +		return -1;
> +
> +	hpet_period = hpet_readl(HPET_PERIOD);
> +	if (hpet_period < 100000 || hpet_period > 100000000)
> +		return -1;
> +
> 
> 
> Line below seems to be wrong, given hpet period is in fsecs.
> 
> 
> +	hpet_tick = (tick_nsec + hpet_period / 2) / hpet_period;

Yes, it should be:

hpet_tick = (1000000000L * (USECS_PER_SEC/HZ) + hpet_period / 2) / hpet_period;

> 
> 
> 
> 
> 
> --Mika
> 
> 
> 
> 
> 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
