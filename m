Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261508AbSJMMfi>; Sun, 13 Oct 2002 08:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261509AbSJMMfi>; Sun, 13 Oct 2002 08:35:38 -0400
Received: from [203.117.131.12] ([203.117.131.12]:65177 "EHLO
	gort.metaparadigm.com") by vger.kernel.org with ESMTP
	id <S261508AbSJMMfh>; Sun, 13 Oct 2002 08:35:37 -0400
Message-ID: <3DA969F0.1060109@metaparadigm.com>
Date: Sun, 13 Oct 2002 20:41:20 +0800
From: Michael Clark <michael@metaparadigm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
MIME-Version: 1.0
To: Mark Peloquin <markpeloquin@hotmail.com>
Cc: hch@infradead.org, linux-kernel@vger.kernel.org, torvalds@transmeta.com,
       evms-devel@lists.sourceforge.net
Subject: Re: [Evms-devel] Re: Linux v2.5.42
References: <F87rkrlMjzmfv2NkkSD000144a9@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13/02 01:14, Mark Peloquin wrote:
> On 2002-10-12 13:32:33, Christoph Hellwig wrote:
>
>> The problem in my eyes is that large
>> parts of what evms does should be in the higher layers, i.e. the
>> block layer, but they implement their own new layer as the consumer > of
>> those.  i.e. instead of using the generic block layer structures to
>> present a volume/device they use their own,
> 
> 
> More accurately, we do use generic block layers structures to present 
> volumes that are visible to the user/system.

Exactly. I think Christoph is comparing it to the original md
architecture thich was more of an evolutionary design on the existing
block layer - it is merely an artifact of this that intermediary
devices were present (and consuming minors) - in a well architected
volume manager, this is not necessary or desirable - not presenting
the intermediary devices is IMHO also a saftey feature preventing
access to devices that shouldn't be accessed.

>> private structures that
>> need hacks to get the access right (pass-through ioctls) and need
>> constant resyncing with the native structures in the case where we
>> have both (the lowest layer).
> 
> 
> The point of contention is that EVMS does not provide generic access 
> (block layer operations) to the components that make up the volume, but 
> only to the user/system accessible volumes themselves. EVMS consumes 
> (primarily disk) devices and produces volumes. The intermediate points 
> are abstracted by the volume manager.

Yes, considering the abstraction (and the futureproofing this provides),
it would not make sense to bind these logical nodes to the orthogonal
block layer - which would probably also make maintenance more complex
in the future. I guess one of the advantages of the EVMS approach
is the ability for the core code to fit more easily with less changes
into kernels with differing block layers (2.4,2.5,future).

~mc

