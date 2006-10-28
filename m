Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751803AbWJ1FMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751803AbWJ1FMc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 01:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWJ1FMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 01:12:32 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:48653 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751803AbWJ1FMb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 01:12:31 -0400
Date: Sat, 28 Oct 2006 05:12:16 +0000
From: Pavel Machek <pavel@ucw.cz>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Richard Hughes <hughsient@gmail.com>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       David Zeuthen <davidz@redhat.com>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061028051215.GA4058@ucw.cz>
References: <1161628327.19446.391.camel@pmac.infradead.org> <1161631091.16366.0.camel@localhost.localdomain> <1161633509.4994.16.camel@hughsie-laptop> <1161636514.27622.30.camel@shinybook.infradead.org> <1161710328.17816.10.camel@hughsie-laptop> <1161762158.27622.72.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1161762158.27622.72.camel@shinybook.infradead.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I haven't (yet) changed from a single 'status' file to multiple
> 'is_flag_0' 'is_flag_1' 'is_flag_2' files. I really don't like that idea
> much -- it doesn't seem any more sensible than exposing each bit of the
> voltage value through a separate file. These flags are _read_ together,
> and _used_ together. I'd rather show it as a hex value 'flags' than
> split it up. But I still think that the current 'present,charging,low'
> is best.

Please do this change. sysfs *is* one file per value.. if at least to
be consistent with rest of code.

> @@ -0,0 +1,177 @@
> +/*
> + * Battery class core
> + *
> + *	?? 2006 David Woodhouse <dwmw2@infradead.org>
> + *
> + * Based on LED Class support, by John Lenz and Richard Purdie:
> + *
> + *	?? 2005 John Lenz <lenz@cs.wisc.edu>
> + *	?? 2005-2006 Richard Purdie <rpurdie@openedhand.com>

Could we get something ascii here? I'm not sure what you see instead
of copyright... but I see ??. I could not find it in source, but if
you use non-ascii character in file, please fix that, too.

> +ssize_t battery_attribute_show_ac_status(char *buf, unsigned long status)
> +{
> +	return 1 + sprintf(buf, "o%s-line\n", status?"n":"ff");
> +}  

I guess ac_online should show 0/1...

> +	if (unlikely(err))
> +		return err;
> +
> +        battery_dev->dev = device_create(battery_class, parent, 0,

space/tab problem?


-- 
Thanks for all the (sleeping) penguins.
