Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTIKOe4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:34:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261312AbTIKOe4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:34:56 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59569 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261308AbTIKOeu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:34:50 -0400
Message-ID: <3F6087FC.7090508@pobox.com>
Date: Thu, 11 Sep 2003 10:34:36 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: akpm@osdl.org, richard.brunner@amd.com, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com>	<20030911012708.GD3134@wotan.suse.de>	<20030910184414.7850be57.akpm@osdl.org>	<20030911014716.GG3134@wotan.suse.de>	<3F60837D.7000209@pobox.com> <20030911162634.64438c7d.ak@suse.de>
In-Reply-To: <20030911162634.64438c7d.ak@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> It was not created for that (I know that because I created it ;-)

hehe


> X86_GENERIC is merely an optimization hint (currently it only changes the cache
> line size hint) It does not change anything related to correctness. Everything
> that handles correctness is checked unconditionally.

When, building non-Pentium4-related code when CONFIG_MPENTIUM4 && 
!CONFIG_X86_GENERIC, it's OK that the code is incorrect for (picking 
example) AMD processors.

It would be a user bug to boot that on an AMD box, just like it would be 
user bug to boot a CONFIG_M586 kernel on an ancient 386.


> is_prefetch is a correctness thing.

When we know at compile time it's not needed, it should not be enabled.


>>If I disabled CONFIG_X86_GENERIC and select CONFIG_MPENTIUM4, I darned 
>>well better not get any Athlon code.  The cpu setup code in particular I 
>>want to conditionalize, and there are other bits that need work... but 
>>for the most part it works as intended.
> 
> 
> Now that's becomming silly. It's alttogether only a few KB and all
> __init code anyways.


If you're doing crazy LinuxBIOS stuff where flash size is limited, it 
makes a lot of sense.  (and I do such crazy things)  The core 2.6 kernel 
has really bloated with optional features, IMO.

	Jeff



