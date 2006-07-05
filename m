Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965077AbWGFACF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965077AbWGFACF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:02:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965082AbWGFACF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:02:05 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:38648 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965077AbWGFACD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:02:03 -0400
Date: Wed, 05 Jul 2006 17:59:29 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Generic interface for accelerometers (AMS, HDAPS, ...)
In-reply-to: <fa.qLWuLxQd7Mhcnixy/TLVs/nPwig@ifi.uio.no>
To: Henrique de Moraes Holschuh <hmh@debian.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>
Message-id: <44AC5261.9050708@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.GOQkHC8inXir2wbg4bZayOWXzAY@ifi.uio.no>
 <fa.qLWuLxQd7Mhcnixy/TLVs/nPwig@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> HDAPS talks to the embedded controller using IO over the LPC bus, and not to
> the accelerometer chip or to a simple A/D i2c chip which is used excusively
> for accelerometer access.  The EC interface for HDAPS data retrieval is
> not friendly to any errors, and hardlocks the machine somehow if any
> firmware bugs hit or if we violate any of the rules (that are not written
> anywhere) about how to access the EC without geting the SMBIOS unhappy.
> 
> So, turning off HDAPS polling while it is not necessary really looks like a
> good idea overall.
> 
> We are investigating the ACPI global lock as a way to at least get the
> SMBIOS to stay away from the EC while we talk to it, but we don't know if
> the entire SMBIOS firmware respects that lock.

It had better, that is exactly what the ACPI Global Lock is supposed to 
prevent (concurrent access to non-sharable resources between the OS and 
SMI code). The ACPI DSDT contains information on whether or not the 
machine requires the Global Lock in order to access the EC or whether it 
is safe to access without locking.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

