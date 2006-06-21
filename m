Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030311AbWFUVsz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030311AbWFUVsz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:48:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030312AbWFUVsz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:48:55 -0400
Received: from terminus.zytor.com ([192.83.249.54]:64709 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1030311AbWFUVsy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:48:54 -0400
Message-ID: <4499BDB4.6060503@zytor.com>
Date: Wed, 21 Jun 2006 14:44:20 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Mattia Dongili <malattia@linux.it>, mbligh@mbligh.org,
       linux-kernel@vger.kernel.org, Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: fs/binfmt_aout.o, Error: suffix or operands invalid for `cmp'
 [was Re: 2.6.17-mm1]
References: <44998DCB.1030703@mbligh.org>	<20060621184814.GQ24595@inferi.kami.home>	<44999BC5.7060702@zytor.com>	<20060621193932.GR24595@inferi.kami.home>	<20060621134215.1bca6a5c.akpm@osdl.org>	<20060621211616.GB4638@inferi.kami.home> <20060621143450.41129b01.akpm@osdl.org>
In-Reply-To: <20060621143450.41129b01.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> On Wed, 21 Jun 2006 23:16:17 +0200
> Mattia Dongili <malattia@linux.it> wrote:
> 
>> On Wed, Jun 21, 2006 at 01:42:15PM -0700, Andrew Morton wrote:
>>> On Wed, 21 Jun 2006 21:39:32 +0200
>>> Mattia Dongili <malattia@linux.it> wrote:
>>>
>>>> Thanks, this is fixed, but I have a new failure:
>>>>   CC [M]  fs/xfs/support/move.o
>>>>   CC [M]  fs/xfs/support/uuid.o
>>>>   LD [M]  fs/xfs/xfs.o
>>>>   CC      fs/dnotify.o
>>>>   CC      fs/dcookies.o
>>>>   LD      fs/built-in.o
>>>>   CC [M]  fs/binfmt_aout.o
>>>> {standard input}: Assembler messages:
>>>> {standard input}:160: Error: suffix or operands invalid for `cmp'
>>>> make[1]: *** [fs/binfmt_aout.o] Error 1
>>>> make: *** [fs] Error 2
>>> what the heck?  Can you do `make fs/binfmt_aout.s' then send the relevant
>>> parts of that file?
>> I can't really tell which is the relevant part other than line 160 :)
>> Full file available here:
>> http://oioio.altervista.org/linux/binfmt_aout.s
>>
> 
> It's complaining about this:
> 
> #APP
>         addl %ecx,%eax ; sbbl %edx,%edx; cmpl %eax,$-1073741824; sbbl $0,%edx   # dump.u_dsize, sum, flag,
> #NO_APP

The cmpl should have its arguments reversed.  It's quite possible some versions of the 
assembler accepts the form given, but they're wrong (and doubly confusing when used as 
input to sbb.)

	-hpa
