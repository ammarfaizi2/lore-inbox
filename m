Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750948AbWBUXXS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750948AbWBUXXS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Feb 2006 18:23:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWBUXXS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Feb 2006 18:23:18 -0500
Received: from MAIL.13thfloor.at ([212.16.62.50]:41866 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S1750948AbWBUXXR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Feb 2006 18:23:17 -0500
Date: Wed, 22 Feb 2006 00:23:15 +0100
From: Herbert Poetzl <herbert@13thfloor.at>
To: Kirill Korotaev <dev@sw.ru>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Hansen <haveblue@us.ibm.com>,
       Arjan van de Ven <arjan@infradead.org>,
       Suleiman Souhlal <ssouhlal@FreeBSD.org>,
       Hubertus Franke <frankeh@watson.ibm.com>,
       Cedric Le Goater <clg@fr.ibm.com>, Kyle Moffett <mrmacman_g4@mac.com>,
       Greg <gkurz@fr.ibm.com>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Rik van Riel <riel@redhat.com>, Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
       Andi Kleen <ak@suse.de>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Jeff Garzik <jgarzik@pobox.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>,
       Jes Sorensen <jes@sgi.com>
Subject: Re: [RFC][PATCH 04/20] pspace: Allow multiple instaces of the process id namespace
Message-ID: <20060221232315.GC20204@MAIL.13thfloor.at>
Mail-Followup-To: Kirill Korotaev <dev@sw.ru>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Dave Hansen <haveblue@us.ibm.com>,
	Arjan van de Ven <arjan@infradead.org>,
	Suleiman Souhlal <ssouhlal@FreeBSD.org>,
	Hubertus Franke <frankeh@watson.ibm.com>,
	Cedric Le Goater <clg@fr.ibm.com>,
	Kyle Moffett <mrmacman_g4@mac.com>, Greg <gkurz@fr.ibm.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Greg KH <greg@kroah.com>, Rik van Riel <riel@redhat.com>,
	Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
	Andrey Savochkin <saw@sawoct.com>, Kirill Korotaev <dev@openvz.org>,
	Andi Kleen <ak@suse.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Jeff Garzik <jgarzik@pobox.com>,
	Trond Myklebust <trond.myklebust@fys.uio.no>,
	Jes Sorensen <jes@sgi.com>
References: <43ECF803.8080404@sw.ru> <m1psluw1jj.fsf@ebiederm.dsl.xmission.com> <43F04FD6.5090603@sw.ru> <m1wtfytri1.fsf@ebiederm.dsl.xmission.com> <43F31972.3030902@sw.ru> <20060215133131.GD28677@MAIL.13thfloor.at> <20060216134447.GA12039@sergelap.austin.ibm.com> <43F98B67.60800@sw.ru> <20060220170448.GG18841@MAIL.13thfloor.at> <43FB3FDD.6030406@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43FB3FDD.6030406@sw.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 21, 2006 at 07:29:17PM +0300, Kirill Korotaev wrote:
>>>I would prefer:
>>>- sys_ns_create()
>>> creates namespace and makes a task to inherit this namespace. 
>>> If _needed_, it _can_ fork inside.

>>I don't see why not have both, the auto-created
>>*space on clone() and the ability to create empty
>>*spaces which can be populated and/or entered
>Can you give more details on what you mean by auto-created *space and 
>empty *space?
>I see no much difference...

good, in this case we can drop the empty/standalone
*space and 'just' use the clone() one. glad that
we finally agree here ....

>>>- sys_ns_inherit()
>>> change active namespace.
>>hmm, sounds like a misnomer to me ...
>sys_ns_change ? :)

personally I prefer to see it as either enter or
move, but change is probably fine too (except for
the fact that it doesn't change the namespace)

>>>But how should we reference namespace? by globabl ID?
>>definitely by some system-unique identifier ...
>Should it be integer or path as Eric proposes?
IMHO the pointer would be sufficient, of course
this can be mapped to arbitrary names/int/etc ...

> Thanks,
> Kirill
