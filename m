Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265124AbUGGNFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265124AbUGGNFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jul 2004 09:05:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265109AbUGGM7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jul 2004 08:59:37 -0400
Received: from holomorphy.com ([207.189.100.168]:28125 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265124AbUGGM4J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jul 2004 08:56:09 -0400
Date: Wed, 7 Jul 2004 05:55:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.7-mm6
Message-ID: <20040707125559.GF21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dmitry Torokhov <dtor_core@ameritech.net>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040705023120.34f7772b.akpm@osdl.org> <200407070015.39507.dtor_core@ameritech.net> <20040707063733.GD21066@holomorphy.com> <200407070747.16512.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407070747.16512.dtor_core@ameritech.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 07 July 2004 01:37 am, William Lee Irwin III wrote:
>> This suspicion is correct. It boots normally with the patch you posted
>> to do that registration outside the interrupts-off critical section
>> applied. Bootlog below.

On Wed, Jul 07, 2004 at 07:47:16AM -0500, Dmitry Torokhov wrote:
> Great! I am still somewhat confused why it started locking up with sysfs
> patch - even before sunzilog was calling serio_register_port with interrupts
> off and serio core was downing it's serio_sem as the very first thing. Since
> at the time sunzilog registers its ports no serio drivers have been registered
> yet, effectively the only change introduced by sysfs patch is the call to
> device_register which takes bus' subsystem rwsem and there really should not
> be any congestion.
> Maybe rwsems can not be touched with interrupts off? Sparc only? Everywhere?
> (I know that you should not normally call functions that may sleep with
> interrupts off).

CONFIG_PREEMPT enables this to be warned on appropriately. It should
basically never happen unless it's a down_trylock() etc.


-- wli
