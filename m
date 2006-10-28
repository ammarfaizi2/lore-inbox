Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752488AbWJ1Oey@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752488AbWJ1Oey (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 10:34:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752489AbWJ1Oey
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 10:34:54 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:29014 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1752488AbWJ1Oex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 10:34:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=q0JDpcXmdLITmn9q6vRcVXUAGPf2oT93l/OvqgcXkj7DZ1Cbl4gigXKGx/3tliPsAfldcrOc82lAH5aClDRlR1kqVRs2NxdwYWlvCLtyi7fzyGtGS8Zjh+qFpeAmlTr0lO19M86AIcBoMQCKod7MYfUhi0a9cyGdl00RnrVDwaI=
Message-ID: <41840b750610280734q212fc138occ152f4a01ef67f5@mail.gmail.com>
Date: Sat, 28 Oct 2006 16:34:52 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Richard Hughes" <hughsient@gmail.com>
Subject: Re: [PATCH v2] Re: Battery class driver.
Cc: "David Woodhouse" <dwmw2@infradead.org>, "Dan Williams" <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       "David Zeuthen" <davidz@redhat.com>,
       "linux-thinkpad mailing list" <linux-thinkpad@linux-thinkpad.org>
In-Reply-To: <1162041726.16799.1.camel@hughsie-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161710328.17816.10.camel@hughsie-laptop>
	 <1161762158.27622.72.camel@shinybook.infradead.org>
	 <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
	 <1161778296.27622.85.camel@shinybook.infradead.org>
	 <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com>
	 <1161815138.27622.139.camel@shinybook.infradead.org>
	 <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com>
	 <1162037754.19446.502.camel@pmac.infradead.org>
	 <1162041726.16799.1.camel@hughsie-laptop>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/28/06, Richard Hughes <hughsient@gmail.com> wrote:
> On Sat, 2006-10-28 at 13:15 +0100, David Woodhouse wrote:
> >
> > Hm. Again we have the question of whether to export 'threshold_pct'
> > vs.'threshold_abs', or whether to have a separate string property
> > which says what the 'unit' of the threshold is. I don't care much --
> > I'll do whatever DavidZ prefers.
>
> Unit is easier to process in HAL in my opinion.

That's harder for modifiable attributes, because apps need to know the
minimum and maximum values (e.g., for  sane GUI). So it's either
multiple sets, or strings with fixed semantics (say, "percent" and
"capacity"), or adding *_min and *_max read-only attributes.

Speaking of which, battery.h says this:

* Thou shalt not export any attributes in sysfs except these, and
    with these units: */

Drivers *will* want to violate this. For example, the "inhibit
charging for N minutes" command on ThinkPads seems too arcane to be
worthy of generalization. I would add a more sensible boolean
"charging_inhibit" attribute to battery.h, and let the ThinkPad driver
implement it as well as it can. The driver will then expose a
non-stadard "charging_inhibit_minutes" attribute to reveal the finer
level of access to those who care.

  Shem
