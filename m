Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287417AbRL3Non>; Sun, 30 Dec 2001 08:44:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287407AbRL3Noe>; Sun, 30 Dec 2001 08:44:34 -0500
Received: from web1.oops-gmbh.de ([212.36.232.3]:50962 "EHLO
	sabine.freising-pop.de") by vger.kernel.org with ESMTP
	id <S287399AbRL3NoT>; Sun, 30 Dec 2001 08:44:19 -0500
Message-ID: <3C2F18A5.B50792F0@sirius-cafe.de>
Date: Sun, 30 Dec 2001 14:37:41 +0100
From: Martin Knoblauch <knobi@sirius-cafe.de>
Reply-To: knobi@knobisoft.de
Organization: Knobisoft :-), Freising
X-Mailer: Mozilla 4.6 [en] (X11; I; IRIX 6.5 IP22)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: andihartmann@freenet.de
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Re: [2.4.17/18pre] VM and swap - it's really unusable
> 
> 
> My observation:
> Why does the kernel swap to get free memory for caching / buffering? I
> can't see any sense in this action. Wouldn't it be better to shrink the
> cashing / buffering-RAM to the amount of memory, which is obviously free?
> 
> Swapping should be principally used, if the RAM ends for real memory
> (memory, which is used for running applications). First of all, the
> memory-usage of cache and buffers should be reduced before starting to
> swap IMHO.
>

 My main "problem" with 2.4 as well. Using free memory for Cache/Buffers
is great, but only as long as the memory is not needed for running
tasks. As soon as a task is requesting more memory, it should be first
taken from Cache/Buffer (they are caches, aren't they :-). Only if this
has been used up (to a tunable minimum, see below), swapping and finally
OOM killing should happen.

 To prevent completely trashing IO performance, there should be tunable
parameters for minimum and maximum Cache/Buffer usage (lets say in
percent of total memory). Maybe those tunables are even there today and
I am just to stupid to find them :-))

 In any case, 2.4 Caches/Buffers show to much persistance. This is
basically true for both branches of VM. I was using the -ac kernels
because, being far from perfect, the VM gave considreabele better
interactive behaviour.

> Or would it be possible, to implement more than one swapping strategy,
> which could be configured during make menuconfig? This would give the
> user the chance to find the best swapping strategy for his purpose.
> 

 That is another option. But I would prefer something that could be
selected dynamically or at boot time.

Martin
-- 
+-----------------------------------------------------+
|Martin Knoblauch                                     |
|-----------------------------------------------------|
|http://www.knobisoft.de/cats                         |
|-----------------------------------------------------|
|e-mail: knobi@knobisoft.de                           |
+-----------------------------------------------------+
