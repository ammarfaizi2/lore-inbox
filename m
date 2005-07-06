Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262521AbVGFUTq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262521AbVGFUTq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 16:19:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262515AbVGFUMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 16:12:37 -0400
Received: from buffy.riseup.net ([69.90.134.155]:49802 "EHLO mail.riseup.net")
	by vger.kernel.org with ESMTP id S262262AbVGFTmq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 15:42:46 -0400
Date: Wed, 6 Jul 2005 21:45:36 +0200
From: st3@riseup.net
To: linux-kernel@vger.kernel.org
Subject: Re: speedstep-centrino on dothan
Message-ID: <20050706214536.3883b76b@horst.morte.male>
In-Reply-To: <20050706140653.GA6415@isilmar.linta.de>
References: <20050706112202.33d63d4d@horst.morte.male>
	<20050706140653.GA6415@isilmar.linta.de>
X-Mailer: Sylpheed-Claws 1.9.12 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005 16:06:53 +0200
Dominik Brodowski <linux@dominikbrodowski.net> wrote:

> Hi,
> 
> On Wed, Jul 06, 2005 at 11:22:02AM +0200, st3@riseup.net wrote:
> > Currently, the speedstep-centrino support has built-in frequency/voltage
> > pairs only for Banias CPUs. For Dothan CPUs, these tables are read from
> > BIOS ACPI.
> > 
> > But ACPI encoding may not be available or not reliable, so why shouldn't we
> > provide built-in tables for Dothan CPUs, too? Intel has released this
> > datasheet:
> > 
> > http://www.intel.com/design/mobile/datashts/302189.htm
> > 
> > with frequency/voltage pairs for every version of Dothan CPUs.
> 
> However, it is not known which one of VID#A, VID#B, VID#C or VID#D is to be
> used on a specific system.

Ok, so we could patch it in order to use acpi if available, and else use,
say, VID#C (every different VID is suitable for any system I tested so far;
moreover, voltages are very similar).

The safe choice is VID#A, the best one is VID#D =)

Another option: add a module_param for that, and make it configurable in
Kconfig whether to use ACPI tables or select between different VID profiles
through the parameter (not just for Banias, as of current version),
defaulting to VID#A.

anyway I will:
1) look for more specifications from Intel;
2) check VID setup on different systems (who can say that OEMs really use
them differently?).

Then, i found out that running CPU (in my case, Dothan 715) at 400MHz saves
lot of battery, really (on a Toshiba Satellite A50 with standard battery,
idling, 6h20 vs. 5h at 600MHz): it would be very nice to add support
for these frequencies to speedstep-centrino.


--
ciao
st3

