Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261262AbULUIqa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbULUIqa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 03:46:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbULUIqa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 03:46:30 -0500
Received: from mout.alturo.net ([212.227.15.20]:47603 "EHLO mout.alturo.net")
	by vger.kernel.org with ESMTP id S261262AbULUIq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 03:46:28 -0500
Message-ID: <41C7E2D7.7040806@informatik.uni-bremen.de>
Date: Tue, 21 Dec 2004 09:46:15 +0100
From: Arne Caspari <arnem@informatik.uni-bremen.de>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: bcollins@debian.org, linux1394-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: Re: updated: [2.6 patch] ieee1394_core.c: remove unneeded EXPORT_SYMBOL's
References: <20041220015320.GO21288@stusta.de> <41C694E0.8010609@informatik.uni-bremen.de> <20041220175156.GW21288@stusta.de> <20041221004237.GJ21288@stusta.de>
In-Reply-To: <20041221004237.GJ21288@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Mon, Dec 20, 2004 at 06:51:56PM +0100, Adrian Bunk wrote:
> 
>>...
>>After grepping through your CVS sources, it seems hpsb_read and 
>>hpsb_write are the EXPORT_SYMBOLS affecting you?
>>So keeping them should address your concerns?
>>...

Adrian,

A stable API for the 2.6.x tree would address my concerns :-)

There is one thing missing in the module: It does not allocate 
bandwidth. This will require at least a compare_and_swap function. I 
have not looked into this yet but the required exports for this might be 
the "hpsb_lock" and "hpsb_lock64".

Interesting exports ( by looking through your patch ) would also be
EXPORT_SYMBOL(hpsb_guid_get_entry);
EXPORT_SYMBOL(hpsb_nodeid_get_entry);
Maybe they could be used to make the ConfigROM scan code in the driver 
more generic and cleaner? But if they will be removed, would it be 
better to leave the crappy version with hardcoded offsets in the driver?

I can not answer this question now since I am running low on battery and 
I do not have a power cord with me right now :-(

So to keep the current functionality: Yes, only the _read and _write 
functions are required.

  /Arne
