Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129197AbRBDQQU>; Sun, 4 Feb 2001 11:16:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129092AbRBDQQJ>; Sun, 4 Feb 2001 11:16:09 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:41741 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S129197AbRBDQP5>; Sun, 4 Feb 2001 11:15:57 -0500
Message-ID: <07E6E3B8C072D211AC4100A0C9C5758302B2711B@hasmsx52.iil.intel.com>
From: "Hen, Shmulik" <shmulik.hen@intel.com>
To: "'Manfred'" <manfred@colorfullife.com>,
        "Hen, Shmulik" <shmulik.hen@intel.com>
Cc: "'LKML'" <linux-kernel@vger.kernel.org>
Subject: RE: kernel memory allocations alignment
Date: Sun, 4 Feb 2001 08:15:39 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually yes. We were warned that on IA64 architecture the system will halt
when accessing any type of variable via a pointer if the pointer does not
contain an aligned address matching that type. Until now we were using a
method of receiving a pointer to an array, casting it to a pointer of a
struct (packed with #pragma pack(1) ) ,and retrieving fields directly from
it with pointers.
It seems we cannot do that any more and were wondering what are the
alternatives.
One way we could think of is forget the packing and rearrange the fields in
the struct in descending order so they all come out aligned, but we didn't
know for sure if the first one will be aligned too.

Will that work ?


	Thanks,
	Shmulik Hen      
      Software Engineer
	Linux Advanced Networking Services
	Intel Network Communications Group
	Jerusalem, Israel

-----Original Message-----
From: Manfred [mailto:manfred@colorfullife.com]
Sent: Sunday, February 04, 2001 5:56 PM
To: Hen, Shmulik
Cc: 'LKML'
Subject: Re: kernel memory allocations alignment


"Hen, Shmulik" wrote:
> 
> When using kmalloc(size_t size), do I get a guaranty that the memory
region
> allocated is aligned according to the size specified ?
> More to the point, if I call kmalloc for type int on an IA64 architecture
is
> the pointer going to be 8 bytes aligned ?
>

Yes, kmalloc results are always 'sizeof(void*)' aligned.

Do you have stricter alignment requirements?

--
	Manfred

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
