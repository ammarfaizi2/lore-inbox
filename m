Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932107AbVLIK4o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107AbVLIK4o (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 05:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932115AbVLIK4o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 05:56:44 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:53630
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932107AbVLIK4n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 05:56:43 -0500
Message-Id: <4399712A.76F0.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Fri, 09 Dec 2005 11:57:30 +0100
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andi Kleen" <ak@suse.de>
Cc: "Andrew Morton" <akpm@osdl.org>, "Rafael Wysocki" <rjw@sisk.pl>,
       <linux-kernel@vger.kernel.org>, "Discuss x86-64" <discuss@x86-64.org>
Subject: Re: [discuss] Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch
	breaks resume from disk)
References: <20051204232153.258cd554.akpm@osdl.org>  <200512070146.50221.rjw@sisk.pl>  <200512080015.01444.rjw@sisk.pl>  <43980058.76F0.0078.0@novell.com>  <20051208224735.GV11190@wotan.suse.de>  <439957A7.76F0.0078.0@novell.com> <20051209091605.GE11190@wotan.suse.de>
In-Reply-To: <20051209091605.GE11190@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> >Also I think vgettimeofday doesn't handle 64bit HPET correctly
>> >yet. Also why does it not use hpet_readq? 
>> 
>> For the simple reason that there is no way to know whether the
entire
>> interconnect from CPU to HPET is (at least) 64 bits wide. At least
>> theoretically implementations are permitted to use 32-bit
components;
>> the HPET spec specifically warns about that.
>
>Doesn't that refer to the CPUs ? 

No, all bus components and other chips between CPU and the implementing
chip (including the latter) must have 64-bit data paths and guarantee
not to break up 64-bit reads into pairs of 32-bit ones. Actually, it's
the other way around - since most modern 32-but x86 CPUs have (as far as
I know) 64-bit data busses, it is normally not the CPU that restricts
accesses to 32 bits.

Jan
