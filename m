Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264541AbUEJG0B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264541AbUEJG0B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 02:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUEJG0B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 02:26:01 -0400
Received: from users.linvision.com ([62.58.92.114]:39060 "HELO bitwizard.nl")
	by vger.kernel.org with SMTP id S264541AbUEJGZ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 02:25:57 -0400
Date: Mon, 10 May 2004 08:25:56 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Chris Friesen <cfriesen@nortelnetworks.com>
Cc: Marc Boucher <marc@linuxant.com>, Sean Estabrooks <seanlkml@rogers.com>,
       david@gibson.dropbear.id.au, Jeff Garzik <jgarzik@pobox.com>,
       miller@techsource.com, riel@redhat.com, koke@sindominio.net,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       Tigran Aivazian <tigran@aivazian.fsnet.co.uk>, rusty@rustcorp.com.au,
       paul@wagland.net
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Message-ID: <20040510062556.GA1565@bitwizard.nl>
References: <Pine.LNX.4.44.0404301557230.4027-100000@einstein.homenet> <40927417.6040100@nortelnetworks.com> <DE44B86D-9AC0-11D8-B83D-000A95BCAC26@linuxant.com> <40927F21.9010703@nortelnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40927F21.9010703@nortelnetworks.com>
User-Agent: Mutt/1.3.28i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 12:30:25PM -0400, Chris Friesen wrote:
> Marc Boucher wrote:
> >
> >Chris,
> >
> >people should, before insulting us publicly or make unsubstantiated 
> >claims that we "lie" or engage in "illegal" actions, perhaps consult a 
> >lawyer, and simultaneously use the opportunity to enquire about the 
> >meaning of "slander".
> 
> The C string library considers a null to terminate the string.  You added a 
> null after the "GPL". It appears to me that this is telling the kernel that 
> the module is licensed as "GPL", even though it is obvious to a person 

How about the following:

The MODULE_LICENCE macro is a technical way of indicating the licence
to the kernel. There are various ways of putting "comments and remarks"
about the licence in the source code, but techically, if 
	strcmp (MODULE_LICENCE, "GPL") == 0
then the module is licenced under GPL.  (*)

For example, I like the following licence:

	MODULE_LICENCE ("GPL"); 
	/* The GPL licence allows you to distribute changes yourself, 
	   but in fact I would prefer if you contact me with your 
	   patches */

Now it might be that some vendors have written aditional comments
in such a way that they make it into the binary. Fine. 

If some vendor tells the kernel that it's licence is "GPL" then 
that's fine. The kernel then has the right to point the users to their
rights. 

So I would support that new kernels to do something like: 

	if (module_is_probably_lying ()) {
		printk (KERN_WARN "Loading module XXX, which indicates "
			"that it has a GPL licence. This gives YOU\n");
		printf (KERN_WARN "(the user) certain rights. Read "
			"about those rights at: www.fsf.org/.....\n");
		printf (KERN_WARN "and www.kernel.org/linux-gpl-modules.html\n"); 
	}

The linux-gpl-modules.html URL would explain that some vendors 
are telling the kernel that their module is under GPL, but are 
refusing to release source code. The users should be urged to politely
ask the vendor for the source.

		Roger. 

(*) There could be bugs in code. For example, 

	errorcode = somefunction (....);
	if (errorcode = ERR_FILE_NOT_FOUND) {
		/* Handle the not found case */

	}

is perfectly clear to humans what was meant, but the computer understands
otherwise. It is quite possible that the vendors involved in this case
will claim they might have had a bug in their code. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
**** "Linux is like a wigwam -  no windows, no gates, apache inside!" ****
