Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263016AbTEBRGQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 13:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263020AbTEBRGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 13:06:16 -0400
Received: from chaos.analogic.com ([204.178.40.224]:48017 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263016AbTEBRGN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 13:06:13 -0400
Date: Fri, 2 May 2003 13:20:58 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: Jonathan Lundell <linux@lundell-bros.com>
cc: Kevin Corry <kevcorry@us.ibm.com>, viro@parcelfarce.linux.theplanet.co.uk,
       Bodo Rzany <bodo@rzany.de>, Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: is there small mistake in lib/vsprintf.c of kernel 2.4.20 ?
In-Reply-To: <p05210604bad8521898a8@[207.213.214.37]>
Message-ID: <Pine.LNX.4.53.0305021316350.9743@chaos>
References: <20030502090835.GX10374@parcelfarce.linux.theplanet.co.uk>
 <Pine.LNX.4.44.0305021131290.493-100000@joel.ro.ibrro.de>
 <20030502095018.GY10374@parcelfarce.linux.theplanet.co.uk>
 <200305021003.33638.kevcorry@us.ibm.com> <Pine.LNX.4.53.0305021116340.9129@chaos>
 <p05210604bad8521898a8@[207.213.214.37]>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 May 2003, Jonathan Lundell wrote:

> At 11:27am -0400 5/2/03, Richard B. Johnson wrote:
> >If your conversion chances the base to 0, you divide by 0 (not
> >good) and don't get a remainder. Actually  procedure number()
> >protects against a base less than 2 or greater than 36 so you
> >just prevent conversion altogether.
>
> A bug in number(), looks like. (base = 0) is intended to let the
> input string determine the base (16 if 0x*, else 8 if 0* else 10).
> Like simple_strtol().
> --
No. number() is an internal helper function. The base is correctly
set before number() is called. The reported bug had nothing at
all to do with the internal variable, base. Instead it had to
do with not allowing a leading "0x" for hexadecimal numbers
as the standard allows (or has been interpreted to allow).

This is simply fixed by inspection of the string variable before
a conversion is attempted.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.20 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.

