Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289192AbSAIH27>; Wed, 9 Jan 2002 02:28:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289203AbSAIH2t>; Wed, 9 Jan 2002 02:28:49 -0500
Received: from mailf.telia.com ([194.22.194.25]:50144 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S289192AbSAIH2j>;
	Wed, 9 Jan 2002 02:28:39 -0500
Message-Id: <200201090728.g097SPo11772@mailf.telia.com>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: Daniel Phillips <phillips@bonn-fries.net>,
        Luigi Genoni <kernel@Expansa.sns.it>
Subject: Preemtive kernel (Was: Re: [2.4.17/18pre] VM and swap - it's really unusable)
Date: Wed, 9 Jan 2002 08:25:43 +0100
X-Mailer: KMail [version 1.3.2]
Cc: Andrea Arcangeli <andrea@suse.de>, Anton Blanchard <anton@samba.org>,
        Dieter N?tzel <Dieter.Nuetzel@hamburg.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        Rik van Riel <riel@conectiva.com.br>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@zip.com.au>, Robert Love <rml@tech9.net>
In-Reply-To: <Pine.LNX.4.33.0201082351020.1185-100000@Expansa.sns.it> <E16OCCE-0000CJ-00@starship.berlin>
In-Reply-To: <E16OCCE-0000CJ-00@starship.berlin>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(the subject has been wrong for some time now...)

On Wednesday den 9 January 2002 07.26, Daniel Phillips wrote:
> On January 9, 2002 12:02 am, Luigi Genoni wrote:
> > On Tue, 8 Jan 2002, Daniel Phillips wrote:
> > > On January 8, 2002 04:29 pm, Andrea Arcangeli wrote:
> > > > but I just wanted to make clear that the
> > > > idea that is floating around that preemptive kernel is all goodness
> > > > is very far from reality, you get very low mean latency but at a
> > > > price.
> > >
> > > A price lots of people are willing to pay
> >
> > Probably sometimes they are not making a good business.
>
> Perhaps.  But they are happy customers and their music sounds better.
>
> Note: the dominating cost of -preempt is not Robert's patch, but the fact
> that you need to have CONFIG_SMP enabled, even for uniprocessor, turning
> all those stub macros into real spinlocks.  For a dual processor you have
> to have this anyway and it just isn't an issue.
>

Well you don't - the first versions used the SMP spinlocks macros but
replaced them with own code. (basically an INC on entry and a DEC and test
when leaving)

Think about what happens on a UP
There are two cases
 - the processor is in the critical section, it can not be preempted = no
   other process can take the CPU away from it.
 - the processor is not in a critical section, no process can be executing
   inside it = can never be busy.
=> no real spinlocks needed on a UP

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
