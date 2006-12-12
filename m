Return-Path: <linux-kernel-owner+w=401wt.eu-S932482AbWLLWeW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbWLLWeW (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 17:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWLLWeW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 17:34:22 -0500
Received: from smtpout.mac.com ([17.250.248.177]:58365 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932482AbWLLWeV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 17:34:21 -0500
In-Reply-To: <Pine.LNX.4.64.0612121008490.3535@woody.osdl.org>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org> <320BD259-74D6-411F-82A4-4BF3CB15012F@mac.com> <Pine.LNX.4.64.0612120815550.6452@woody.osdl.org> <D571C4CB-3D52-446C-802E-024C4C333562@mac.com> <Pine.LNX.4.64.0612121008490.3535@woody.osdl.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0B8F288E-4FCD-409E-9BA2-C524CF31E9A3@mac.com>
Cc: LKML Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Mach-O binary format support and Darwin syscall personality [Was: uts banner changes]
Date: Tue, 12 Dec 2006 17:34:11 -0500
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-12_05:2006-12-12,2006-12-12,2006-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0612050001 definitions=main-0612120027
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 12, 2006, at 13:20:19, Linus Torvalds wrote:
> That said, powerpc simply doesn't historically do any system call  
> translation, so you'll just have to implement the same kind of  
> translation layer that sparc has done, for example.

Thanks a lot for all your help.  I've got two last questions:  From  
the code in entry_32.s I can dig up "current" from ((struct  
paca_struct *)r13)->__current to read a personality flag from it,  
right?  Digging up offsets in assembly can't be very fun :-\   
Secondly, is there a preferred existing field into which I should  
stick said flag or just stuff it somewhere?

This part seems like the easiest so far; no icky binary format  
parsing, no confusing memory maps.  Thanks once again!

>> So I guess all I have to do is:
>>  (A)  Write a bunch of new syscall handlers taking arguments of  
>> the same types
>> as the Darwin syscall handlers,
>
> Yes. The big issue tends to be to translate all the errno's and the  
> fcntl structure pointers etc. THAT can be quite painful indeed. You  
> might ask David Miller and company about their SunOS stuff, and  
> look at things like
>
> 	arch/sparc/kernel/{sys_sunos.c,sunos_ioctl.c}
>
> for some sorry examples.

Ok, I figured it was going to be ugly; maybe not quite _that_ ugly  
but my hopes weren't high enough for you to dash to any real degree :-D.

Cheers,
Kyle Moffett

