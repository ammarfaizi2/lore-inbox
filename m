Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262500AbTBXXmy>; Mon, 24 Feb 2003 18:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262806AbTBXXmy>; Mon, 24 Feb 2003 18:42:54 -0500
Received: from otter.mbay.net ([206.55.237.2]:14097 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S262500AbTBXXmx> convert rfc822-to-8bit;
	Mon, 24 Feb 2003 18:42:53 -0500
From: John Alvord <jalvo@mbay.net>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Andreas Schwab <schwab@suse.de>, Linus Torvalds <torvalds@transmeta.com>,
       "Richard B. Johnson" <root@chaos.analogic.com>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (7/13): gcc 3.3 adaptions.
Date: Mon, 24 Feb 2003 15:52:20 -0800
Message-ID: <rrbl5v47rm3o9ltc4iegc1i6nc9fuqgapk@4ax.com>
References: <Pine.LNX.4.44.0302241259320.13406-100000@penguin.transmeta.com> <jeznol5plv.fsf@sykes.suse.de> <20030224173934.T3910@devserv.devel.redhat.com>
In-Reply-To: <20030224173934.T3910@devserv.devel.redhat.com>
X-Mailer: Forte Agent 1.92/32.570
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Feb 2003 17:39:34 -0500, Jakub Jelinek <jakub@redhat.com>
wrote:

>On Mon, Feb 24, 2003 at 10:35:24PM +0100, Andreas Schwab wrote:
>> Linus Torvalds <torvalds@transmeta.com> writes:
>> 
>> |> Does gcc still warn about things like
>> |> 
>> |> 	#define COUNT (sizeof(array)/sizeof(element))
>> |> 
>> |> 	int i;
>> |> 	for (i = 0; i < COUNT; i++)
>> |> 		...
>> |> 
>> |> where COUNT is obviously unsigned (because sizeof is size_t and thus 
>> |> unsigned)?
>> |> 
>> |> Gcc used to complain about things like that, which is a FUCKING DISASTER. 
>> 
>> How can you distinguish that from other occurrences of (int)<(size_t)?
>
>Value range propagation pass, then warn?

I know it is stupid/unnecessary etc, but you could do

#if COUNT > INT_MAX
#error you idiot... 
#endif

	int i;
	for(i =0; i < (int)COUNT; i++)
	...

where the #if was placed in whatever header COUNT was defined.

and have safe code with no runtime overhead and looking only mildly
idiotic.

john alvord
