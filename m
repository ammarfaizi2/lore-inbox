Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750825AbWC2E7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750825AbWC2E7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 23:59:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750829AbWC2E7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 23:59:54 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:58496 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750825AbWC2E7x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 23:59:53 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=F+bxPZe7YCVTTv9OuXbjpQ4IMyhGEZMlgOMTtRFf6X43+fZcpniyqzCgTSPphYdbWOr3Vop913hqKIDausVBmLafwjkjHcT49W1oh6/TYPdvo7fvwxc6ndodEb/TIJ1Q4XTWR7JFFOlUm/IHEhPAEHGcdCIo6PGX3ocgpSh10GI=  ;
Message-ID: <4429F27C.6020404@yahoo.com.au>
Date: Wed, 29 Mar 2006 13:35:40 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050927 Debian/1.7.8-1sarge3
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Zoltan Menyhart <Zoltan.Menyhart@free.fr>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
Subject: Re: Fix unlock_buffer() to work the same way as bit_unlock()
References: <200603281853.k2SIrGg28290@unix-os.sc.intel.com> <4429ADBC.50507@free.fr> <Pine.LNX.4.64.0603281537500.15037@schroedinger.engr.sgi.com> <4429CFCA.7010201@yahoo.com.au> <Pine.LNX.4.64.0603281822570.18374@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0603281822570.18374@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>On Wed, 29 Mar 2006, Nick Piggin wrote:
>
>
>>However, I think it might be reaonsable to use bit lock operations for
>>in places like page lock and buffer lock (ie. with acquire and relese
>>semantics). It improves ia64 without harming other architectures, and
>>also makes the code more expressive.
>>
>
>How would be express the acquire and release semantics?
>

Hmm, not sure. Maybe a few new bitops with _lock / _unlock postfixes?
For page lock and buffer lock we'd just need test_and_set_bit_lock,
clear_bit_unlock, smp_mb__after_clear_bit_unlock.

I don't know, _for_lock might be a better name. But it's getting long.

--

Send instant messages to your online friends http://au.messenger.yahoo.com 
