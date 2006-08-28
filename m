Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932375AbWH1D27@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbWH1D27 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 23:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbWH1D27
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 23:28:59 -0400
Received: from ms-smtp-02.socal.rr.com ([66.75.162.134]:1727 "EHLO
	ms-smtp-02.socal.rr.com") by vger.kernel.org with ESMTP
	id S932375AbWH1D27 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 23:28:59 -0400
Message-Id: <6.2.3.4.0.20060827202250.04911d70@pop-server.san.rr.com>
X-Mailer: QUALCOMM Windows Eudora Version 6.2.3.4
Date: Sun, 27 Aug 2006 20:28:44 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
From: John Coffman <johninsd@san.rr.com>
Subject: Re: [PATCH] THE LINUX/I386 BOOT PROTOCOL - Breaking the 256
  limit (ping)
Cc: Andi Kleen <ak@suse.de>, Alon Bar-Lev <alon.barlev@gmail.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       johninsd@san.rr.com, Matt_Domsch@dell.com
In-Reply-To: <44F21122.3030505@zytor.com>
References: <445B5524.2090001@gmail.com>
 <200608272116.23498.ak@suse.de>
 <44F1F356.5030105@zytor.com>
 <200608272254.13871.ak@suse.de>
 <44F21122.3030505@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Antivirus: avast! (VPS 0634-2, 08/24/2006), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LILO memory usage:

000600 - 001000 BIOS data check area.  Okay to overwrite.  LILO usage 
suppressed with command line "nobd" option.  There's also a config 
file option to suppress usage.

LILO typically loads at 9000:0000 up to the top of the EBDA.  Top of 
EBDA is determined by "int 12h."  Some BIOS's on add-in cards do not 
properly allocate the EBDA.  Use LILO Makefile option "BUG_SI_EBDA" 
to allocate extra EBDA for the BIOS.  If the BIOS data check area is 
created at boot time by LILO, then:

    >  lilo -T ebda

will tell you where LILO is loaded on your system.

--John


At 02:39 PM  Sunday 8/27/2006, H. Peter Anvin wrote:
>Andi Kleen wrote:
>>On Sunday 27 August 2006 21:32, H. Peter Anvin wrote:
>>>Andi Kleen wrote:
>>>>Just increasing that constant caused various lilo setups to not boot
>>>>anymore. I don't know who is actually to blame, just wanting to
>>>>point out that this "obvious" patch isn't actually that obvious.
>>>How would that even be possible (unless you recompiled LILO with 
>>>the new headers)?  There would be no difference in the memory 
>>>image at the point LILO hands off to the kernel.
>>AFAIK the problem was that some EDD data got overwritten.
>>
>>>In order to reproduce this we need some details about your 
>>>"various LILO setups", or this will remain as a source of cargo 
>>>cult programming.
>>You can search the mailing list archives, it's all in there if you don't
>>belive me.
>
>Found the references.  This seems to imply that EDD overwrites the 
>area used by LILO 22.6.1.  LILO 22.6.1 uses the new boot protocol, 
>with the full pointer, and seems to obey the spec as far as I can 
>read the code.  I'm going to try to run it in simulation and observe 
>the failure that way.
>
>However, something is still seriously out of joint.  The EDD data 
>actually overlays the setup code, not the bootsect code, and thus 
>there "shouldn't" be any way that this could interfere.  My best 
>guess at this time is that either the EDD code or LILO uses memory 
>it's not supposed to use, and the simulation should hopefully reveal that.
>
>Sorry if I seem snarky on this, but if we can't get to the bottom of 
>this we can't ever fix it.
>
>         -hpa


         PGP KeyID: 6781C9C8  (good until 31-Dec-2008)
         Keyserver at  ldap://keyserver.pgp.com  OR  http://pgp.mit.edu
         LILO links at http://freshmeat.net/projects/lilo
         and Help link at http://lilo.go.dyndns.org


