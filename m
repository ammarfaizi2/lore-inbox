Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268445AbUI2Nj2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268445AbUI2Nj2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 09:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268283AbUI2NjH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 09:39:07 -0400
Received: from styx.suse.cz ([82.119.242.94]:43395 "EHLO shadow.suse.cz")
	by vger.kernel.org with ESMTP id S268430AbUI2Ni2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 09:38:28 -0400
Date: Wed, 29 Sep 2004 15:38:59 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 7/8] Psmouse - add packet size
Message-ID: <20040929133859.GA3896@ucw.cz>
References: <200409290140.53350.dtor_core@ameritech.net> <200409290229.28652.dtor_core@ameritech.net> <20040929093103.GB3150@ucw.cz> <200409290824.59004.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200409290824.59004.dtor_core@ameritech.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 29, 2004 at 08:24:58AM -0500, Dmitry Torokhov wrote:
 
> I have been battling with myself about whether to keep them consistent
> with probe/init or make them as they are today... My issue with
> *detect returning -1 on failure is that the caller's code will look
> like:
> 
>         if (max_proto >= PSMOUSE_IMPS && !intellimouse_detect(psmouse, set_properties))
>                 return PSMOUSE_IMPS;
> 
> or 
> 
>         if (max_proto >= PSMOUSE_IMPS && intellimouse_detect(psmouse, set_properties) == 0)
>                 return PSMOUSE_IMPS;
> 
> which does not flow for me when I read the code. With pretty much every
> other function caller checks for negative and exits in case of error, it
> reads naturally as well. Here with multiple btanches I go "... and
> intellimouse is NOT detected... oh, wait, it IS detected..."

Well, yeah. I kinda got used to that reversed logic after a while.

> Oh, well. I guess I will convert them... unless I managed to presuade you
> to keep them as is ;).

Well, I understand your point, but I still think it's worth keeping the
return values consistent with the rest of the probe routines, because if
not, THEN you (or some other reader) would get used to the
positive-style returns with the protocol detection routines and
definitely understand it wrong elsewhere.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
