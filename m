Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261577AbSIXGBK>; Tue, 24 Sep 2002 02:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261578AbSIXGBJ>; Tue, 24 Sep 2002 02:01:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:11787 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S261577AbSIXGBI>;
	Tue, 24 Sep 2002 02:01:08 -0400
Message-ID: <3D9000B9.4000001@pobox.com>
Date: Tue, 24 Sep 2002 02:05:45 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       cgl_discussion mailing list <cgl_discussion@osdl.org>,
       evlog mailing list <evlog-developers@lists.sourceforge.net>,
       "ipslinux (Keith Mitchell)" <ipslinux@us.ibm.com>,
       Linus Torvalds <torvalds@home.transmeta.com>,
       Hien Nguyen <hien@us.ibm.com>, James Keniston <kenistoj@us.ibm.com>,
       Mike Sullivan <sullivam@us.ibm.com>
Subject: Re: [PATCH-RFC} 3 of 4 - New problem logging macros, plus template
 generation
References: <20020924054804.334A52C0E9@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty Russell wrote:
> In message <3D8FC9F2.1020604@pobox.com> [Jeff Garzik] write[s]:
>>Further, I not sure we need to add all this new infrastructure when
>>we could obtain the same result via [off the top of my head] printk
>>standards in key drivers.
> 
> 
> They want to formalize it so you can template it.  Noone wants "ERR:
> 400001020567" on their console, so having a method of generating that
> number from something which is readable in source (and by default
> turns into a pretty printk) makes sense.

Agreed.  But changing every printk in the kernel does not make sense.

Clean up and standardize the printks(), then post-process the printk() info.


>>Why don't you start out with a list of requirements that you want to see 
>>from drivers?  Only then can we objectively evaluate our needs.
>>
>>You are proposing a solution without really making it clear what 
>>problems you are solving.
> 
> 
> Driver error collection and reporting.  You want an automated
> catalogue of all the error messages the kernel can produce.  You want
> them to be consistent.  You want to be able to control the verbosity.
> You want to be able to attach other mechanisms to collect them.  You
> want to combine them with your userspace logging systems to give a
> picture of machine state (think thousands of remotely administered
> machines).
> 
> You *can* do this with printk, but only the most disciplined of
> drivers do (eg. Becker net drivers are really good at putting "eth0:"
> etc in messages, others are not so great).
> 
> For this to be useful, it has to be ubiquitous, and for that it has to
> be *easier* than printk to use correctly (which is a hard challenge).

If you note, the net drivers I write from scratch follow the Becker 
style of messaging as well.  It is not difficult to have a style guide 
and adhere to it.  We don't need a new API for that.


>>If you actually want to standardize some diagnostic messages, it is a 
>>huge mistake [as your scsi driver example shows] to continue to use 
>>random text strings followed by a typed attribute list.  If you really 
>>wanted to standardize logging, why continue to allow driver authors to 
>>printk driver-specific text strings in lieu of a standard string that 
>>applies to the same situation in N drivers.
> 
> 
> I disagree.  In their non-printk backend, the strings are simply
> hashed (with the driver name) into tokens: they're remarkably robust
> against driver linenumber changes and minor code changes.

I think you misunderstand...  If you want to standardize the messages, 
you change the text in the strings, and perhaps the args passed to 
printk, so that they look the same from driver to driver.

This is useful, needed work that benefits POSIX event logging -- while 
at the same time providing better value to normal printk() users.


> We don't have that much structure in the kernel: the helper macros the
> minimal sufficient to ensure that the device is identified with every
> problem.
> 
> There are nice things you can do with ratelimiting these messages
> sanely as well, and translations.
> 
> I think the architecture is fairly sound, although the implementation
> needs some tweaking.


The backend is fairly sound.  And I agree in general event logging is 
useful, and I fully support integrating [sane] support into the kernel.

But the kernel API is utter crap.

Adding <foo>_problem.h for every subsystem?
Adding <foo>_introduce() for every subsystem?
Changing every printk() in the damn kernel?

Come on dude, I _know_ you have more taste than that.

	Jeff



