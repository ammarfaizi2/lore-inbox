Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWHGPNK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWHGPNK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWHGPNJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:13:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:10185 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932139AbWHGPNI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:13:08 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=T1eSvm91vItSseGEukW3PUdRLVKiICgQyP5ax7/VmXcRh3xbnOpm9cVFgQC/5Vh4H1zL1d1si7iFNp9/Wv+uqTIynBNQHIaE3WVAgjiVpGXs1O4Zrc1R0esBtOmy+K8BE3f8P2mh3hRExaqUMS1VtW433z6FCX4NCe2vXKZb6jA=
Message-ID: <41840b750608070813s6d3ffc2enefd79953e0b55caa@mail.gmail.com>
Date: Mon, 7 Aug 2006 18:13:06 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Pavel Machek" <pavel@suse.cz>
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Cc: "Robert Love" <rlove@rlove.org>, "Jean Delvare" <khali@linux-fr.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       "Alan Cox" <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <20060807134440.GD4032@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492242899-git-send-email-multinymous@gmail.com>
	 <20060807134440.GD4032@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

Thanks for the sign-offs!

On 8/7/06, Pavel Machek <pavel@suse.cz> wrote:
> > +module_param_named(debug, tp_debug, int, 0600);
> > +MODULE_PARM_DESC(debug, "Debug level (0=off, 1=on)");
> > +
> > +/* A few macros for printk()ing: */
> > +#define DPRINTK(fmt, args...) \
> > +  do { if (tp_debug) printk(KERN_DEBUG fmt, ## args); } while (0)
>
> Is not there generic function doing this?

None that I found. Many drivers do it this way.


> > +EXPORT_SYMBOL_GPL(thinkpad_ec_lock);
> > +EXPORT_SYMBOL_GPL(thinkpad_ec_try_lock);
> > +void thinkpad_ec_unlock(void)
> > +{
> > +     up(&thinkpad_ec_mutex);
> > +}
> > +
>
> Do we need these wrappers? Perhaps just directly exporting the mutex?

Yes, we may end up needing to lock away other systems (ACPI?) that
touch the same ports. Apparently not an issue right now, but could
change with new firmware.
Also, that's what Alan Cox told me to do. :-)



> > +     for (i=0; i<TPC_REQUEST_RETRIES; ++i) {
>
> I'd write i++ here (and in other loops)... just for consistency with
> rest of kernel.

OK.
"++i" is the recommended form for C++, got used to that.


> > +     struct dmi_device *dev = NULL;
>
> unneeded initializer.

On a local variable?!


> > +static int __init thinkpad_ec_init(void)
> > +{
> > +     if (!check_dmi_for_ec()) {
> > +             printk(KERN_ERR "thinkpad_ec: no ThinkPad embedded controller!\n");
> > +             return -ENODEV;
>
> KERN_ERR is little strong here, no?

Not sure what's the right one. The user tried to load a module and the
module can't do that; I saw some drivers use KERN_ERR some
KERN_WARNING in similar cases. Is there some guideline on choosing
printk levels?

OK on all other points.

  Shem
