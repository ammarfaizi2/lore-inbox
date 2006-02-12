Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932197AbWBLElu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932197AbWBLElu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 23:41:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932202AbWBLElu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 23:41:50 -0500
Received: from smtpout.mac.com ([17.250.248.70]:60667 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932197AbWBLElt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 23:41:49 -0500
In-Reply-To: <20060212041522.GA29935@suse.de>
References: <20060208062007.GA7936@kroah.com> <43EE9EC0.2030403@rtr.ca> <20060212041522.GA29935@suse.de>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8969C1F8-FC32-4F71-8E46-8C4AEE57D589@mac.com>
Cc: Mark Lord <lkml@rtr.ca>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [RFC] EXPORT_SYMBOL_GPL_FUTURE()
Date: Sat, 11 Feb 2006 23:41:37 -0500
To: Greg KH <gregkh@suse.de>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 11, 2006, at 23:15, Greg KH wrote:
> On Sat, Feb 11, 2006 at 09:34:40PM -0500, Mark Lord wrote:
>> Greg KH wrote:
>>> So, here's a patch that implements EXPORT_SYMBOL_GPL_FUTURE().   
>>> It basically says that some time in the future, this symbol is  
>>> going to change and not be allowed to be called from non-GPL  
>>> licensed kernel modules.
>>
>> The wording and intent here are incorrect.
>>
>> All kernel modules are already *GPL licensed*, whether the authors  
>> think so or not.
>>
>> So this patch (if it goes through), should be reworded so as not  
>> to muddy those waters (as the above excerpt does).
>
> Care to provide some text that you feel will be better?

IANAL, but this or some lawyer-revised derivative might be good for  
an official changelog comment (if it ever gets committed):

It was noticed that the source-code restrictions on certain exported  
symbols did not match the effective legal restrictions.  Therefore,  
in the interests of preserving some backwards compatibility with  
buggy kernel modules that do not specify a license string or specify  
an incorrect license string, this patch creates a new symbol export  
macro "EXPORT_SYMBOL_GPL_FUTURE()".  This macro causes uses of the  
symbol from modules not marked "GPL" to be warned about, so that  
module developers may correctly specify a compatible license in their  
sources.  The set of all symbols flagged this way is no way  
exclusive; it's possible that we should flag _all_ presently exported  
symbols this way.  On the other hand, in the interests of avoiding  
thousands of warnings on boot for buggy modules, only some of the  
symbols are actually changed to use this new flag.  For each instance  
of EXPORT_SYMBOL_GPL_FUTURE, ample time (a couple kernel versions or  
so) will be provided for for buggy modules to be fixed after which it  
will be changed to EXPORT_SYMBOL_GPL.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/E/U d- s++: a18 C++++>$ ULBX*++++(+++)>$ P++++(+++)>$ L++++ 
(+++)>$ !E- W+++(++) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP 
+ t+(+++) 5 X R? !tv-(--) b++++(++) DI+(++) D+++ G e>++++$ h*(+)>++$ r 
%(--)  !y?-(--)
------END GEEK CODE BLOCK------



