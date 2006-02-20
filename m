Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbWBTKBh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbWBTKBh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 05:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWBTKBh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 05:01:37 -0500
Received: from mailhub.sw.ru ([195.214.233.200]:26665 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S932426AbWBTKBg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 05:01:36 -0500
Message-ID: <43F991DC.8010509@sw.ru>
Date: Mon, 20 Feb 2006 12:54:36 +0300
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; ru-RU; rv:1.2.1) Gecko/20030426
X-Accept-Language: ru-ru, en
MIME-Version: 1.0
To: "Serge E. Hallyn" <serue@us.ibm.com>
CC: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       vserver@list.linux-vserver.org, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Dave Hansen <haveblue@us.ibm.com>,
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
Subject: Re: (pspace,pid) vs true pid virtualization
References: <20060215145942.GA9274@sergelap.austin.ibm.com> <m11wy4s24i.fsf@ebiederm.dsl.xmission.com> <20060216143030.GA27585@MAIL.13thfloor.at> <20060216153729.GB22358@sergelap.austin.ibm.com>
In-Reply-To: <20060216153729.GB22358@sergelap.austin.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>this is mandatory, as it is required to kill any process
>>from the host (admin) context, without entering the pid
>>space (which would lead to all kind of security issues)
> Just to be clear: you think there should be cases where pspace x can
> kill processes in pspace y, but can't enter it?
YES! When you have resource management such a situation is quite common.
As I wrote in antoher email example:
VPS has reached it's process limit and you can't enter it.
If you suggest to make enter without resource limitations, then it will 
be a security hole.


>>>- Should we be able to monitor a pid space from the outside?
>>
>>yes, definitely, but it could happen via some special
>>interfaces, i.e. no need to make it compatible
> 
> 
> What sort of interfaces do you envision for these two?  If we
> can lay them out well enough, maybe the result will satisfy the
> openvz folks?
> 
> For instance, perhaps we just use a proc interface, where in the
> current pspace, if we've created a new pspace which in our pspace
> is known as process 567, then we might see
> 
> /proc
> /proc/567
> /proc/567/pspace
> /proc/567/pspace/1 -> link to /proc/567
> /proc/567/pspace/2
> 
> Now we also might be able to interact with the pspace by doing
> something like
> 
> 	echo -9 > /proc/567/pspace/2/kill
> 
> and of course do things like
> 
> 	cd /proc/567/pspace/1/root
uff... we can start calling ptrace etc. via proc then :)
UGLY! I think Linus will ban us for such ideas. And he will be right.

Kirill

