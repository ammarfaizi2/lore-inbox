Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292631AbSCLWjX>; Tue, 12 Mar 2002 17:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292780AbSCLWjG>; Tue, 12 Mar 2002 17:39:06 -0500
Received: from p508879CE.dip.t-dialin.net ([80.136.121.206]:56194 "EHLO
	darkside.22.kls.lan") by vger.kernel.org with ESMTP
	id <S292631AbSCLWio>; Tue, 12 Mar 2002 17:38:44 -0500
Date: Tue, 12 Mar 2002 23:38:30 +0100
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
Subject: Re: [patch] ACPI: kbd-pw-on/WOL don't work anymore since 2.4.14
Message-ID: <20020312223830.GC1108@darkside.ddts.net>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7CDB@orsmsx111.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7CDB@orsmsx111.jf.intel.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 12, 2002 at 11:57:48AM -0800, Grover, Andrew wrote:
> Pavel that this should not be a config option. The real problem is that the
> keyboard GPE should be flagged as a wake GPE, but it isn't yet.
> 
> What needs to happen is, when we are entering a sleep state, we need to
> evaluate _PRW and _PSW objects for devices, and take the appropriate action

Well, as I said a few postings ago, I'm not really proof with
ACPI.

But ... from a users point of view (which I seem to be proof for -
especially in *this* case :)):

I enable in the BIOS, what devices should be considered wake
up devices.
This works very well with Windows (not that I'm going to use that,
I just tested it to validate, if it works there), it did work
very well with 2.4.13 too (yes, I know, there was the TODO: disable
GPEs).

Where is the problem to read those wake up events from the BIOS?

Why should I configure this twice - once in BIOS, once in some
ominous ospmd?

I grepped the ACPI code...

If I understand it right, a call to acpi_hw_enable_gpe_for_wakeup(event)
would mark one specific event as wakeup event.
The only call to this function is in acpi_enable_event(...).
And the only call to acpi_enable_event() is in
acpi_install_fixed_event_handler(...) and is flagged as
ACPI_EVENT_FIXED, so that acpi_hw_enable_gpe_for_wakeup() is
*never* called in the whole ACPI code at the moment, so how
can there be GPEs marked as wakeup events however?

And if there can't be any, why should I'm not be able to work
around this bug?
And yes - I consider this as bug :) There is code, which is never
called, afaics.


regards,
   Mario, trying to understand :)
-- 
Programmieren in C++ haelt die grauen Zellen am Leben. Es schaerft
alle fuenf Sinne: den Schwachsinn, den Bloedsinn, den Wahnsinn, den
Unsinn und den Stumpfsinn.
                                 [Holger Veit in doc]
