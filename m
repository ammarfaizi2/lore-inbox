Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264270AbTDOFhX (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 01:37:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264299AbTDOFhX (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 01:37:23 -0400
Received: from franka.aracnet.com ([216.99.193.44]:27114 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S264270AbTDOFhW (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 01:37:22 -0400
Date: Mon, 14 Apr 2003 22:49:03 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Antonio Vargas <wind@cocodriloo.com>
cc: linux-kernel@vger.kernel.org, nicoya@apia.dhs.org
Subject: Re: cow-ahead N pages for fault clustering
Message-ID: <20890000.1050385742@[10.10.2.4]>
In-Reply-To: <20030414184715.GI14552@wind.cocodriloo.com>
References: <10760000.1050332136@[10.10.2.4]>
 <20030414152947.GB14552@wind.cocodriloo.com>
 <12790000.1050334744@[10.10.2.4]>
 <20030414155748.GD14552@wind.cocodriloo.com>
 <14860000.1050337484@[10.10.2.4]>
 <20030414164321.GE14552@wind.cocodriloo.com>
 <15700000.1050338226@[10.10.2.4]>
 <20030414171419.GG14552@wind.cocodriloo.com>
 <16700000.1050340965@[10.10.2.4]>
 <20030414183251.GH14552@wind.cocodriloo.com>
 <20030414184715.GI14552@wind.cocodriloo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > >> Ah, you probably don't want to do that ... it's very expensive.
>> > >> Moreover, if you exec 2ns later, all the effort will be wasted ...
>> > >> and it's very hard to deterministically predict whether you'll exec
>> > >> or not (stupid UNIX  semantics). Doing it lazily is probably best,
>> > >> and as to "nodes would not  have to reference the memory from
>> > >> others" - you're still doing that, you're just batching it on the
>> > >> front end.
>> > > 
>> > > True... What about a vma-level COW-ahead just like we have a
>> > > file-level read-ahead, then? I mean batching the COW at
>> > > unCOW-because-of-write time.
>> > 
>> > That'd be interesting ... and you can test that on a UP box, is not
>> > just NUMA. Depends on the workload quite heavily, I suspect.
>> >  
>> > > btw, COW-ahead sound really silly :)
>> > 
>> > Yeah. So be sure to call it that if it works out ... we need more
>> > things like that ;-) Moooooo.
>> 
>> What about the attached one? I'm compiling it right now to test in UML :)
>> 
>> [ snip fake-NUMA-on-SMP discussion ]
>> 
> 
> OK, too quick for me... this next one applies, compiles and boots on
> 2.5.66 + uml. Now I wonder how can I test if this is useful... ideas?

Well, benchmark it ;-) My favourite trick is to just 
"/usr/bin/time make bzImage" on some fixed kernel version & config,
but aim7 / aim9 is pretty easy to set up too, and might be interesting.

M.

