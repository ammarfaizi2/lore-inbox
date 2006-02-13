Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751081AbWBMADs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbWBMADs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Feb 2006 19:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWBMADs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Feb 2006 19:03:48 -0500
Received: from palrel11.hp.com ([156.153.255.246]:48042 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S1751081AbWBMADr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Feb 2006 19:03:47 -0500
Message-ID: <43EFCCE0.3090004@hp.com>
Date: Sun, 12 Feb 2006 16:03:44 -0800
From: Eric Gouriou <eric.gouriou@hp.com>
Organization: Hewlett Packard Company
User-Agent: Thunderbird 1.5 (Macintosh/20051201)
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>,
       Stephane Eranian <eranian@hpl.hp.com>, Philip Mucci <mucci@cs.utk.edu>,
       "Bryan O'Sullivan" <bos@serpentine.com>, perfmon@napali.hpl.hp.com,
       perfctr-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Perfctr-devel] Re: [perfmon] perfmon2 code review: 32-bit ABI
 on	64-bit OS
References: <1138221212.15295.35.camel@serpentine.pathscale.com>	<20060125222844.GB10451@frankl.hpl.hp.com>	<1138649612.4077.50.camel@localhost.localdomain>	<1138651545.4487.13.camel@camp4.serpentine.com>	<1139155731.4279.0.camel@localhost.localdomain>	<1139245253.27739.8.camel@camp4.serpentine.com>	<20060210153608.GC28311@frankl.hpl.hp.com>	<1139596023.9646.111.camel@serpentine.pathscale.com>	<1139681785.4316.33.camel@localhost.localdomain>	<20060211223354.GA30327@frankl.hpl.hp.com> <20060212234606.GC24291@localhost.localdomain>
In-Reply-To: <20060212234606.GC24291@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Gibson wrote:
> On Sat, Feb 11, 2006 at 02:33:54PM -0800, Stephane Eranian wrote:
[...]
>> The most challenging piece is the IP (program pointer) that is in every
>> sample. Today it is defined as unsigned long because this is fairly
>> natural for a code address. The 64bit OS captures addresses as 64-bit,
>> the 32-bit monitoring tool running on top has to consume them as 64-bit
>> addresses, so u64 would be fine. 
>>
>> But not on a 32-bit kernel with a 32-bit tool, addresses exported as u64
>> would certainly work but consume double to buffer space, and that is a
>> more serious issue in my mind.
> 
> Hmm.. does the sampling buffer collect on userspace PC values, or
> kernel ones as well?

  Either, or both, depending on the measurement settings.

  I live in a 64-bit world, so my take on this issue would be to expose
the PC as a uint64_t, always. There is already so much overhead in the
default per-sample header that I wouldn't worry about it.

  Now 64 bit might not always be enough. E.g., on PA-RISC. But _I_ do
not care much about Linux on PA.

   Eric

-- 
Eric Gouriou                                         eric.gouriou@hp.com
