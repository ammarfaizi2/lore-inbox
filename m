Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161000AbWGUGyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161000AbWGUGyw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jul 2006 02:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWGUGyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jul 2006 02:54:51 -0400
Received: from mail.suse.de ([195.135.220.2]:45753 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030436AbWGUGyv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jul 2006 02:54:51 -0400
Message-ID: <44C07A39.9040309@suse.de>
Date: Fri, 21 Jul 2006 08:54:49 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.4 (X11/20060527)
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
Cc: Kalev Lember <kalev@smartlink.ee>, linux-kernel@vger.kernel.org
Subject: Re: kexec and framebuffer
References: <44BB9A7A.4060100@smartlink.ee> <44BB9EB3.9020101@suse.de> <44BFEAA5.5030703@smartlink.ee> <44C011B3.3060900@gmail.com>
In-Reply-To: <44C011B3.3060900@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> Kalev Lember wrote:
>> Thank you, this was really helpful.
>>> +	if (0 != strcmp(fix.id, "vesafb"))
>>> +		goto out;
>> I think this check should be removed so that other framebuffer drivers
>> besides vesafb would also work.
> 
> I think having the check is correct, only vesafb relies totally on
> screen_info. If you remove the check, you can get the wrong information
> from other framebuffer drivers.

Exactly.

>> +	/* fixme: better get size from /proc/iomem */
>> +	real_mode->lfb_size       = (fix.smem_len + 65535) / 65536;
>> +	real_mode->pages          = (fix.smem_len + 4095) / 4096;
> 
> Note that fix.smem_len is the size of the remapped memory which can be
> smaller than the actual framebuffer length. But there's a fixme comment
> there so you probably know about this.

Yep, that is the reason for the fixme.  kexec-tools already parse
/proc/iomem, but keep the info private in some other source file, so I
decided to solve it this way for the first cut.  Shouln't be that hard
to fix it up though.

I've mailed it some time ago to the maintainer, no feedback.  Feel free
to polish the patch a bit and try submitting it again ...

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg
