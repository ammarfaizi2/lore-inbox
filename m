Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWAaNqo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWAaNqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 08:46:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWAaNqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 08:46:44 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:16690
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750851AbWAaNq3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 08:46:29 -0500
Message-Id: <43DF785B.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Tue, 31 Jan 2006 14:46:51 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Dave Jones" <davej@redhat.com>, "Andi Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] prevent nested panic from soft lockup detection
References: <43DDE5A1.76F0.0078.0@novell.com.suse.lists.linux.kernel> <20060130145850.GB9752@redhat.com.suse.lists.linux.kernel> <p73fyn4mv7d.fsf@verdi.suse.de>
In-Reply-To: <p73fyn4mv7d.fsf@verdi.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I've been wondering for a while why we don't just make touch_nmi_watchdog
>> do an implicit call to touch_softlockup_watchdog.  I can't think of a situation
>> where we'd want to do one but not the other, and adding patches like this
>> seems to be an uphill battle (I know at least two other places that need
>> this off the top of my head).
>
>Very good idea.
>
>Someone did it already in the SUSE kernel and it helped considerably
>there.

Actually, plain 2.6.15 already has this (for i386 and x86-64 at least). Hence the first of the two hunks the patch
consists of is superfluous. The second hunk, however, is still necessary (as there's no pre-existing
touch_nmi_watchdog() call there, and there also shouldn't be one as interrupts get re-enabled before getting there).

Jan
