Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269730AbUJAJza@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269730AbUJAJza (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 05:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269731AbUJAJza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 05:55:30 -0400
Received: from mgw-x1.nokia.com ([131.228.20.21]:44434 "EHLO mgw-x1.nokia.com")
	by vger.kernel.org with ESMTP id S269730AbUJAJzO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 05:55:14 -0400
X-Scanned: Fri, 1 Oct 2004 12:54:37 +0300 Nokia Message Protector V1.3.31 2004060815 - RELEASE
Message-ID: <415D28B7.5070306@nokia.com>
Date: Fri, 01 Oct 2004 12:51:51 +0300
From: =?UTF-8?B?VGltbyBUZXLDpHM=?= <ext-timo.teras@nokia.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040830)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Robert Love <rml@novell.com>
CC: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: kobject events questions
References: <415ABA96.6010908@nokia.com> <1096486749.4666.31.camel@betsy.boston.ximian.com>
In-Reply-To: <1096486749.4666.31.camel@betsy.boston.ximian.com>
X-Enigmail-Version: 0.85.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6217750C3141C8B3008FA2E8"
X-OriginalArrivalTime: 01 Oct 2004 09:54:14.0114 (UTC) FILETIME=[9BA38C20:01C4A79C]
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6217750C3141C8B3008FA2E8
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Robert Love wrote:
> On Wed, 2004-09-29 at 16:37 +0300, Timo Teräs wrote:
>>1) Send the events so that they are always associated with the network 
>>devices class_device kobject. I guess this would be quite clean way to 
>>do it, but it'd require adding a new signal type and would limit the 
>>iptables target to be associated always with a interface.
>>
>>2) Create a device class that has virtual timer devices that trigger 
>>events (ie. /sys/class/utimer). Each timer could have some attributes 
>>(like expired, expire_time, etc.) and would emit "change" signals 
>>whenever timer expires.
> 
> Well, #1 is the intention and spirit of the kevent system.
> 
> And adding a new signal type is fine.
> 
> So the only downside is that the table to interface association thing.
> I have no idea how big an issue that is for you.

I'm just a bit dubious about adding new signals since they are hardcoded 
in the kernel. It's a time consuming process to add new signals (either 
for development build or for official kernels). This is one of the 
reasons I liked more about the original kevent patch. Wouldn't simple 
#defines have been enough for signal names?

> You could of course create a new kobject, ala #2, but that does not seem
> optimal if the object is otherwise worthless.  I don't think that you
> should create a new class.  Better to put something under /sys/net
> related to what you are doing.

I thought quite a bit about to where add my kobjects. I couldn't find a 
/sys/net on my current system (am I missing some config option?). If you 
mean /sys/class/net aren't all kobject in there supposed to be of same 
type (namely class_device associated with net_device). Of course I could 
add them under some interface, but then again my iptables rules would 
have to be interface specific and this is the thing I'm trying to avoid 
in this approach. Adding to /sys would be an overkill as it'd require 
implementing a subsystem. And I couldn't find any other suitable place 
so ended up making a new class.

I actually made some test code to add a new class and it's relatively 
simple. But I guess it isn't really useful if I'd be the only user. 
Maybe it could have some features that'd make it more generic?

Of course, I could use the "connector" patch that Greg pointed, but I'd 
still like more the kevent approach. Namely, it'd make my userland app 
much simpler.

Cheers,
   Timo

--------------enig6217750C3141C8B3008FA2E8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBXSi6FlRU9HaAsIcRAh0FAJ4ot/dv3sNrCk2H968BwrJwI5OidACdFSu8
9PUTQ6Usjns1pR2V5/4Hw54=
=DxiC
-----END PGP SIGNATURE-----

--------------enig6217750C3141C8B3008FA2E8--
