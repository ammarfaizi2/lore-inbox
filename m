Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318689AbSHAKKa>; Thu, 1 Aug 2002 06:10:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318690AbSHAKKa>; Thu, 1 Aug 2002 06:10:30 -0400
Received: from [195.63.194.11] ([195.63.194.11]:34820 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S318689AbSHAKK3>; Thu, 1 Aug 2002 06:10:29 -0400
Message-ID: <3D490894.9030506@evision.ag>
Date: Thu, 01 Aug 2002 12:08:20 +0200
From: Marcin Dalecki <dalecki@evision.ag>
Reply-To: martin@dalecki.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en, pl, ru
MIME-Version: 1.0
To: Alexander Viro <viro@math.psu.edu>
CC: Peter Chubb <peter@chubb.wattle.id.au>, Pavel Machek <pavel@ucw.cz>,
       Matt_Domsch@Dell.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.5.28 and partitions
References: <Pine.GSO.4.21.0207311832270.8505-100000@weyl.math.psu.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro wrote:
> 
> On Thu, 1 Aug 2002, Peter Chubb wrote:
> 
> 
>>Maybe we need to roll our own?  I suggest something like:
>>      struct linux_volume_header {
>>	     char  volname[16];
>>	     __u32 nparts;
>>	     __u32 blocksize;
>>	     struct linux_partition {
>>		    char partname[16]
>>		    __u64  start;
>>		    __u64  len;
>>		    __u32  usage;
>>		    __u32  flags;
>>	    } parts[]
>>    }
> 
> 
> Oh, ferchrissake!  WHY???  People, we'd seen a lot of demonstrations
> of the reasons why binary structures are *bad* for such stuff.
> 
> What the bleedin' hell is wrong with <name> <start> <len>\n - all in ASCII?  
> Terminated by \0.  No need for flags, no need for endianness crap, no
> need to worry about field becoming too narrow...
> 
> What, parsing that would be too slow?  Right.  Sure.  How many times do
> we parse partition table?  How many times do we end up reading it from
> disk?  How does IO time compare to the "overhead" of trivial sscanf loop?
> 
> Furrfu...  "ASCII is tough, let's go shopping"...

Whats wrong with ASCII processing? Easy to tell:

1. Look at bagtraq. (www.securityfocus.com)

2. It's making data *not agnostic* against i18n issues. This is 
something most people forgett about. /proc is LANG=en_US. ISO8859-1 - I
do not like this language.

3. For some as of jet undiscovered reason actual application programmers
hate processing it.

4. Answer 1. should be actually sufficient.

