Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317308AbSFCIJp>; Mon, 3 Jun 2002 04:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317309AbSFCIJo>; Mon, 3 Jun 2002 04:09:44 -0400
Received: from mail.loewe-komp.de ([62.156.155.230]:25354 "EHLO
	mail.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S317308AbSFCIJn>; Mon, 3 Jun 2002 04:09:43 -0400
Message-ID: <3CFB24BA.4000404@loewe-komp.de>
Date: Mon, 03 Jun 2002 10:11:38 +0200
From: Peter =?ISO-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: de, en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Andreas Hartmann <andihartmann@freenet.de>, linux-kernel@vger.kernel.org
Subject: Re: Memory management in Kernel 2.4.x
In-Reply-To: <fa.iklie8v.5k2hbj@ifi.uio.no> <fa.na0lviv.e2a93a@ifi.uio.no> <actahk$6bp$1@ID-44327.news.dfncis.de> <3CF23893.207@loewe-komp.de> <20020531211951.GZ1172@dualathlon.random>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> On Mon, May 27, 2002 at 03:45:55PM +0200, Peter Wächtler wrote:
> 
>>Andreas Hartmann wrote:
>>
>>>Zwane Mwaikambo wrote:
>>>
>>>
>>>
>>>>On Mon, 27 May 2002, Andreas Hartmann wrote:
>>>>
>>>>
>>>>
>>>>>rsync allocates all of the memory the machine has (256 MB RAM, 128 MB
>>>>>swap). When this occures, processes get killed like described in the
>>>>>posting before. The machine doesn't respond as long as the rsync -
>>>>>process isn't killed, because it fetches all the memory which gets free
>>>>>after a process has been killed.
>>>>>
>>>>>
>>>>And the rsync process never gets singled out? nice!
>>>>
>>>>
>>>Until it's killed by the kernel (if overcommitment isn't deactivated). If 
>>>overcommitment is deactivated, the services of the machine are dead 
>>>forever. There will be nothing, which kills such a process. Or am I wrong?
>>>
>>>
>>There is still the oom killer (Out Of Memory).
>>But it doesn't trigger and the machine pages "forever".
>>Usually kswapd eats the CPU then, discarding and reloading pages,
>>searching lists for pages to evict and so on.
>>
> 
> can you reproduce with 2.4.19pre9aa2? I expect at least the deadlock
> (if it's a deadlock and not a livelock) should go away.
> 
> Also I read in another email that somebody grown the per-socket buffer
> to hundred mbytes, if you do that on a 32bit arch with highmem you'll
> run into troubles, too much ZONE_NORMAL ram will be constantly pinned
> for the tcp pipeline and the machine can enter livelocks.
> 

Sorry for the confusion.
I was just trying to explain that without overcommitment there would be
the "normal" OOM handling. But I don't know this feature from the -ac
kernels. Am I wrong?

It's Andreas who has the problem with rsync being killed and the machine
seems to hang.
But I still think that the buffer cache has to be better restricted.
The vm is caching far too aggressively (but I never tried with -aa)

