Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751187AbWGGF3l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbWGGF3l (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 01:29:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751186AbWGGF3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 01:29:41 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:12003 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751185AbWGGF3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 01:29:40 -0400
Date: Thu, 06 Jul 2006 23:28:55 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: Generic interface for accelerometers (AMS, HDAPS, ...)
In-reply-to: <20060707024603.GC22666@khazad-dum.debian.net>
To: Henrique de Moraes Holschuh <hmh@debian.org>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Pavel Machek <pavel@suse.cz>,
       lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net, Stelian Pop <stelian@popies.net>,
       Michael Hanselmann <linux-kernel@hansmi.ch>
Message-id: <44ADF117.2060900@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.GOQkHC8inXir2wbg4bZayOWXzAY@ifi.uio.no>
 <fa.qLWuLxQd7Mhcnixy/TLVs/nPwig@ifi.uio.no> <44AC5261.9050708@shaw.ca>
 <20060706061930.GA6033@suse.cz> <20060707024603.GC22666@khazad-dum.debian.net>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Henrique de Moraes Holschuh wrote:
> On Thu, 06 Jul 2006, Vojtech Pavlik wrote:
>>>> We are investigating the ACPI global lock as a way to at least get the
>>>> SMBIOS to stay away from the EC while we talk to it, but we don't know if
>>>> the entire SMBIOS firmware respects that lock.
>>> It had better, that is exactly what the ACPI Global Lock is supposed to 
>>> prevent (concurrent access to non-sharable resources between the OS and 
>>> SMI code). The ACPI DSDT contains information on whether or not the 
>>> machine requires the Global Lock in order to access the EC or whether it 
>>> is safe to access without locking.
>>  
>> Isn't that vaild only if you actully use ACPI to access the EC? (AFAIK
>> the HDAPS driver does direct port access.)
> 
> It better be valid for any OS-side access to the EC, otherwise the ACPI
> global lock would be utterly useless.  The system vendor would have done its
> own "global-lock-like" functionality without the need for an ACPI global
> lock specification.
> 
> What is not clear to me is whether an ACPI DSDT method is on the "OS side"
> or on the "SMM side" of the ACPI global lock.

That would be on the OS side of the global lock.. However the OS still 
needs to maintain its own synchronization between its accesses to the 
controller, the global lock is not intended for that purpose. It doesn't 
sound like the HDAPS driver and the ACPI code are necessarily 
synchronizing their accesses (though I can't say I've looked at the code).

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

