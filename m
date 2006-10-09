Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932306AbWJIHfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932306AbWJIHfy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Oct 2006 03:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932312AbWJIHfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Oct 2006 03:35:54 -0400
Received: from mx1.suse.de ([195.135.220.2]:23786 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932306AbWJIHfx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Oct 2006 03:35:53 -0400
Message-ID: <4529FBBE.9070206@suse.de>
Date: Mon, 09 Oct 2006 09:35:26 +0200
From: Gerd Hoffmann <kraxel@suse.de>
User-Agent: Thunderbird 1.5.0.7 (X11/20060911)
MIME-Version: 1.0
To: vgoyal@in.ibm.com
Cc: Andrew Morton <akpm@osdl.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, ebiederm@xmission.com,
       ak@suse.de, horms@verge.net.au, lace@jankratochvil.net, hpa@zytor.com,
       magnus.damm@gmail.com, lwang@redhat.com, dzickus@redhat.com,
       maneesh@in.ibm.com
Subject: Re: [PATCH 1/12] i386: Distinguish absolute symbols
References: <20061003170032.GA30036@in.ibm.com> <20061003170413.GA3164@in.ibm.com> <20061006233547.43888a48.akpm@osdl.org> <20061008164713.GA7149@in.ibm.com>
In-Reply-To: <20061008164713.GA7149@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> looks odd.  What's the point in putting a gap before __smp_alt_end?  Moving
>> __smp_alt_end to before the ALIGN doesn't prevent the warning.
>>

> Please find attached a patch for the same. I am also copying Gerd Hoffmann,
> who introduced this ALIGN. Gerd, can you please confirm that above ALIGN()
> is not required and the patch attached should be fine.

The data between __smp_alt_start and __smp_alt_end will be released at
boot time in some cases (UP machine, kernel without CPU_HOTPLUG, ...).

Releasing memory works at page granularity only, thats why I added the
alignment.  I think you can't simply drop it.

> o There seems to be one extra ALIGN(4096) before symbol __smp_alt_end. The
>   only usage of __smp_alt_end is to mark the end of smp alternative
>   sections so that this memory can be freed. As a physical page is freed
>   one has to just make sure that there is no other data on the same page
>   where __smp_alt_end is pointing. There is already a ALIGN(4096) after
>   this section which should take care of the above issue. Hence it looks
>   like the ALIGN(4096) before __smp_alt_end is redundant and not required.

Hmm, ok, it should work then.  How about adding a comment to make sure
the align after __smp_alt_end doesn't get dropped by accident?

cheers,

  Gerd

-- 
Gerd Hoffmann <kraxel@suse.de>
http://www.suse.de/~kraxel/julika-dora.jpeg
