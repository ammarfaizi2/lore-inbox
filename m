Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262824AbTANOqX>; Tue, 14 Jan 2003 09:46:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262913AbTANOqX>; Tue, 14 Jan 2003 09:46:23 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:22979 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262824AbTANOqW>;
	Tue, 14 Jan 2003 09:46:22 -0500
Message-ID: <001a01c2bbed$600f64a0$29060e09@andrewhcsltgw8>
From: "Andrew Theurer" <habanero@us.ibm.com>
To: "Michael Hohnbaum" <michael@hbaum.com>
Cc: "Erich Focht" <efocht@ess.nec.de>, "Martin J. Bligh" <mbligh@aracnet.com>,
       "Robert Love" <rml@tech9.net>, "Ingo Molnar" <mingo@elte.hu>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "lse-tech" <lse-tech@lists.sourceforge.net>
References: <52570000.1042156448@flay><200301101734.56182.efocht@ess.nec.de><967810000.1042217859@titus> <200301130055.28005.efocht@ess.nec.de><1042507438.24867.153.camel@dyn9-47-17-164.beaverton.ibm.com> <000201c2bb97$02bc35e0$29060e09@andrewhcsltgw8> <1042523478.30434.164.camel@kenai>
Subject: Re: [Lse-tech] Re: NUMA scheduler 2nd approach
Date: Tue, 14 Jan 2003 08:52:47 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I suppose I should not have been so dang lazy and cut-n-pasted
> the line I changed.  The change was (((5*4*this_load)/4) + 4)
> which should be the same as your second choice.
> >
> > We def need some constant to avoid low load ping pong, right?
>
> Yep.  Without the constant, one could have 6 processes on node
> A and 4 on node B, and node B would end up stealing.  While making
> a perfect balance, the expense of the off-node traffic does not
> justify it.  At least on the NUMAQ box.  It might be justified
> for a different NUMA architecture, which is why I propose putting
> this check in a macro that can be defined in topology.h for each
> architecture.

Yes, I was also concerned about one task in one node and none in the others.
Without some sort of constant we will ping pong the task on every node
endlessly, since there is no % threshold that could make any difference when
the original load value is 0..  Your +4 gets rid of the 1 task case.

-Andrew

