Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbVA1VlG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVA1VlG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 16:41:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262768AbVA1VlG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 16:41:06 -0500
Received: from web41411.mail.yahoo.com ([66.218.93.77]:53132 "HELO
	web41411.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262766AbVA1Vkx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 16:40:53 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=tsYb4zpB2P/6AwE7awhE+7Myq5wXUw6bRL1K/wNq0pGpWwphV3vkr13H/REQ7mSjO6ixcXh/nnHafqoguRWZ9qMUipUMdig7u67brOP/GyhlJ9D6bl1pyGcZ5lbe+QD831qcbQSgB8wT2jbHBgpWwDGMSIHP8rD6N0dokJb4vXw=  ;
Message-ID: <20050128214051.34768.qmail@web41411.mail.yahoo.com>
Date: Fri, 28 Jan 2005 13:40:51 -0800 (PST)
From: Rock Gordon <rockgordon@yahoo.com>
Subject: Re: userspace vs. kernelspace address
To: Jan Hudec <bulb@ucw.cz>
Cc: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org,
       Bernd Petrovitsch <bernd@firmix.at>
In-Reply-To: <20050128075209.GA14153@vagabond>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everbody,

Thanks for your replies.

Lemme explain my problem a little bit more .... I have
a thread that does exactly similar things in
kernel-mode and user-mode (depending on how you
invoked it; of course, the kernel one is forked using
kernel_thread(), and the user one is from
pthread_create()). The architecture-dependant stuff is
taken care of by extensive use of __KERNEL__ macro
testing.

This particular thread gets a packet of data, the
header of which contains address to where it should be
copying the payload associated with that packet. The
kernel-mode thread will need to decide how to copy
data into another process' address space, so will the
user-mode thread.

However I think my copy_to_user and copy_from_user are
failing since the kernel-mode thread is copying data
into another process's address space, and I am not
sure how to do this. Do the get_fs() and set_fs()
combinations let you do that? If not, then how do I do
it?

Something like when you invoke the ->write or ->read
functions, you need to copy the requisite data into
the buffer the application provided you with.

Thanks and regards,
Rock


--- Jan Hudec <bulb@ucw.cz> wrote:

> On Fri, Jan 28, 2005 at 01:06:21 +0100, Bernd
> Petrovitsch wrote:
> > On Thu, 2005-01-27 at 09:14 -0800, Rock Gordon
> wrote:
> > > If I'm given a particular address, how do I test
> > > whether that address is from userspace or from
> kernel
> > > space?
> > 
> > You don't.
> > 
> > > I need to make these decisions from either
> inside a
> > > kernel module or a userspace program. The idea
> is I
> > > use memcpy() in the user-user version,
> > > copy_from/to_user in the kernel-kernel version,
> and
> > > prohibit the others.
> > 
> > You need to know where the address is from and use
> the correct function.
> 
> If the interface is defined as taking userland
> address, than kernel
> function passing a kernel address in is responsible
> for calling
> set_fs(KERNEL_DS) before and undoing it after. That
> way the
> copy_to/from_user does not complain.
> 
>
-------------------------------------------------------------------------------
> 						 Jan 'Bulb' Hudec <bulb@ucw.cz>
> 

> ATTACHMENT part 2 application/pgp-signature
name=signature.asc




		
__________________________________ 
Do you Yahoo!? 
Take Yahoo! Mail with you! Get it on your mobile phone. 
http://mobile.yahoo.com/maildemo 
