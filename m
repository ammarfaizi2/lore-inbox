Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424200AbWLBRDc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424200AbWLBRDc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:03:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424209AbWLBRDc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:03:32 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:57182 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1424200AbWLBRDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:03:31 -0500
Message-ID: <4571B133.2010900@oracle.com>
Date: Sat, 02 Dec 2006 09:00:35 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060719)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       aia21@cantab.net
Subject: Re: [PATCH 1/2] lib + ntfs: let modules force HWEIGHT
References: <20061128140840.f87540e8.randy.dunlap@oracle.com> <20061128164538.d95e8498.akpm@osdl.org> <20061202165626.GO11084@stusta.de>
In-Reply-To: <20061202165626.GO11084@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Tue, Nov 28, 2006 at 04:45:38PM -0800, Andrew Morton wrote:
>> On Tue, 28 Nov 2006 14:08:40 -0800
>> Randy Dunlap <randy.dunlap@oracle.com> wrote:
>>
>>> From: Randy Dunlap <randy.dunlap@oracle.com>
>>>
>>> NTFS (=m) uses hweight32(), but that function is only linked
>>> into the kernel image if it is used inside the kernel image,
>>> not in loadable modules.  Let modules force HWEIGHT to be
>>> built into the kernel image.  Otherwise build fails:
>>>
>>>   Building modules, stage 2.
>>>   MODPOST 94 modules
>>> WARNING: "hweight32" [fs/ntfs/ntfs.ko] undefined!
>>>
>>> Yes, I'd certainly prefer for this to be more automated rather than
>>> forced by each module that needs it.
>> Perhaps we should just put it in lib-y and remove CONFIG_GENERIC_HWEIGHT.
>> ...
> 
> This will obviously not help in this case...
> 
> EXPORT_SYMBOL() in a lib-* is always a bug.

so I changed hweight.o to always be in obj-y instead of lib-y.

-- 
~Randy
