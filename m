Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262801AbUCOW5m (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 17:57:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262667AbUCOWzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 17:55:04 -0500
Received: from fmr06.intel.com ([134.134.136.7]:17886 "EHLO
	caduceus.jf.intel.com") by vger.kernel.org with ESMTP
	id S262859AbUCOWxB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 17:53:01 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: PATCH - InfiniBand Access Layer (IBAL)
Date: Mon, 15 Mar 2004 14:52:44 -0800
Message-ID: <1AC79F16F5C5284499BB9591B33D6F000B4805@orsmsx408.jf.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: PATCH - InfiniBand Access Layer (IBAL)
Thread-Index: AcQKMs1kvCcYzRhRTpu/BwrN2E0JuAAoHijgAAG+piA=
From: "Woodruff, Robert J" <woody@co.intel.com>
To: "Greg KH" <greg@kroah.com>, "Woodruff, Robert J" <woody@jf.intel.com>
Cc: <linux-kernel@vger.kernel.org>, "Hefty, Sean" <sean.hefty@intel.com>,
       "Coffman, Jerrie L" <jerrie.l.coffman@intel.com>,
       "Davis, Arlin R" <arlin.r.davis@intel.com>
X-OriginalArrivalTime: 15 Mar 2004 22:52:44.0992 (UTC) FILETIME=[3ADFE400:01C40AE0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 14, Greg KH wrote:

First, As my boss remined me this morning,
let me make sure I was clear, there are not 2 different efforts now,
only one, openib.org. 

1) OpenIB represents a number of companies coming together with lots of
InfiniBand source code, 
with duplicate code for the access layer and most of the ULPs
2) the SourceForge work is already part of this
3) the foundation of infiniband support will be the Access Layer, so it
needs the community's feedback first
4) we are looking for feedback on both the access layer code in the
current openib snapshot and the access layer code that we submitted a
few weeks ago 
to learn which is more acceptable to the community.

Now to answer a couple specific questions. 

>Hm, without open source drivers, the Intel stack doesn't seem very 
>viable, correct?

Correct, that is why we hope that Mellanox contributes their driver for
IBAL to open source. 

>> The comments you have given on IBAL would probably only take a few
>> weeks to change.
>Is that work already underway?  Finished?  If neither, why not?

Work is, or at least was underway, but
we put it aside last week to review the rest of the code now in
openib.org.
We also need an open source driver.

>What are the issues with the OpenIB stack?  

As I stated above, we are part of the openib.org collaboration and 
will be working on helping develop a stack that is "best of
breed" from all of the available code. Starting from the bottom up, 
we first need to review the various proposals for the 
Access Layer and determine which code base to start with. 
The initial agreement was to use the 
TopSpin code for an access layer. This agreement was made before anyone
got to see any code. 
After review of this code, we think it needs a lot of work. We were
waiting for the openib.org email lists to open and sending in comments
there.
That way we could work a lot of details offline from lkml, since 
lots of discussion will be needed. 

But since you asked here are a few,

1.) The tsapi APIs look like Windows APIs (at least in the original
drop)
2.) Looking at the API specification document, 
It is missing lots of verbs required by the InfiniBand Specification
CloseCA, ModifyAV, QueryCQ, CreateEEC, ModifyEEC, QueryEEC, 
DestroyEEC, QueryMR, ReregisterMR, ReregisterPhysMR, RegisterSharedMR, 
AllocMW, QueryMW, BindMW, and FreeMW
3.) The code is not compliant with the InfiniBand specification and has
proprietary
implementations of things like "path records" so it will only work with
the 
TopSpin subnet manager that requires you to buy a topspin switch.
4.) Not sure if they have fixed this yet in the 2.6 code, but the 2.4
code 
has like 18 different loadable modules. This could probably be collapsed
into 5, one for the HCA driver, one for the access layer, one for the
IPoIB driver, one for the SRP driver and one for the SDP driver. 
5.) There is no user-mode access layer requiring ULPs to code to the HCA

user-mode driver APIs directly. 
This will mean that new user mode ULPs will need to be 
developed for each new HCA that comes along. 
6.)The VAPI code has extra propietary verbs that are not specified by
the InfiniBand 
Specification. 
7.) The implementation is deficient in it's support for InfiniBand
management
services, like the required RMPP protocol, MAD services, SA query helper
functions. 
8.) Some of the message fields of the CM are hard coded. 
9.) The CM does not support reliable datagrams. 
10) There is no built in support for plug and play events, port up/down,
LID change, SM change,
11) VAPI call stack is deep and puts a lot of big data structure on the
stack. 

There is more, but as I stated before, we suggest discussing most of
these issues within
openib.org first, trying to come to agreement on what is best and then
review our 
suggestions with lkml to make sure we are one track. 

>If there are any, how does the Intel stack solve those 
>issues?  

The SourceForge code IBAL(not just developed by Intel but has
contributions from several companies,
including InfiniCon, Mellanox, Fujitsu and Intel) 
is feature complete and compliant with the InfiniBand specification. It
may not be quite as
hardened as the TopSpin stack, but that gap is rapidly closing. 
We'd also like to know from the other openib.org people, 
What are the issues with the SourceForge IBAL ? 

We know the issues raised by lkml and think these can be fixed. 

The biggest problem I see is that we do not have an open source HCA
driver
and that could be fixed too, if Mellanox wanted to, or someone could
take the VAPI code they open sourced and port it to IBAL. 

>Could the Intel solutions be merged 
>into the OpenIB stack to solve these issues?

Given there are so many issues with the TSAPI, would it be easier to 
fix the issues lkml raised with IBAL and port the "best of breed" ULPs
to it ?
Since all the tsAPIs will have to change anyway, to non-Windows-ize
them, 
all the ULPs will need to be re-ported again anyway. 

