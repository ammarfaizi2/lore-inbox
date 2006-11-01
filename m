Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752579AbWKAXzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579AbWKAXzx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 18:55:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752581AbWKAXzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 18:55:52 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:45287 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1752579AbWKAXzv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 18:55:51 -0500
X-Sasl-enc: j6iOTqbqioGn1ecENb8E0fhSqix9gt8zsWQgTtArAxpL 1162425351
Date: Wed, 1 Nov 2006 20:55:40 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Greg KH <greg@kroah.com>
Cc: Shem Multinymous <multinymous@gmail.com>,
       David Zeuthen <davidz@redhat.com>, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>, Dan Williams <dcbw@redhat.com>,
       linux-kernel@vger.kernel.org, devel@laptop.org, sfr@canb.auug.org.au,
       len.brown@intel.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>,
       Pavel Machek <pavel@suse.cz>, Jean Delvare <khali@linux-fr.org>
Subject: Re: [ltp] Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061101235540.GA11581@khazad-dum.debian.net>
References: <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com> <1162037754.19446.502.camel@pmac.infradead.org> <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk> <41840b750610281112q7790ecao774b3d1b375aca9b@mail.gmail.com> <20061031074946.GA7906@kroah.com> <41840b750610310528p4b60d076v89fc7611a0943433@mail.gmail.com> <20061101193134.GB29929@kroah.com> <41840b750611011153w3a2ace72tcdb45a446e8298@mail.gmail.com> <20061101205330.GA2593@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101205330.GA2593@kroah.com>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 01 Nov 2006, Greg KH wrote:
> On Wed, Nov 01, 2006 at 09:53:12PM +0200, Shem Multinymous wrote:
> > Hi Greg,
> > 
> > On 11/1/06, Greg KH <greg@kroah.com> wrote:
> > >> The suggestions so far were:
> > >> 1. Append units string to the content of such attribute:
> > >>   /sys/.../capacity_remaining reads "16495 mW".
> > >> 2. Add a seprate *_units attribute saying what are units for other
> > >> attribute:
> > >>   /sys/.../capacity_units gives the units for
> > >>   /sys/.../capacity_{remaining,last_full,design,min,...}.
> > >> 3. Append the units to the attribute names:
> > >>   capacity_{remaining,last_full,design_min,...}:mV.
> > >
> > >No, again, one for power and one for current.  Two different files
> > >depending on the type of battery present.  That way there is no need to
> > >worry about unit issues.
> > 
> > I'm missing something. How is that different from option 3 above?
> 
> No silly ":mV" on the file name.

As long as that also means no "silly _mV" in the name.  However, if the
choice is between :mV and _mV, please go with :mV.

> > BTW, please note that we're talking about a large set of files that
> > use these units (remaining, last full, design capacity, alarm
> > thresholds, etc.), and not just a single attribute.
> 
> Sure, what's wrong with:
> 	capacity_remaining_power
> 	capacity_last_full_power
> 	capacity_design_min_power
> if you can read that from the battery, and:
> 	capacity_remaining_current
> 	capacity_last_full_current
> 	capacity_design_min_current
> if you can read that instead.

Well, "Wh" measures energy and not power, and "Ah" measures electric charge
and not current, so it would be better to make that:

capacity_*_energy  (Wh-based)

and

capacity_*_charge  (Ah-based)

Also, should we go with mWh/mAh, or with even smaller units because of the
tiny battery-driven devices of tomorrow?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
