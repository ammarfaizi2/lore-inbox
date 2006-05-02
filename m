Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750764AbWEBJ32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750764AbWEBJ32 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 05:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750789AbWEBJ32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 05:29:28 -0400
Received: from mtagate4.de.ibm.com ([195.212.29.153]:19061 "EHLO
	mtagate4.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750764AbWEBJ32 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 05:29:28 -0400
In-Reply-To: <17489.18630.75412.66803@cargo.ozlabs.ibm.com>
Subject: Re: [PATCH 13/16] ehca: firmware InfiniBand interface
To: Paul Mackerras <paulus@samba.org>
Cc: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Marcus Eder <MEDER@de.ibm.com>, openib-general@openib.org,
       schihei@de.ibm.com
X-Mailer: Lotus Notes Release 7.0 HF85 November 04, 2005
Message-ID: <OF38200CFC.0F39484B-ONC1257162.003179ED-C1257162.0033A003@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Tue, 2 May 2006 11:30:35 +0200
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.53HF654 | July 22, 2005) at
 02/05/2006 11:30:35
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
Content-transfer-encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

We started like that to get a clean interface between the register
intensive h_calls and the driver code.
We're in the middle of the tradeoff  "nice interface" vs strict fencing of
data structures from one code piece to another.
Initially these functions, which only move paramaters from the stack into
registers and back, were inline functions.
So the compiler collapsed the function call into "nothing", which won't
work if you use a struct *.
Somewhen during code reviews people agreed that having this many inline
functions leads to large header files
which isn't a good idea either.

We're about to change that interface again, so what should be the max
number of parameters in a function call?
The limit in existing kernel code is somewhere between 5-8
(just as a reminder, 8 is the max nr of parameters to be passed by register
on ppc)


christoph raisch

Paul Mackerras <paulus@samba.org> wrote on 28.04.2006 00:42:14:

> Jörn Engel writes:
>
> > 25 parameters?  If you tell me which drugs were involved in this code,
> > I know what to stay away from.
>
> You really need to ask the firmware architects that, since this is
> basically a single firmware call.
>
> Mind you, since a lot of the parameters are used to return individual
> bytes or half-words, which are then put into structures, it might be
> better to pass the pointers to the structures and let the wrapper put
> the values straight into the structures.
>
> Paul.

