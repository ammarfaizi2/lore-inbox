Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315101AbSEHUUg>; Wed, 8 May 2002 16:20:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315111AbSEHUUf>; Wed, 8 May 2002 16:20:35 -0400
Received: from smtp-out-3.wanadoo.fr ([193.252.19.233]:3302 "EHLO
	mel-rto3.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S315101AbSEHUUe>; Wed, 8 May 2002 16:20:34 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Andre Hedrick <andre@linux-ide.org>,
        Bjorn Wesen <bjorn.wesen@axis.com>, Paul Mackerras <paulus@samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] IDE 58
Date: Wed, 8 May 2002 21:49:31 +0200
Message-Id: <20020508194931.25660@smtp.wanadoo.fr>
In-Reply-To: <E175Y6N-0002Jj-00@the-village.bc.nu>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
>Please push it higher level than that. Load the taskfile as a set in
>each method. Remember its 1 potentially paired instruction to do an MMIO
>write, its a whole mess of synchronziation and stalls to do a function 
>pointer.

I though about that, but what about corner cases where only a single
register can be accessed ? (typically alt status). Provide specific
routines ? Also, how does the extended addressing works ? by writing
several times to the cyl registers ? That would have to be dealt with
as well in each host driver then.

>> address at all (that is kill the array of port addresses) but
>> just pass the taskfile_in/out functions the register number
>> (cyl_hi, cyl_lo, select, ....) as a nice symbolic constant,
>> and let the channel specific implementation figure it out.
>
>Pass  dev->taskfile_load() a struct at least for the common paths. Make the
>PIO block transfers also single callbacks for each block not word.

Right. We could go the darwin (apple) way and have taskfile_load/store
functions doing the entire registers controlled by a bitmask of which
registers has to be touched. it has a cost (testing each bit and
conditionally branching, which can suck hard) but probably less than
an indirect function call which isn't predictable.

Ben.

