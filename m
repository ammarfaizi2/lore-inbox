Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266551AbUGURIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266551AbUGURIf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 13:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266548AbUGURIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 13:08:31 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:49812 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S266547AbUGURI3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 13:08:29 -0400
In-Reply-To: <Pine.GSO.4.58.0407211746200.8147@waterleaf.sonytel.be>
References: <20040721091249.GA1336@suse.de> <1090421466.2002.24.camel@gaston> <20040721145649.GA439@suse.de> <Pine.GSO.4.58.0407211746200.8147@waterleaf.sonytel.be>
Mime-Version: 1.0 (Apple Message framework v618)
Message-Id: <A688227A-DB38-11D8-9CDF-000A95A4DC02@kernel.crashing.org>
Cc: Olaf Hering <olh@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Paul Mackeras <paulus@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: reserve legacy io regions on powermac
Date: Wed, 21 Jul 2004 19:08:56 +0200
To: Geert Uytterhoeven <geert@linux-m68k.org>
X-Mailer: Apple Mail (2.618)
X-MIMETrack: Itemize by SMTP Server on D12ML064/12/M/IBM(Release 6.0.2CF2HF259 | March
 11, 2004) at 21/07/2004 19:08:12,
	Serialize by Router on D12ML064/12/M/IBM(Release 6.0.2CF2HF259 | March 11, 2004) at
 21/07/2004 19:08:13,
	Serialize complete at 21/07/2004 19:08:13
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>> I think the simplest fix for 2.6 is a request_region of the 
>>>> problematic
>>>> areas.
>>>
>>> Note that this is still all workarounds... Nothing prevents you (and 
>>> some
>>> people actually do that) to put a PCI card with legacy serial ports 
>>> on it
>>> inside a pmac....
>>
>> Sure, but will that use the same io ports? I dont have one to verify 
>> it.
>
> If it's a `clean' PCI card, it will use the PCI BARs, and there's no 
> problem.

There is nothing that prevents the OF to allocate addresses in the 
"legacy"
range to the PCI cards.  In fact, the normal strategy is to allocate
starting at zero, and going upward, so 0x60 (which is one of the 
"disallowed"
addresses in Olaf's patch) is pretty easy to hit.


Segher

