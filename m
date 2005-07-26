Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262059AbVGZVjS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262059AbVGZVjS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 17:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262078AbVGZVgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 17:36:39 -0400
Received: from fmr14.intel.com ([192.55.52.68]:51875 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S262131AbVGZVfU convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 17:35:20 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] e1000: no need for reboot notifier
Date: Tue, 26 Jul 2005 14:35:07 -0700
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0400174A@scsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] e1000: no need for reboot notifier
Thread-Index: AcWSKRh0SygqXhW2TYyeeV9fHeRfUgAABKkg
From: "Luck, Tony" <tony.luck@intel.com>
To: "Andrew Morton" <akpm@osdl.org>
Cc: "cramerj" <cramerj@intel.com>, "Ronciak, John" <john.ronciak@intel.com>,
       "Venkatesan, Ganesh" <ganesh.venkatesan@intel.com>, <pavel@ucw.cz>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 26 Jul 2005 21:35:08.0876 (UTC) FILETIME=[E55478C0:01C59229]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> sys_reboot() now calls device_suspend(), so it is no longer necessary for
>> the e1000 driver to register a reboot notifier [in fact doing so results
>> in e1000_suspend() getting called twice].
>
>Does this fix the ia64 reboot, or do we still have the 
>mpt-fusion problem?

We still have the mpt-fusion problem :-(   That one appears to
be more convoluted ... we don't seem to be calling the suspend
functions more than once, but I still see the "Badness" messages
from iosapic_unregister_intr().  There may also be an ordering
problem where we shutdown some bits of mpt-fusion, and then later
call the suspend function for another layer to sync out some
SCSI stuff, but it is toast because the device is already down.

-Tony
