Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261417AbTEHMNo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 08:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261449AbTEHMNo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 08:13:44 -0400
Received: from pat.uio.no ([129.240.130.16]:1504 "EHLO pat.uio.no")
	by vger.kernel.org with ESMTP id S261417AbTEHMNm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 08:13:42 -0400
From: Terje Malmedal <terje.malmedal@usit.uio.no>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Terje Eggestad <terje.eggestad@scali.com>,
       Christoph Hellwig <hch@infradead.org>,
       Arjan van de Ven <arjanv@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       D.A.Fedorov@inp.nsk.su
Subject: Re: The disappearing sys_call_table export.
References: <1052122784.2821.4.camel@pc-16.office.scali.no>
	<20030505092324.A13336@infradead.org>
	<1052127216.2821.51.camel@pc-16.office.scali.no>
	<1052133402.29361.2.camel@dhcp22.swansea.linux.org.uk>
MIME-Version: 1.0
Message-Id: <E19DkT9-0000Wh-00@aqualene.uio.no>
Date: Thu, 8 May 2003 14:25:51 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[Alan Cox]
>> 10. kernel patches are impractical, I must be able to do this with std
>> stock, redhat, AND suse kernels.   

> So you want every vendor to screw up their kernels and the base kernel
> for an obscure (but fun) corner case. Thats not a rational choice is it.
> You want "performance is everything" you pay the price, don't make
> everyone suffer.

Hmm. sys_call_table is gone? That's sad.

How about a

EXPORT_SYMBOL_GPL_AND_DONT_EVEN_THINK_ABOUT_SENDING_A_BUG_REPORT(sys_call_table);

and displaying a nasty warning message on the console whenever a
module used it?

It is rare that I need to use it, but when I do I need it bad, for instance: 

fsync on large files used to have severe performance problems, I was
able to just change sys_fsync to be a call to sys_sync without
rebooting or even restarting the database(Solid) before the problem
got out of hand.

A server for an online internet game had several months of uptime and
I needed to rotate the log-files so I made a module which trapped
sys_write and closed and reopened the file with a new name before
continuing[1]. 

Even if it is discouraged for normal use it is a very nice thing to
have to fix up various surprises.

I know I can still use the Phrack technique, but somehow I am not
convinced that I can rely on it being available.

-- 
 - Terje
malmedal@usit.uio.no

[1] When I do this kind of thing now I do: 
(gdb) attach 9597
(gdb) call close(7)
(gdb) call open("out.txt",0100 | 01, 0666 ) 
(gdb) cont

This did not work back then however. 
