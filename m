Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266440AbUAVVzf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 16:55:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266441AbUAVVzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 16:55:35 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:24055 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S266440AbUAVVzd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 16:55:33 -0500
Message-ID: <401046B1.6050806@mvista.com>
Date: Thu, 22 Jan 2004 13:54:57 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: Hollis Blanchard <hollisb@us.ibm.com>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>,
       "Amit S. Kale" <amitkale@emsyssoft.com>
Subject: Re: PPC KGDB changes and some help?
References: <20040120172708.GN13454@stop.crashing.org> <200401211946.17969.amitkale@emsyssoft.com> <20040121153019.GR13454@stop.crashing.org> <200401212223.13347.amitkale@emsyssoft.com> <20040121184217.GU13454@stop.crashing.org> <20040121192128.GV13454@stop.crashing.org> <400F0759.5070309@mvista.com> <20040122150713.GC15271@stop.crashing.org> <30216351-4CEF-11D8-A2A1-000A95A0560C@us.ibm.com> <20040122154529.GE15271@stop.crashing.org>
In-Reply-To: <20040122154529.GE15271@stop.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> On Thu, Jan 22, 2004 at 09:25:19AM -0600, Hollis Blanchard wrote:
> 
>>On Jan 22, 2004, at 9:07 AM, Tom Rini wrote:
>>
>>>On Wed, Jan 21, 2004 at 03:12:25PM -0800, George Anzinger wrote:
>>>
>>>
>>>>A question I have been meaning to ask:  Why is the arch/common 
>>>>connection
>>>>via a structure of addresses instead of just calls?  I seems to me 
>>>>that
>>>>just calling is a far cleaner way to do things here.  All the struct 
>>>>seems
>>>>to offer is a way to change the backend on the fly.  I don't thing we 
>>>>ever
>>>>want to do that.  Am I missing something?
>>>
>>>I imagine it's a style thing.  I don't have a preference either way.
>>
>>I think we in PPC land have gotten used to that "style" because we have 
>>one kernel that supports different "platforms", i.e. it selects the 
>>appropriate code at runtime as George says. In general that's a little 
>>bit slower and a little bit bigger.
>>
>>Unless you need to choose among PPC KGDB functions at runtime, which I 
>>don't think you do, you don't need it...
> 
> 
> That's certainly true, so if (and if I understand Georges question
> right) Amit wants to change kgdb_arch into a set of required functions,
> with stubs in, say, kernel/kgdbdummy.c, (and just keep the flags / etc
> in the struct), that's fine with me.

Something like that.  I would make use of the weak external to handle the stub 
connection, i.e. the common code would define the stubs as weak functions.  The 
linker will choose a normal over a weak so it makes the right connection.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

