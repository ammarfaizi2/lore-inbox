Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287838AbSABPLG>; Wed, 2 Jan 2002 10:11:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287836AbSABPK4>; Wed, 2 Jan 2002 10:10:56 -0500
Received: from dsl-65-186-161-49.telocity.com ([65.186.161.49]:37134 "EHLO
	nic.osagesoftware.com") by vger.kernel.org with ESMTP
	id <S287838AbSABPKr>; Wed, 2 Jan 2002 10:10:47 -0500
Message-Id: <4.3.2.7.2.20020102100856.00e78f00@mail.osagesoftware.com>
X-Mailer: QUALCOMM Windows Eudora Version 4.3.2
Date: Wed, 02 Jan 2002 10:10:42 -0500
To: linux-kernel@vger.kernel.org
From: David Relson <relson@osagesoftware.com>
Subject: Re: CML2 funkiness
Cc: "Andrew Rodland" <arodland@noln.com>, "Eric S. Raymond" <esr@thyrsus.com>
In-Reply-To: <web-54668623@admin.nni.com>
In-Reply-To: <200201010217.g012H2d00406@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:03 AM 1/2/02, Andrew Rodland wrote:
>First off, I'd like to apologize for lack of all the
>  information I'd like to have, I'm at school, and
>  temporarily semidisconnected at home.
>
>CML2 is definitely still not quite right for me
>(2.4.17 + kpreempt-rml, latest CML2 as of 3ish days ago).
>
>Menuconfig and friends seem okay, as far as I can tell (and
>  they've apparently been tested pretty well), but oldconfig
>  is wacky...
>
>So, "mv config .config ; make mrproper ; mv config .config
>  ; make oldconfig" does odd things to my config, but more
>  in-your-face, on "make oldconfig ; make oldconfig" (ad
>  inifinitum if you want), it will continue asking the same
>  questions, and never remember the answer.

Andrew,

I have just tested this, and have reproduced your problem.  Using 
kernel-2.4.16 and cml2-1.2.20, i.e. my current kernel and the latest CML2, 
I ran "make oldconfig" three times.  The first time I answered "n" to 21 
queries.  The second and third times, I had to answer "n" to 9 
queries.  The 9 all appeared in the first run and were exactly the same in 
the second and third runs.

Here're the 9 queries from runs 2 and 3:
EXPERT: Prompt for expert choices (those with no help attached) 
(EXPERIMENTAL) [ ] (NEW)?:
DEVELOPMENT: Configure a development or 2.5 kernel? (EXPERIMENTAL) [ ] (NEW)?:
CD_NO_IDESCSI: Support CD-ROM drives that are not SCSI or IDE/ATAPI [ ] 
(NEW)?:
IP_ADVANCED_ROUTER: Advanced router [ ] (NEW)?:
NET_VENDOR_SMC: Western Digital/SMC cards [ ] (NEW)?:
NET_VENDOR_RACAL: Racal-Interlan (Micom) NI cards [ ] (NEW)?:
NET_POCKET: Pocket and portable adapters [ ] (NEW)?:
HAMRADIO: Amateur Radio support [ ] (NEW)?:
FBCON_FONTS: Select other compiled-in fonts [ ] (NEW)?:

 From past testing of CML2 I know it uses file config.out as its 
"memory".  Looking in it, I didn't see any CONFIG symbols for these symbols.

There's definitely something here for Eric to fix!

David


