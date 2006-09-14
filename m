Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750699AbWINCAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750699AbWINCAx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 22:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750701AbWINCAx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 22:00:53 -0400
Received: from gateway.insightbb.com ([74.128.0.19]:7686 "EHLO
	asav01.insightbb.com") by vger.kernel.org with ESMTP
	id S1750699AbWINCAx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 22:00:53 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AR4FAF5UCEWBTooTLA
From: Dmitry Torokhov <dtor@insightbb.com>
To: Jiri Kosina <jikos@jikos.cz>
Subject: Re: [PATCH 0/3] Synaptics - fix lockdep warnings
Date: Wed, 13 Sep 2006 22:00:50 -0400
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Arjan van de Ven <arjan@infradead.org>, Dave Jones <davej@redhat.com>
References: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
In-Reply-To: <Pine.LNX.4.64.0609140227500.22181@twin.jikos.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200609132200.51342.dtor@insightbb.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,

On Wednesday 13 September 2006 20:44, Jiri Kosina wrote:
> Both warnings have been solved by splitting the respective functions to 
> nested and non-nested variants, and calling them from synpatics driver as 
> appropriate.
>  

Unfortunately these patches do not solve the problem in general but
rather fix one specific codepath. As far as I can see the warnings will
return as soon as we add another pass-through port to the link (and I am
considering adding a pass-through port to the trackpoint driver so you
will get chain like i8042-synaptics-ptport-trackpoint-ptport-psmouse).

Plus they are ugly and complicate serio and psmouse cores. I really
don't like this *_nested business as it makes the code aware of possible
usage patterns instead of just being re-entrant.

-- 
Dmitry
