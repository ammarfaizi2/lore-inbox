Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265569AbSJXRkl>; Thu, 24 Oct 2002 13:40:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265570AbSJXRkl>; Thu, 24 Oct 2002 13:40:41 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:10246 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S265569AbSJXRkk>;
	Thu, 24 Oct 2002 13:40:40 -0400
Message-ID: <3DB831FF.4000900@pobox.com>
Date: Thu, 24 Oct 2002 13:46:39 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Peloquin <peloquin@us.ibm.com>
CC: linux-kernel@vger.kernel.org, mochel@osdl.org, viro@math.psu.edu
Subject: Re: Switching from IOCTLs to a RAMFS
References: <OFE3B65375.45D5B484-ON85256C5C.005A3AF2@pok.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Peloquin wrote:
> Based on the feedback and comments regarding
> the use of IOCTLs in EVMS, we are switching to
> the more preferred method of using a ram based
> fs. Since we are going through this effort, I
> would like to get it right now, rather than
> having to switch to another ramfs system later
> on. The question I have is:  should we roll our
> own fs, (a.k.a. evmsfs) or should we use sysfs
> for this purpose? My initial thoughts are that
> sysfs should be used. However, recent discussions
> about device mapper have suggested a custom ramfs.
> Which is the *best* choice?


(cc'd viro and mochel, as I feel they are 'owners' in the subject area)

Let's jump back a bit, for a second.  Why is procfs bad news?  There are 
minor issues with the implementation of single-page output and lack of 
pure file operations, but the big issue is lack of a sane namespace. 
sysfs is no better than procfs if we keep heaving junk into it without 
thinking about proper namespace organization.

I personally prefer a separate filesystem for what you describe.  That 
gives the EVMS team control over their own portion of the namespace, 
while giving complete flexibility.  I do _not_ see sysfs as simply a 
procfs replacement -- sysfs IMO is more intended as a way to organize 
certain events and export internal kernel structure.

To tangent a bit, WRT a private evmsfs, make sure that (a) you prefer 
ASCII over binary interfaces where reasonable, and (b) any binary 
interfaces you have are fixed-endian and 64-bit safe from the get-go. 
Consider crazy cases like someone exporting evmsfs over NFS, from a 
32-bit IA32 server to a big-endian 64-bit client.

	Jeff



