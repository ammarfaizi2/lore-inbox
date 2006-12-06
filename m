Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936951AbWLFRxX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936951AbWLFRxX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 12:53:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936957AbWLFRxX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 12:53:23 -0500
Received: from aun.it.uu.se ([130.238.12.36]:51257 "EHLO aun.it.uu.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936951AbWLFRxX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 12:53:23 -0500
Date: Wed, 6 Dec 2006 18:52:39 +0100 (MET)
Message-Id: <200612061752.kB6Hqd1J004450@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@it.uu.se>
To: hjl@lucon.org, rdunlap@xenotime.net
Subject: Re: Change x86 prefix order
Cc: gcc@gcc.gnu.org, libc-alpha@sources.redhat.com,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Dec 2006 09:00:30 -0800, H. J. Lu wrote:
>On Wed, Dec 06, 2006 at 08:43:17AM -0800, Randy Dunlap wrote:
>> On Tue, 5 Dec 2006 23:00:14 -0800 H. J. Lu wrote:
>> 
>> > On x86, the order of prefix SEG_PREFIX, ADDR_PREFIX, DATA_PREFIX and
>> > LOCKREP_PREFIX isn't fixed. Currently, gas generates
>> > 
>> > LOCKREP_PREFIX ADDR_PREFIX DATA_PREFIX SEG_PREFIX
>> > 
>> > I will check in a patch:
>> > 
>> > http://sourceware.org/ml/binutils/2006-12/msg00054.html
>> > 
>> > tomorrow and change gas to generate
>> > 
>> > SEG_PREFIX ADDR_PREFIX DATA_PREFIX LOCKREP_PREFIX
>> 
>> Hi,
>> Could you provide a "why" for this in addition to the
>> "what", please?
>
>LOCKREP_PREFIX is also used as SIMD prefix. DATA_PREFIX can be used as
>either SIMD prefix or data size prefix for SIMD instructions. The new
>order
>
>SEG_PREFIX ADDR_PREFIX DATA_PREFIX LOCKREP_PREFIX
>
>will make SIMD prefixes close to SIMD opcode.

That's still just "what" and doesn't explain why
this change is desirable.

Software x86 decoders clearly must handle any valid
prefix order, so they shouldn't care. (I've written one
recently. It's tedious but not rocket science.)

If hardware x86 decoders (i.e., Intel or AMD processors)
get measurably faster with the new order, that would be
a good reason to change it.

/Mikael
