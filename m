Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129097AbQJaVC7>; Tue, 31 Oct 2000 16:02:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130517AbQJaVCu>; Tue, 31 Oct 2000 16:02:50 -0500
Received: from otter.mbay.net ([206.40.79.2]:52754 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S129097AbQJaVCn> convert rfc822-to-8bit;
	Tue, 31 Oct 2000 16:02:43 -0500
From: jalvo@mbay.net (John Alvord)
To: Peter Samuelson <peter@cadcamlab.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Keith Owens <kaos@ocs.com.au>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: test10-pre7
Date: Tue, 31 Oct 2000 21:01:04 GMT
Message-ID: <3a013178.6803918@mail.mbay.net>
In-Reply-To: <11462.972947019@ocs3.ocs-net> <Pine.LNX.4.10.10010301508360.1085-100000@penguin.transmeta.com> <20001031055959.A1041@wire.cadcamlab.org>
In-Reply-To: <20001031055959.A1041@wire.cadcamlab.org>
X-Mailer: Forte Agent 1.5/32.451
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000 05:59:59 -0600, Peter Samuelson
<peter@cadcamlab.org> wrote:

>
>[Linus]
>> In short, we should _remove_ all traces of stuff like
>> 
>> 	O_OBJS = $(filter-out $(export-objs), $(obj-y))
>> 
>> It's wrong.
>> 
>> We should just have
>> 
>> 	O_OBJS = $(obj-y)
>> 
>> which is always right.
>
>This part I agree with..
>
>> And it should make all this FIRST/LAST object file mockery a total
>> non-issue, because the whole concept turns out to be completely
>> unnecessary.
>> 
>> Is there anything that makes this more complex than what I've
>> outlined above?
>
>One thing.  The main benefit of $(sort), which I haven't heard you
>address yet, is to remove duplicate files.  Think about 8390.o, and how
>many net drivers require it.  There are two ways to handle this:
>
>  obj-$(CONFIG_WD80x3) += wd.o 8390.o
>  obj-$(CONFIG_EL2) += 3c503.o 8390.o
>  obj-$(CONFIG_NE2000) += ne.o 8390.o
>  obj-$(CONFIG_NE2_MCA) += ne2.o 8390.o
>  obj-$(CONFIG_HPLAN) += hp.o 8390.o
>
You can avoid duplicates with
  obj-$(CONFIG_WD80x3) += wd.o
  ifneq (,$(findstring 8390.o,obj-$(CONFIG_WD80x3))
     obj-$(CONFIG_WD80x3) += 8390.o
  endif
 
Which is wordy but accomplishes the objective of avoiding duplicates.

john alvord
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
