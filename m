Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312277AbSCRKIy>; Mon, 18 Mar 2002 05:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312276AbSCRKIp>; Mon, 18 Mar 2002 05:08:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62473 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312274AbSCRKIh>;
	Mon, 18 Mar 2002 05:08:37 -0500
Message-ID: <3C95BC82.2070003@mandrakesoft.com>
Date: Mon, 18 Mar 2002 05:08:02 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020214
X-Accept-Language: en
MIME-Version: 1.0
To: Jan Hudec <bulb@ucw.cz>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: fadvise syscall?
In-Reply-To: <3C945635.4050101@mandrakesoft.com> <5.1.0.14.2.20020317170621.00abd980@pop.cus.cam.ac.uk> <5.1.0.14.2.20020317190303.03289ec0@pop.cus.cam.ac.uk> <5.1.0.14.2.20020318000057.051d30e0@pop.cus.cam.ac.uk> <a73ujs$5mc$1@cesium.transmeta.com> <20020318085811.GA21981@artax.karlin.mff.cuni.cz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Hudec wrote:

>>Followup to:  <5.1.0.14.2.20020318000057.051d30e0@pop.cus.cam.ac.uk>
>>By author:    Anton Altaparmakov <aia21@cam.ac.uk>
>>In newsgroup: linux.dev.fs.devel
>>
>>>Ok, so basically we want both fadvise() and open(2) semantics, with the 
>>>open(2) being a superset of the fadvise() capabilities (some things no 
>>>longer make sense to be specified once the file is open). They can of 
>>>course both be calling the same common helpers inside the kernel...
>>>
>>If they're open() flags, they should probably be controlled with
>>fcntl() rather than with a new system call.
>>
>
>Then posix_fadvise interface can be implemented in libc using fcntl.
>
Indeed it can be...  but it less flexible that way, unless you want to 
add another level of indirection.

It is far better for future-proofing the interface IMO if fadvise is 
implementing directly.  Hints are less important than open O_xxx flags 
or F_xxx flags, because an implementation can safely ignore 100% of the 
fadvise hints, if it so chooses.  One cannot say the same thing for 
open/fcntl flags.

So, different class of fd flags deserves a different syscall, IMO...

    Jeff






