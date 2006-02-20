Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161031AbWBTQpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161031AbWBTQpG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 11:45:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161023AbWBTQpF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 11:45:05 -0500
Received: from ausc60ps301.us.dell.com ([143.166.148.206]:30574 "EHLO
	ausc60ps301.us.dell.com") by vger.kernel.org with ESMTP
	id S1161029AbWBTQpD convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 11:45:03 -0500
DomainKey-Signature: s=smtpout; d=dell.com; c=nofws; q=dns; b=zKPdrExsFQ9lXoPB7bRu83Ts+/AAzEd7ADvMG/+VmfLhQcq4fs/VIsD1gXdaLawyeQAonJcvYsVSTtu0MveHFnzo4RYtj70EeM++RTMg50aUgA3UfWE2T8Ky0sNperzb;
X-IronPort-AV: i="4.02,131,1139205600"; 
   d="scan'208"; a="47537952:sNHT210071818"
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Date: Mon, 20 Feb 2006 10:45:02 -0600
Message-ID: <35C9A9D68AB3FA4AB63692802656D9EC927875@ausx3mps303.aus.amer.dell.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] [RESEND] Add Dell laptop backlight brightness display
Thread-Index: AcY0iozPf3b1SoksTCGFxEivPtaC3QBsPImQ
From: <Michael_E_Brown@Dell.com>
To: <pavel@ucw.cz>
Cc: <mjg59@srcf.ucam.org>, <akpm@osdl.org>, <Matt_Domsch@Dell.com>,
       <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 20 Feb 2006 16:45:03.0047 (UTC) FILETIME=[FEFB7D70:01C6363C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel,
	Matthew has shown up on the libsmbios-devel mailing list. I sent
all the
info needed to do a test of Dell LCD brightness control. The main thing
left
would be to make one utility out of the current separate, unsupported,
test 
utils. 

	As for fixing i8k, I don't have the slightest clue where to
begin. You 
either have to split initialization with userspace to parse and send in
the 
correct io/magic ports to do SMI, or you have to put Dell-specific SMI
token 
parsing in the kernel.

	If somebody wants to discuss the design, I can definetly
discuss. I 
even have a _very_ rough mockup of userspace code to do this. Did not
take
it further because I don't know enough about lmsensors or how to fix
i8k.
--
Michael

PS> sorry for top-posting, my non-broken email client at home for some
reason 
could not see your msg, so I could not reply from there.

-----Original Message-----
From: Pavel Machek [mailto:pavel@ucw.cz] 
Sent: Sunday, February 12, 2006 11:26 AM
To: Brown, Michael E
Cc: mjg59@srcf.ucam.org; akpm@osdl.org; Domsch, Matt;
linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [RESEND] Add Dell laptop backlight brightness
display

Hi!

> You can get and set laptop brighness on Dell with the proper SMI call.
> 
> To do the proper SMI call requires parsing SMBIOS structure 0xDA, a 
> vendor-proprietary structure, and getting the SMI index and io port 
> and magic values. Then, you need to know how to setup the registers 
> and input/output buffers for the call. All of this is already present 
> in libsmbios.

Perhaps authors of libsmbios could help here?

> Reading nvram is not a valid way to get brighness unless you also do 
> similar work (parse specific vendor-proprietary SMBIOS structures) to 
> ensure that you are reading the correct location. This location is 
> subject to change from BIOS to BIOS and machine to machine. The fact 
> that you may have observed it in the same location on a few laptops 
> does not change this fact.

Well, folks reverse-engineering your machines had no idea until now...

> In fact, I have the same objection to the I8K driver in the kernel. It

> has hardcoded SMI calls, that are subject to change. There is a proper

> way to get the correct IO ports to make this safe, but it is not 
> currently being done.

Could you or someone at Dell submit patches to correct this?
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms
