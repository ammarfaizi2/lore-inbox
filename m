Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932153AbVKOAzr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932153AbVKOAzr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 19:55:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbVKOAzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 19:55:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:48260 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932153AbVKOAzq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 19:55:46 -0500
Message-ID: <437931FD.1010707@redhat.com>
Date: Mon, 14 Nov 2005 18:55:25 -0600
From: Mike Christie <mchristi@redhat.com>
User-Agent: Mozilla Thunderbird 1.0.2-6 (X11/20050513)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olivier Galibert <galibert@pobox.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <20051114021127.GC5735@stusta.de> <4378650A.1070209@drzeus.cx> <1131964282.2821.11.camel@laptopd505.fenrus.org> <20051114111108.GR3699@suse.de> <1131967167.2821.14.camel@laptopd505.fenrus.org> <20051114112402.GT3699@suse.de> <1131967678.2821.21.camel@laptopd505.fenrus.org> <20051114113442.GU3699@suse.de> <1131969212.2821.27.camel@laptopd505.fenrus.org> <20051114120417.GA33935@dspnet.fr.eu.org> <43792C82.5010707@redhat.com>
In-Reply-To: <43792C82.5010707@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Christie wrote:
> Olivier Galibert wrote:
> 
>> On Mon, Nov 14, 2005 at 12:53:31PM +0100, Arjan van de Ven wrote:
>>
>>> The experience with Fedora so far is exceptionally good; in early 2.6
>>> there were some reports with XFS stacked on top of DM, but since then
>>> XFS has gone on a stack diet... also the -mm patches to do non-recursive
>>> IO submission will bury this (mostly theoretical) monster for good.
>>
>>
>>
>> Not theorical for iscsi though.  I guess net+block is a little too
>> much.
>>
> 
> If you have stack problem with iscsi then you should post it to those 
> lists or send me a pointer offlist. There were problems with iscsi and 
> XFS but they should be fixed in mainline. The XFS + iscsi problems that 
> have been reported have not been stack usage problems though.
> 

I think to hit a iscsi stack problem you will have to have the scsi 
request_fn get called from __make_request (or one of the functions it 
calls like __elv_add_request which looks like it could call 
__generic_unplug_device). And then the iscsi queuecomamnd would have to 
hit the path that calls iscsi_data_xmit. Have you hit this?
