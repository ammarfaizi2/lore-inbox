Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965031AbWDHWpo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965031AbWDHWpo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Apr 2006 18:45:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWDHWpo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Apr 2006 18:45:44 -0400
Received: from science.horizon.com ([192.35.100.1]:7470 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S965031AbWDHWpo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Apr 2006 18:45:44 -0400
Date: 8 Apr 2006 18:45:33 -0400
Message-ID: <20060408224533.23065.qmail@science.horizon.com>
From: linux@horizon.com
To: linux-kernel@vger.kernel.org
Subject: Re: Black box flight recorder for Linux
Cc: hancockr@shaw.ca, James@superbug.co.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I wouldn't think most BIOSes these days would bother to clear system RAM 
> on a reboot. Certainly Microsoft was encouraging vendors not to do this 
> because it slowed down system boot time.

I don't think they explicitly clear it all, but they do write to it to
test how much RAM is installed and don't bother to put back what they
scribbled on.


Sufficient ECC techniques sould probably recover from the damage.  For a
first attempt, I'd take 4096-byte pages, not use the first and last 8
bytes at all, and divide the remaining 4080 bytes into 16 interleaved
255-byte ECC segments, each using a byte-wide Reed-Solomon code.
(The fraction of that 255 devoted to ECC is up to you; n-bit-wide
Reed-Solomon just requires that data + ECC <= (2^n - 1) bytes of n
bits each.)

For extra hack value, you could detect at boot what parts of your
log got corrupted and avoid using those parts when logging new data.
(There are complications...)

It is possible to update RS ECC incrementally, or perhaps it would be
better to store the tail of the log in some less efficient form (like
multiple replication) and then pack it into ECC when full.


The other thing that might be a problem is that I don't know how long
refresh stops during reset.  Again, ECC can be your friend.
(And code for it already exists in lib/reed_solomon/)
