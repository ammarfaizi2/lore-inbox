Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267433AbUIUBUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267433AbUIUBUV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 21:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267435AbUIUBUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 21:20:21 -0400
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:17341 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S267433AbUIUBUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 21:20:10 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Alex Williamson <alex.williamson@hp.com>
Subject: Re: [ACPI] PATCH-ACPI based CPU hotplug[2/6]-ACPI Eject interface support
Date: Mon, 20 Sep 2004 20:20:05 -0500
User-Agent: KMail/1.6.2
Cc: acpi-devel@lists.sourceforge.net,
       Keshavamurthy Anil S <anil.s.keshavamurthy@intel.com>,
       "Brown, Len" <len.brown@intel.com>,
       LHNS list <lhns-devel@lists.sourceforge.net>,
       Linux IA64 <linux-ia64@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
References: <20040920092520.A14208@unix-os.sc.intel.com> <200409201812.45933.dtor_core@ameritech.net> <1095727925.8780.58.camel@mythbox>
In-Reply-To: <1095727925.8780.58.camel@mythbox>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200409202020.05776.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 20 September 2004 07:52 pm, Alex Williamson wrote:
> On Mon, 2004-09-20 at 18:12 -0500, Dmitry Torokhov wrote: 
> > 
> > Hi Anil,
> > 
> > I obviously failed to deliver my idea :) I meant that I would like add eject
> > attribute (along with maybe status, hid and some others) to kobjects in
> > /sys/firmware/acpi tree.
> > 
> 
> Dmitry,
> 
>    See the patch I just posted to acpi-devel and lkml (Subject:
> [PATCH/RFC] exposing ACPI objects in sysfs).  It exposes acpi objects as
> you describe.   Something simple like:
> 
>  # cat /sys/firmware/acpi/namespace/ACPI/_SB/LSB0/_EJ0
> 
> Will call the _EJ0 method on the ACPI device.  You can evaluate eject
> dependencies using the _EJD method.
> 
> 	Alex
> 

Alex,

While I think that your patch is very important and should be included (maybe
if not as is if somebody has some objections but in some other form) I see it
more like developer's tool. I imagined status, HID, eject etc. attributes to
be sanitized interface to kernel's data, not necessarily causing re-evaluation.

So it could be like this:

/sys/firmware/acpi/namespace/ACPI/_SB/LSB0/status
/sys/firmware/acpi/namespace/ACPI/_SB/LSB0/removable
/sys/firmware/acpi/namespace/ACPI/_SB/LSB0/lockable
..
/sys/firmware/acpi/namespace/ACPI/_SB/LSB0/eject

And your raw access to the ACPI methods could reside under raw:

/sys/firmware/acpi/namespace/ACPI/_SB/LSB0/raw/_STA
/sys/firmware/acpi/namespace/ACPI/_SB/LSB0/raw/_RNV
/sys/firmware/acpi/namespace/ACPI/_SB/LSB0/raw/_LCK
..
/sys/firmware/acpi/namespace/ACPI/_SB/LSB0/raw/_EJ0

-- 
Dmitry
