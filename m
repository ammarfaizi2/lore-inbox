Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965046AbVHPATh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965046AbVHPATh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 20:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965047AbVHPATh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 20:19:37 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:24455 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S965046AbVHPATh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 20:19:37 -0400
Message-ID: <4301310C.8040505@gmail.com>
Date: Tue, 16 Aug 2005 02:19:24 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?David_H=E4rdeman?= <david@2gen.com>
CC: Naveen Gupta <ngupta@google.com>, linux-kernel@vger.kernel.org
Subject: Re: [-mm PATCH] remove use of pci_find_device in watchdog driver
 for Intel 6300ESB chipset
References: <Pine.LNX.4.56.0508151425320.27212@krishna.corp.google.com> <20050815231426.GA19111@hardeman.nu>
In-Reply-To: <20050815231426.GA19111@hardeman.nu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Härdeman napsal(a):

> On Mon, Aug 15, 2005 at 02:30:15PM -0700, Naveen Gupta wrote:
> [...}
>
>> -        while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) 
>> != NULL) {
>> -                if (pci_match_id(esb_pci_tbl, dev)) {
>> -                        esb_pci = dev;
>> -                        break;
>> -                }
>> -        }
>> +    while (ids->vendor && ids->device) {
>> +        if ((dev = pci_get_device(ids->vendor, ids->device, dev)) != 
>> NULL) {
>> +            esb_pci = dev;
>> +            break;
>> +        }
>> +        ids++;
>> +    }
>
>
> I'm certainly not sure about this, but the proposed while loop looks a 
> bit unconventional, wouldn't something like:
>
> for_each_pci_dev(dev)
>     if (pci_match_id(esb_pci_tbl, dev)) {
>         esb_pci = dev;
>         break;
>     }
> }
>
> be better?

I did it here http://lkml.org/lkml/2005/8/9/305, but it wasn't acked 
yet. I should repost.

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

