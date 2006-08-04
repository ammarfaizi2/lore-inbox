Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161477AbWHDV1i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161477AbWHDV1i (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 17:27:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161480AbWHDV1i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 17:27:38 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57049 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1161477AbWHDV1h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 17:27:37 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Don Zickus <dzickus@redhat.com>
Cc: fastboot@osdl.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [CFT] ELF Relocatable x86 and x86_64 bzImages
References: <20060705222448.GC992@in.ibm.com>
	<aec7e5c30607051932r49bbcc7eh2c190daa06859dcc@mail.gmail.com>
	<20060706081520.GB28225@host0.dyn.jankratochvil.net>
	<aec7e5c30607070147g657d2624qa93a145dd4515484@mail.gmail.com>
	<20060707133518.GA15810@in.ibm.com>
	<20060707143519.GB13097@host0.dyn.jankratochvil.net>
	<20060710233219.GF16215@in.ibm.com>
	<20060711010815.GB1021@host0.dyn.jankratochvil.net>
	<m1d5c92yv4.fsf@ebiederm.dsl.xmission.com>
	<m1u04x4uiv.fsf_-_@ebiederm.dsl.xmission.com>
	<20060804210826.GE16231@redhat.com>
Date: Fri, 04 Aug 2006 15:25:55 -0600
In-Reply-To: <20060804210826.GE16231@redhat.com> (Don Zickus's message of
	"Fri, 4 Aug 2006 17:08:27 -0400")
Message-ID: <m164h8p50c.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don Zickus <dzickus@redhat.com> writes:

> On Mon, Jul 31, 2006 at 10:19:04AM -0600, Eric W. Biederman wrote:
>> 
>> I have spent some time and have gotten my relocatable kernel patches
>> working against the latest kernels.  I intend to push this upstream
>> shortly.
>> 
>> Could all of the people who care take a look and test this out
>> to make certain that it doesn't just work on my test box?
>
> Is there any reason to get following error on x86_64 using your patches?

There shouldn't be.

>  Filesystem type is ext2fs, partition type 0x83
> kernel /bzImage ro root=LABEL=/1 console=ttyS0,115200
> earlyprintk=ttyS0,115200
>    [Linux-bzImage, setup=0x1c00, size=0x24917c]
> initrd /initrd-2.6.18-rc3.img
>    [Linux-initrd @ 0x37e0d000, 0x1e25e7 bytes]
>
> .
> Decompressing Linux...
>
> length error
>
>  -- System halted
>
>
> I can get i386 to boot fine.  I can't for the life of me figure out what I
> am doing wrong..

The length error comes from lib/inflate.c 

I think it would be interesting to look at orig_len and bytes_out.

My hunch is that I have tripped over a tool chain bug or a weird
alignment issue.

The error is the uncompressed length does not math the stored length
of the data before from before we compressed it.  Now what is
fascinating is that our crc's match (as that check is performed first).

Something is very slightly off and I don't see what it is.

After looking at the state variables I would probably start looking
at the uncompressed data to see if it really was decompressing
properly.  If nothing else that is the kind of process that would tend
to spark a clue.

Eric

