Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261810AbVCUOwM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261810AbVCUOwM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Mar 2005 09:52:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261816AbVCUOwL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Mar 2005 09:52:11 -0500
Received: from rproxy.gmail.com ([64.233.170.205]:13180 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261810AbVCUOwH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Mar 2005 09:52:07 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=qBhZBne8D4NTuRPIwRGSrXaulQ+f/yu31/G+tb11F5VIjsN63/svBtwCD0MpzI8zKsr20rgt/9z/o7hDe+2oqJ9AeY54vnYFQPXEz7aZAQ56yosthQZhRFUBDL+B/sL5g8kdnfwLoQEmGpkjzAeOe3rh6mKH+tRT29Cks/+KmKo=
Message-ID: <d120d500050321065261ee815c@mail.gmail.com>
Date: Mon, 21 Mar 2005 09:52:06 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [rfc/rft] Fujitsu B-Series Lifebook PS/2 TouchScreen driver
Cc: Kenan Esau <kenan.esau@conan.de>, harald.hoyer@redhat.de,
       linux-input@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
In-Reply-To: <20050321124407.GA1762@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <20050217194217.GA2458@ucw.cz> <20050219131639.GA4922@ucw.cz>
	 <1108973216.5774.72.camel@localhost> <20050224090338.GA3699@ucw.cz>
	 <1109664709.18617.10.camel@localhost> <20050301120839.GA5720@ucw.cz>
	 <1110180436.3444.17.camel@localhost> <20050307073406.GA2026@ucw.cz>
	 <1110893143.4777.31.camel@localhost> <20050321124407.GA1762@ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Mar 2005 13:44:07 +0100, Vojtech Pavlik <vojtech@suse.cz> wrote:
> On Tue, Mar 15, 2005 at 02:25:42PM +0100, Kenan Esau wrote:
> > Here is a new version of the patch:
> >       - minimal changes
> >       - reintroduced DMI-probing
> >
> > I had a look at the synaptic-sources to see how the pass-through-mode is
> > implemented. We'll see if something similar to this also works with the
> > lifebook.
> 
> Thanks, I applied this version of the patch to my tree. It'll appear in
> next -mm, and in 2.6.13.
> 

There are couple of things that I an concerned with:

1. I don't like that it overrides meaning of max_proto parameter to be
exactly the protocol specified. However, if you take my psmouse
protocol switching through sysfs patch we can drop that change and
require that non auto-detectable protocols be activated through sysfs
after loading the driver.

2. It looks like it bypasses rate and resolution setting in
psmouse_initialize. What was the reason for it? Does setting rate or
resolution disturbs lifebook mode? If so the driver has to implement
it's own set_rate and set_resolution handlers so when one tries to
change rate from userspace (through sysfs) the request would be
ignored.

-- 
Dmitry
