Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWG0PXY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWG0PXY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 11:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbWG0PXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 11:23:23 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:38802 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S932560AbWG0PXV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 11:23:21 -0400
X-Sasl-enc: fwIcU89VSf49ZYY+RlkoC8/411CcXhkxiRpqZGuG3w+E 1154013799
Date: Thu, 27 Jul 2006 12:23:14 -0300
From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
To: Shem Multinymous <multinymous@gmail.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Pavel Machek <pavel@suse.cz>,
       vojtech@suse.cz, Len Brown <len.brown@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org
Subject: Re: [ltp] Re: Generic battery interface
Message-ID: <20060727152314.GC14873@khazad-dum.debian.net>
References: <20060727002035.GA2896@elf.ucw.cz> <20060727140539.GA10835@srcf.ucam.org> <41840b750607270739u7b6fe7efl5ac5ec147d83e624@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41840b750607270739u7b6fe7efl5ac5ec147d83e624@mail.gmail.com>
X-GPG-Fingerprint: 1024D/1CDB0FE3 5422 5C61 F6B7 06FB 7E04  3738 EE25 DE3F 1CDB 0FE3
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 27 Jul 2006, Shem Multinymous wrote:
> On 7/27/06, Matthew Garrett <mjg59@srcf.ucam.org> wrote:
> >This would also be useful for the OLPC project - it's unlikely that
> >it'll use ACPI, but a more feature-rich interface than /proc/apm would
> >be massively helpful. This is just a matter of speccing out what
> >information is needed and what format it should be presented in, and
> >then adding a new device class, right?
> 
> Can we really assume there's one driver providing all battery-related
> attributes?

No, we cannot.  This is not true on ThinkPads, for example.  We *can* make
it true, but AFAIK that means overriding the entire generic ACPI battery
driver, and greating a "glue" thinkpad_battery one that does:

	1. generic ACPI battery access when ACPI is available
	2. thinkpad specific ACPI battery access when ACPI is available
	3. thinkpad specific EC firmware battery access (not ACPI).

That requires the new driver to use functions from ibm_acpi and tp_smapi,
plus the stuff in the generic acpi battery access driver.

It might be the best way to go for ThinkPads, actually.  Some rework on
ibm_acpi ain't that bad, and tp_smapi is already undergoing major surgery.

> In this particular case we could split the ACPI module into two, one
> module for events and one module for the sysfs interface, and load
> only the first one on ThinkPads. But that's only because tp_smapi
> happens to reproduce all of ACPI's attributes; there are probably
> other cases whether neither method dominates the other.

Yes.

> So, if we insist on a standard battery device class name, how do we
> cope with multiple sources of information and control functions?

Good question.

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh
