Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263656AbTDYSkx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 14:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263669AbTDYSkx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 14:40:53 -0400
Received: from franka.aracnet.com ([216.99.193.44]:63701 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263656AbTDYSkv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 14:40:51 -0400
Date: Fri, 25 Apr 2003 11:49:39 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Robert Love <rml@tech9.net>, "Randy.Dunlap" <rddunlap@osdl.org>
cc: Bill Davidsen <davidsen@tmr.com>, bcrl@redhat.com, akpm@digeo.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.68-mm2
Message-ID: <428740000.1051296578@[10.10.2.4]>
In-Reply-To: <1051295252.9767.143.camel@localhost>
References: <20030424163334.A12180@redhat.com>
 <Pine.LNX.3.96.1030425135538.16623C-100000@gatekeeper.tmr.com>
 <20030425112042.37493d02.rddunlap@osdl.org>
 <1051295252.9767.143.camel@localhost>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> | The point is that even if bash is fixed it's desirable to address the
>> | issue in the kernel, other applications may well misbehave as well.
>> 
>> So when would this ever end?
> 
> Exactly what I was thinking.
> 
> The kernel cannot be expected to cater to applications or make
> concessions (read: hacks) for certain behavior.  If we offer a cleaner,
> improved interface which offers the performance improvement, we are
> done.  Applications need to start using it.
> 
> Of course, I am not arguing against optimizing the old interfaces or
> anything of that nature.  I just believe we should not introduce hacks
> for application behavior.  It is their job to do the right thing.

I would actually like us to do this (the non-deterministic nature of UNIX
semantics wrt exec is hateful), but changing the kernel before the apps is
ass-backwards. Once this distros fix all their binaries (at least in their
bleeding edge versions) this makes more sense.

There are also some interesting comments the manpage for vfork:

BUGS
       It is rather unfortunate that Linux revived  this  spectre
       from  the past.  The BSD manpage states: "This system call
       will be eliminated when proper system  sharing  mechanisms
       are  implemented.  Users  should  not depend on the memory
       sharing semantics of vfork as it will, in  that  case,  be
       made synonymous to fork."

       Formally  speaking,  the  standard description given above
       does not allow one to use vfork() since a  following  exec
       might fail, and then what happens is undefined.

       Details  of  the  signal  handling  are obscure and differ
       between systems.  The BSD manpage states: "To avoid a pos­
       sible  deadlock  situation, processes that are children in
       the middle of a vfork are never sent  SIGTTOU  or  SIGTTIN
       signals;  rather,  output  or ioctls are allowed and input
       attempts result in an end-of-file indication."

       Currently (Linux 2.3.25), strace(1) cannot follow  vfork()
       and requires a kernel patch.

