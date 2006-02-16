Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964901AbWBPVLa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964901AbWBPVLa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 16:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWBPVLa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 16:11:30 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:60321 "EHLO mail.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S964901AbWBPVL3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 16:11:29 -0500
Message-ID: <43F4EA6D.2040504@vilain.net>
Date: Fri, 17 Feb 2006 10:11:09 +1300
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Herbert Poetzl <herbert@13thfloor.at>,
       "Eric W. Biederman" <ebiederm@xmission.com>,
       "Serge E. Hallyn" <serue@us.ibm.com>, Kirill Korotaev <dev@sw.ru>,
       linux-kernel@vger.kernel.org, vserver@list.linux-vserver.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
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
References: <20060215145942.GA9274@sergelap.austin.ibm.com>	 <m11wy4s24i.fsf@ebiederm.dsl.xmission.com>	 <20060216143030.GA27585@MAIL.13thfloor.at>	 <1140111692.21383.2.camel@localhost.localdomain>	 <20060216191245.GA28223@MAIL.13thfloor.at> <1140118693.21383.18.camel@localhost.localdomain>
In-Reply-To: <1140118693.21383.18.camel@localhost.localdomain>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Hansen wrote:
> Brainstorming ... what do you think about having a special init process
> inside the child to act as a proxy of sorts?  It is controlled by the
> parent vserver/container, and would not be subject to resource limits.
> It would not necessarily need to fork in order to kill other processes
> inside the vserver (not subject to resource limits).  It could also
> continue when the rest of the guest was suspended.
> A pid killer would be ineffective against such a process because you
> can't kill init.  

Well, another approach would be to create a new context which has
visibility over the other container as well as the ability to send
signals to it.

>>In general, I prefer to think of this as working 
>>with nuclear material via an actuator from behind 
>>a 4" lead wall -- you just do not want to go in 
>>to fix things :)
> Where does that lead you?  Having a single global pid space which the
> admin can see?  Or, does a special set of system calls do it well
> enough?

I don't like this term "single global pid space".  Two containers might
be able to see all processes on the system, one might have a flat
mapping to all PIDs < 64k (or pid_max), one with the XID,PID encoded
bitwise.  They are both global pid spaces, but there is no "single" one,
unless that is all you compile in.

Sam.
