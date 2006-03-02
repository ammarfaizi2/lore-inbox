Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751955AbWCBIjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751955AbWCBIjB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 03:39:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbWCBIjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 03:39:01 -0500
Received: from 85.8.13.51.se.wasadata.net ([85.8.13.51]:42629 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751955AbWCBIjA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 03:39:00 -0500
Message-ID: <4406AF27.9040700@drzeus.cx>
Date: Thu, 02 Mar 2006 09:39:03 +0100
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5 (X11/20060210)
MIME-Version: 1.0
To: Kay Sievers <kay.sievers@vrfy.org>
CC: ambx1@neo.rr.com, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [PNP] 'modalias' sysfs export
References: <20060227214018.3937.14572.stgit@poseidon.drzeus.cx> <20060301194532.GB25907@vrfy.org>
In-Reply-To: <20060301194532.GB25907@vrfy.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kay Sievers wrote:
> On Mon, Feb 27, 2006 at 10:40:19PM +0100, Pierre Ossman wrote:
>> User space hardware detection need the 'modalias' attributes in the
>> sysfs tree. This patch adds support to the PNP bus.
> 
>> +
>> +	/* FIXME: modalias can only do one alias */
>> +	return sprintf(buf, "pnp:c%s\n", pos->id);
> 
> Without the FIXME actually "fixed", this does not make sense. You want to
> match always on _all_ aliases. In most cases where you have more than
> one, the first one is the vendor specific one which isn't interesting at
> all on Linux. If you have more than one entry usually the second one is the
> one you are looking for.
> 
> So eighter we find a way to encode _all_ id's in one modalias string which can
> be matched by a wildcard or keep the current solution which iterates over the
> sysfs "id" file and calls modprobe for every entry.
> 

That's a bit harsh. Although the FIXME is a downer, this patch is a
strict addition of functionality, not removal. It solves a real problem
for me, and it does so without removing any functionality for anyone
else. The fact is that most PNP devices do not have multiple id:s (at
least the ACPI variant which is the most common in todays machines), so
the problem is not near as big as you make it out to be.

That said, I agree that it would be desirable to fix this. First of all
we would need to synchronise this with userspace. Currently I guess that
means udev. Allowing 'modalias' to contain multiple lines should be a
simple enough solution (provided we don't fill the available buffer space).

The PNP cards are also a bit of a problem, but this isn't something new.
When matching a device to a driver, the card ID must match and also all
device ID:s. The problem is that the device ID:s are sets, not lists.
I.e. we compare the unordered contents of the two, with no regard to
ordering.

Rgds
Pierre

