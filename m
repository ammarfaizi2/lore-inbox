Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964842AbWJ1Vyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964842AbWJ1Vyg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Oct 2006 17:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964864AbWJ1Vyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Oct 2006 17:54:36 -0400
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:49357 "EHLO
	out1.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S964842AbWJ1Vyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Oct 2006 17:54:35 -0400
X-Sasl-enc: JKje/HwN0p4WSoaJmkk16l2iGUBCtjQx4epyF1XNoG4u 1162072475
Date: Sat, 28 Oct 2006 18:54:25 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Pavel Machek <pavel@ucw.cz>
Cc: David Zeuthen <davidz@redhat.com>, Richard Hughes <hughsient@gmail.com>,
       David Woodhouse <dwmw2@infradead.org>,
       Shem Multinymous <multinymous@gmail.com>,
       Dan Williams <dcbw@redhat.com>, linux-kernel@vger.kernel.org,
       devel@laptop.org, sfr@canb.auug.org.au, len.brown@intel.com,
       greg@kroah.com, benh@kernel.crashing.org,
       linux-thinkpad mailing list <linux-thinkpad@linux-thinkpad.org>
Subject: Re: [PATCH v2] Re: Battery class driver.
Message-ID: <20061028215424.GA23228@khazad-dum.debian.net>
References: <1161778296.27622.85.camel@shinybook.infradead.org> <41840b750610250742p7ad24af9va374d9fa4800708a@mail.gmail.com> <1161815138.27622.139.camel@shinybook.infradead.org> <41840b750610251639t637cd590w1605d5fc8e10cd4d@mail.gmail.com> <1162037754.19446.502.camel@pmac.infradead.org> <1162041726.16799.1.camel@hughsie-laptop> <1162048148.2723.61.camel@zelda.fubar.dk> <20061028185513.GD5152@ucw.cz> <1162065236.2723.83.camel@zelda.fubar.dk> <20061028210509.GA30819@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061028210509.GA30819@elf.ucw.cz>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 28 Oct 2006, Pavel Machek wrote:
> > > Just put it into the name:
> > > 
> > > power_avg_mV
> > 
> > Bad idea... it means user space will have to try to open different files
> > and what happens when someone introduces a new unit? Ideally I'd like
> > the unit to be part of the payload of the sysfs file. Second to that I
> > think having the unit in a separate file is preferable.
> 
> Introducing new unit *should* be hard. You know, when you introduce
> new unit, you automatically break all the userspace.

Well, I just wish whatever is done for battery is also done the same way for
ACPI when it moves to sysfs, and if at all possible, also to hwmon: we *are*
supposed to move stuff like ACPI temperatures to sysfs using hwmon
conventions, AFAIK.

That said, wearing a userspace app writer hat, I'd really prefer if it is
named in such a way that I can always extract the unit, like:

power_avg:mV  or
power_avg[mV]

or whatever (and I'd prefer :mV a lot more than [mV], it is much cleaner).
LED seems already to be using ":" for such qualifiers (they use it for the
colors).

I can't just trust that the last _foo is the unit, as it might be something
that doesn't have an unit (it is the status quo in hwmon, for example).  If
the kernel has this unit handling thing clearly defined, I can write a
generic application that displays all battery attributes beautifully,
instantly aware of the units (and even doing the intelligent thing if you
have both power_avg in uV and mV...)

> Having separate files is actually a *feature*. It allows you to
> introduce new units while providing backwards compatibility.

Agreed.

> Imagine going from mV to uV... With voltage_mV, you can have both
> voltage_mV and voltage_uV. In your system, you'd have to change value
> from mV to uV, breaking all the userspace....

I believe there is a school that says that "this is why userspace is
supposed to use a single library helper which will have the knowledge on how
to deal with this".

I am not defending such a library approach.  But if the sysfs interface does
not have the units anywhere, it better be strictly versioned and export
that information somewhere, so that such a library is actually doable in a
sane and robust way.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
