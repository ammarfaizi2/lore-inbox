Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751033AbWI3Ohw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751033AbWI3Ohw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 10:37:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbWI3Ohw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 10:37:52 -0400
Received: from smtp103.mail.mud.yahoo.com ([209.191.85.213]:57502 "HELO
	smtp103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751032AbWI3Ohv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 10:37:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=qxb5fD8EtcHx1ppYGWooCktkKp2r7eclP2TtpRi2Z2o9ciLWQ1Qoazzw3n+3etjuHUHD7Kmx2mC3WUqyeoOUYnY0Y0WkE+3mddaNsEe5vWAT6LClMlE4Icv99MmUktFfVWTwcjh2zMavpN/ftF22E3IiwNq0FAAqzEIOwWNrB34=  ;
Message-ID: <451E8143.5030300@yahoo.com.au>
Date: Sun, 01 Oct 2006 00:37:55 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Dong Feng <middle.fengdong@gmail.com>
CC: Christoph Lameter <clameter@sgi.com>, Andi Kleen <ak@suse.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Paul Mackerras <paulus@samba.org>, David Howells <dhowells@redhat.com>,
       linux-kernel@vger.kernel.org
Subject: Re: How is Code in do_sys_settimeofday() safe in case of SMP and
 Nest Kernel Path?
References: <a2ebde260609290733m207780f0t8601e04fcf64f0a6@mail.gmail.com>	 <Pine.LNX.4.64.0609290903550.23840@schroedinger.engr.sgi.com> <a2ebde260609290916j3a3deb9g33434ca5d93e7a84@mail.gmail.com>
In-Reply-To: <a2ebde260609290916j3a3deb9g33434ca5d93e7a84@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dong Feng wrote:
> 2006/9/30, Christoph Lameter <clameter@sgi.com>:
> 
>> On Fri, 29 Sep 2006, Dong Feng wrote:
>>

>> > If the comments mean the subsequent code is SMP-safe and can prevent
>> > nest-kernel-path, how does it achieves that?
>>
>> It relies on locking outside of do_sys_settimeofday(). Seems that this
>> indicates locking is to be performed by the arch before calling
>> do_sys_settimeofday. Looks suspicious to me. Check that this function is
>> always called with the same lock.
>>
> 
> Yes, that is the question. The whole invocation path is
> sys_settimeofday() -> do_sys_settimeofday()
> 
> I do not find a lock embracing do_sys_settimeofday().
> 
> Moreover, seems neither write operations nor read operations on sys_tz
> is protected by any locks, in sys_gettimeofday() and
> sys_settimeofday() respectively.

Did you get to the bottom of this yet? It looks like you're right,
and I suggest a seqlock might be a good option.

You should write a patch and send it to Mister Morton.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
