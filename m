Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751696AbWCNUcr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751696AbWCNUcr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Mar 2006 15:32:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932070AbWCNUcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Mar 2006 15:32:47 -0500
Received: from mtagate1.de.ibm.com ([195.212.29.150]:2876 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751696AbWCNUcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Mar 2006 15:32:46 -0500
Message-ID: <44172869.5030707@fr.ibm.com>
Date: Tue, 14 Mar 2006 21:32:41 +0100
From: Cedric Le Goater <clg@fr.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Kirill Korotaev <dev@sw.ru>, Herbert Poetzl <herbert@13thfloor.at>,
       linux-kernel@vger.kernel.org, Gregory Kurz <gkurz@fr.ibm.com>,
       Hubertus Franke <frankeh@us.ibm.com>
Subject: Re: question: pid space semantics.
References: <1142282940.27590.17.camel@localhost.localdomain> <m1veuglvdx.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1veuglvdx.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

> To retain any part of the existing unix process management
> we need some processes that show up in multiple pid spaces.

yep.

> To allow for migration it must be possible for the pids in those pid
> spaces to be different.

agree, the process that creates a pidspace is in different pidspaces if you
want to maintain the process hierarchy.

> It is undesirable in the normal case of affairs to allocate more
> than one pid per process.

yes.

> Given the small range of pid values these constraints make an
> efficient and general pid space solution challenging.
> 
> The question:
>   If we could add additional pid values in different pid spaces to a
>   process with a syscall upon demand would that lead to an
>   implementation everyone could use? 

I don't know yet if we would use it but we need it :) One way of the other.
The creator of a pidspace could be the parent of multiple pidspaces and
hence it needs multiples pids, one in each pidspace.

Could that be done with the syscall creating the pidspace ? because it
seems that the process creating a pidspace is the only candidate ?

> [ ... ]
>
> The reason I ask is that I believe I know how to implement a cheap
> general mechanism for adding additional pids to a process.

OK good. That's what we need to begin with : something cheap to prove the
feature is useful.

We have already implemented the vpid in a very similar way to the openvz
team, although with less optimization and linux feeling. Both efforts and
yours, on pidspaces, didn't prove to be good enough to be valuable.

C.
