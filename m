Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264584AbTK0TEA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 14:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264590AbTK0TEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 14:04:00 -0500
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:23813 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S264584AbTK0TD5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 14:03:57 -0500
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: file2alias for pnp (Re: modules.pnpmap output support)
Date: Thu, 27 Nov 2003 21:58:58 +0300
User-Agent: KMail/1.5.3
Cc: rusty@rustcorp.com.au, ambx1@neo.rr.com, linux-kernel@vger.kernel.org
References: <s5hoevbjdjj.wl@alsa2.suse.de> <s5h65hf1iou.wl@alsa2.suse.de> <s5hn0ahdgbm.wl@alsa2.suse.de>
In-Reply-To: <s5hn0ahdgbm.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200311272159.00184.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 November 2003 17:41, Takashi Iwai wrote:
> Hi,
>
> the attached is the patch to add pnp entries to file2alias.c.
> i moved the definitions of pnp_device_id and pnp_card_device_id into
> mod_devicetable.h as other devices do.  if you don't like it, i'll try
> to revert them and put definitions inside file2alias.c to keep the
> changes minimum.
>
> the format of pnp alias is:
> 	pnp:dXXXYYYY
> or
> 	pnp:cXXXYYYYdXXXYYYY[dXXXYYYY...]
> where XXXYYYY is the pnp id with 7 letters (e.g. CTL0031), c shows the
> card id, and d means the device id.  multiple device ids will be
> listed depending on the driver.
>
> for example,
>
> 	alias pnp:dYMH0021* opl3sa2
> 	alias pnp:cALS0001d@@@0001d@X@0001d@H@0001* snd_als100
>
> Andrey, would it be feasible for hotplug stuff?
>

Will then every d be passed as separate parameter to hotplug? It means agent 
has to deal with unknown number of parameters or are there always fixed 
number of devs? apparently not as max is 8 and in your example only 3 are 
defined.

If number is variable I guess better would be

	alias pnp:cXXXXXXdYYYYYYY[:YYYYYY...]

i.e. put all devs IDs in one field; actually may be even separator is 
redundant as IDs have strict format to my knowledge.

Then hotplug agent gets two parameters - PNPID and PNPDEVS - and it is quite 
easy to build alias.

can you give example how entries in sysfs look like (I do not have any ISA 
card). Is it possible to list them in the same order as in pnp_card_device_id 
table? Otherwise coldplugging becomes quite complicated. coldplugging script 
has to build the same string as hotplug invocation gets.

Oh, BTW, what are those `@' in your example? If they mean single char 
wildcard, you should build them using `?' because modprobe is using normal 
fnmatch to match module name against aliases.

thank you

-andrey

