Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265385AbUBPHVa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 02:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265390AbUBPHVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 02:21:30 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:56751 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S265385AbUBPHV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 02:21:29 -0500
Message-ID: <40306F65.8060702@t-online.de>
Date: Mon, 16 Feb 2004 08:21:09 +0100
From: Harald Dunkel <harald.dunkel@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040214
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ryan Reich <ryanr@uchicago.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.2: "-" or "_", thats the question
References: <1o903-5d8-7@gated-at.bofh.it> <1pkw6-3BU-3@gated-at.bofh.it> <1prnS-4x8-1@gated-at.bofh.it> <402F8A00.8030501@uchicago.edu>
In-Reply-To: <402F8A00.8030501@uchicago.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Seen: false
X-ID: Vy-nM8ZV8eUK5MZL+KLE0J-9nnkpfPcDgljrTC4Q7pcAhhr+BJXt4X
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Reich wrote:
> Harald Dunkel wrote:
> 
>>
>> I am interested in the module file names. 'cat /proc/modules'
>> should return the correct module names, but for some modules
>> (like uhci_hcd vs uhci-hcd.ko) '_' and '-' are messed up.
> 
> 
> According to the modprobe man page, the two symbols are interchangeable.
> 
I know. But this requires some very ugly workarounds outside
of module-init-tools. For example, if you want to check
whether a module $module_name has already been loaded, you
cannot use

     grep -q "^${module_name} " /proc/modules

Instead you have to use a workaround like

     x="`echo $module_name | sed -e 's/-/_/g'`"
     cat /proc/modules | sed -e 's/-/_/g' | grep -q "^${x} "

This is inefficient and error-prone.

Maybe somebody has another idea for the workaround,
but I like the first version.


Regards

Harri
