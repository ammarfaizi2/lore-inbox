Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263786AbRFMOSU>; Wed, 13 Jun 2001 10:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263799AbRFMOSK>; Wed, 13 Jun 2001 10:18:10 -0400
Received: from phil.iph.to ([212.98.162.99]:59664 "EHLO iph.to")
	by vger.kernel.org with ESMTP id <S263786AbRFMOSE>;
	Wed, 13 Jun 2001 10:18:04 -0400
Message-ID: <3B27760F.41A0635D@iph.to>
Date: Wed, 13 Jun 2001 17:17:51 +0300
From: Philips <philips@iph.to>
Organization: Enformatica Ltd. UK
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: threading question
In-Reply-To: <200106121858.f5CIwmX05650@ns.caldera.de> <Pine.LNX.4.30.0106121304320.24593-100000@gene.pbi.nrc.ca> <20010613142026.B13623@garloff.etpnet.phys.tue.nl> <20010613153528.A1711@werewolf.able.es>
Content-Type: multipart/mixed;
 boundary="------------3006D001D73B57A507C2EBB5"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------3006D001D73B57A507C2EBB5
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"J . A . Magallon" wrote:
> 
> On 20010613 Kurt Garloff wrote:
> >
> > What I do in my numerics code to avoid this problem, is to create all the
> > threads (as many as there are CPUs) on program startup and have then wait
> > (block) for a condition. As soon as there's something to to, variables for
> > the thread are setup (protected by a mutex) and the thread gets signalled
> > (cond_signal).
> > If you're interested in the code, tell me.
> >
> 
> I use the reverse approach. you feed work to the threads, I create the threads
> and let them ask for work to a master until it says 'done'. When the
> master is queried for work, it locks a mutex, decide the next work for
> that thread, and unlocks it. I think it gives the lesser contention and
> is simpler to manage.
> 

	BTW. 
	Question was poping in my mind and finally got negative answer by my mind ;-)

	Is it possible to make somethis like:


	char a[100] = {...}
	char b[100] = {...}
	char c[100];
	char d[100];
	
	1: { // run this on first CPU
		for (int i=0; i<100; i++) c[i] = a[i] + b[i];
	};
	2: { // run this on any other CPU
		for (int i=0; i<100; i++) d[i] = a[i] * b[i];
	};
	
	...
	// do something else...
	...
	
	wait 1,2; // to be sure c[] and d[] are ready.


	what was popping in my mind - some prefix (like 0x66 Intel used for 32
instructions) to say this instruction should run on other CPU?
	I know - stupid idea. Too many questions will arise. 
	If we will do 

	PREFIX jmp far some_routing

	and this routing will run on other CPU not blocking current execution thread.
	(who will clean stack? when?.. question without answers...)

	Is there anything like this in computerworld? I heard about old computers that
have a speacial instruction set to implicit run code on given processor.
	Is it possible to emulate this behavior on PCs?
--------------3006D001D73B57A507C2EBB5
Content-Type: text/x-vcard; charset=us-ascii;
 name="philips.vcf"
Content-Transfer-Encoding: 7bit
Content-Description: Card for Philips
Content-Disposition: attachment;
 filename="philips.vcf"

begin:vcard 
n:Filiapau;Ihar
tel;pager:+375 (0) 17 2850000#6683
tel;fax:+375 (0) 17 2841537
tel;home:+375 (0) 17 2118441
tel;work:+375 (0) 17 2841371
x-mozilla-html:TRUE
url:www.iph.to
org:Enformatica Ltd.;Linux Developement Department
adr:;;Kalinine str. 19-18;Minsk;BY;220012;Belarus
version:2.1
email;internet:philips@iph.to
title:Software Developer
note:(none)
x-mozilla-cpt:;18368
fn:Philips
end:vcard

--------------3006D001D73B57A507C2EBB5--

