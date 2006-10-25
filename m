Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423168AbWJYJyd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423168AbWJYJyd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 05:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423169AbWJYJyd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 05:54:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:28511 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1423168AbWJYJyc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 05:54:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=khcMFxGhGUoVXRFjbLl6Lg650hJ780D29t3F58R9/U/W6I2tljOFM01/TWT/nKu1JPHnh0W4ddsZD/HwSF/4lscOD6dJ4Xprgs2d8+xwMMosaaoIse9zIuNmnWqzRzRWD6/UPe8/4QKBH93UKTLMZ6kcffXIeF8SQGuaqL4QUCs=
Message-ID: <41840b750610250254x78b8da17t63ee69d5c1cf70ce@mail.gmail.com>
Date: Wed, 25 Oct 2006 11:54:31 +0200
From: "Shem Multinymous" <multinymous@gmail.com>
To: "David Woodhouse" <dwmw2@infradead.org>
Subject: Re: [PATCH v2] Re: Battery class driver.
Cc: "Richard Hughes" <hughsient@gmail.com>, "Dan Williams" <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, greg@kroah.com, benh@kernel.crashing.org,
       "David Zeuthen" <davidz@redhat.com>
In-Reply-To: <1161762158.27622.72.camel@shinybook.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1161628327.19446.391.camel@pmac.infradead.org>
	 <1161631091.16366.0.camel@localhost.localdomain>
	 <1161633509.4994.16.camel@hughsie-laptop>
	 <1161636514.27622.30.camel@shinybook.infradead.org>
	 <1161710328.17816.10.camel@hughsie-laptop>
	 <1161762158.27622.72.camel@shinybook.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On 10/25/06, David Woodhouse <dwmw2@infradead.org> wrote:
> > > For sane hardware where we get an interrupt on such changes, that's fine
> > > -- but I'm wary of having to implement that by making the kernel poll
> > > for them; especially if/when there's nothing in userspace which cares.
> >
> > HAL and gnome-power-manager? There should only be a few changing values
> > on charging and discharging, and one every percentage point change isn't
> > a lot.

What about current and power? These change very quickly.

BTW, your patch doesn't address the instantaneous vs. average readout
issue in the Smart Battery Data Specification and ThinkPads. Nor a
number of other issues I brought up earlier.


> My point is that if HAL isn't running, we shouldn't bother to poll. If
> HAL _is_ running, then _it_ could poll, if the hardware isn't capable of
> generating events. But let's leave that on the TODO list for now.

Agreed.



> one of the things I plan is to remove 'charge_units' and provide both
> 'design_charge' and 'design_energy' (also {energy,charge}_last,
> _*_thresh etc.) to cover the mWh vs. mAh cases.

You can't do this conversion, since the voltage is not constant.
Typically the voltage drops when the charge goes down, so you'll be
grossly overestimating the available energy it. And the effect varies
with battery chemistry and condition.

So there's no choice, you must use a generic term + units (and I
suggest following the Smart Battery Data Specification's term
"capacity"). This also takes care of the inevitable hardware that
reports in other units, such as normalized percent.


> I'd rather show it as a hex value 'flags' than
> split it up. But I still think that the current 'present,charging,low'
> is best.

Then please make space-separated rather than comma-separated. That's
easier to parse in shell and C.

  Shem
