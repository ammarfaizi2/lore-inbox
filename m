Return-Path: <linux-kernel-owner+w=401wt.eu-S1751822AbWLNKLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751822AbWLNKLV (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 05:11:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751839AbWLNKLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 05:11:21 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:29875
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751822AbWLNKLV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 05:11:21 -0500
Message-Id: <45813194.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Thu, 14 Dec 2006 10:12:20 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: "dean gaudet" <dean@arctic.org>
Cc: "Zwane Mwaikambo" <zwane@arm.linux.org.uk>,
       "Michael Buesch" <mb@bu3sch.de>,
       "Metathronius Galabant" <m.galabant@googlemail.com>,
       <stable@kernel.org>, "Michael Krufky" <mkrufky@linuxtv.org>,
       "Justin Forbes" <jmforbes@linuxtx.org>, <alan@lxorguk.ukuu.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>,
       "Chris Wedgwood" <reviews@ml.cw.f00f.org>, <akpm@osdl.org>,
       <torvalds@osdl.org>, "Chuck Wolber" <chuckw@quantumlinux.com>,
       "Dave Jones" <davej@redhat.com>, "Chris Wright" <chrisw@sous-sol.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>, <linux-kernel@vger.kernel.org>,
       "Randy Dunlap" <rdunlap@xenotime.net>
Subject: Re: [stable] [PATCH 46/61] fix Intel RNG detection
References: <20061101053340.305569000@sous-sol.org>
 <20061101054343.623157000@sous-sol.org>
 <20061120234535.GD17736@redhat.com>
 <20061121022109.GF1397@sequoia.sous-sol.org>
 <4562D5DA.76E4.0078.0@novell.com>
 <20061122015046.GI1397@sequoia.sous-sol.org>
 <45640FF4.76E4.0078.0@novell.com> <20061124202729.GC29264@redhat.com>
 <456D56E7.76E4.0078.0@novell.com>
 <Pine.LNX.4.64.0612131145460.14936@twinlark.arctic.org>
 <20061213203325.GL10475@sequoia.sous-sol.org>
 <Pine.LNX.4.64.0612131458510.16018@twinlark.arctic.org>
 <45811163.76E4.0078.0@novell.com>
 <Pine.LNX.4.64.0612140028410.16018@twinlark.arctic.org>
In-Reply-To: <Pine.LNX.4.64.0612140028410.16018@twinlark.arctic.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> dean gaudet <dean@arctic.org> 14.12.06 09:40 >>>
>On Thu, 14 Dec 2006, Jan Beulich wrote:
>
>> >with the patch it boots perfectly without any command-line args.
>> 
>> Are you getting the 'Firmware space is locked read-only' message then?
>
>yep...
>
>so let me ask a naive question... don't we want the firmware locked 
>read-only because that protects the bios from viruses?  honestly i'm naive 
>in this area of pc hardware, but i'm kind of confused why we'd want 
>unlocked firmware just so we can detect a RNG.

Indeed, these are contradicting requirements. The RNG detection, as
outlined by Intel documentation, requires being able to write to firmware
hub space (which in turn is hidden behind BIOS space). But I agree that
this is not a good solution (and even without that, it is not good to
require temporarily making invisible the entire BIOS code/data in order
to detect a non-essential device like an RNG).

Jan
