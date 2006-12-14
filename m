Return-Path: <linux-kernel-owner+w=401wt.eu-S1751993AbWLNGQb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751993AbWLNGQb (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 01:16:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751970AbWLNGQb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 01:16:31 -0500
Received: from mail.velocitynet.com.au ([203.17.154.25]:45523 "EHLO
	m0.velocity.net.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751979AbWLNGPz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 01:15:55 -0500
X-Greylist: delayed 1628 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Dec 2006 01:15:54 EST
Message-ID: <4580E5B9.6080405@iinet.net.au>
Date: Thu, 14 Dec 2006 16:48:41 +1100
From: Ben Nizette <ben.nizette@iinet.net.au>
User-Agent: Thunderbird 1.5.0.8 (Windows/20061025)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: tglx@linutronix.de
Subject: Re: Userspace I/O driver core
References: <20061214010608.GA13229@kroah.com>
In-Reply-To: <20061214010608.GA13229@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> But in order to get this core into the kernel tree, we need to have some
> "real" drivers written that use it.  So, for anyone that wants to see
> this go into the tree, now is the time to step forward and post your
> patches for hardware that this kind of driver interface is needed.
>   
We have a product being developed currently for which this interface is 
perfect.

The situation is that we have Linux collecting data from very many 
sources.  The data is processed by throwing it at a memory address at 
which an FPGA lives.  The FPGA processes the data and generates an 
interrupt upon completion at which time the processed data can be read 
back out.  Linux doesn't know anything about the data except it's source 
and destination and, for security reasons, it has to stay that way.  As 
such a formal driver makes little sense: data gets written to a memory 
address and a little while later it is read out again, that's it.  The 
only fly in the ointment is the interrupt.  Before I knew about these 
UIO patches I had written what effectively was a smaller version of UIO 
to handle this interrupt.  With the UIO patches the whole process 
becomes trivial and I (along with my boss) become happy :-)

I shall submit a patch once I move my code over but it's almost not 
worth it, it will be truly trivial.

I can see a similar scenario being played out a lot in industrial 
control and other embedded systems.  For example, if you just want to 
monitor a set of data but interrupt if something critical happens (or 
even just when the data is updated).  All an in-kernel driver would do 
is handle an interrupt and perform copy_{to,from}_user()s but it would 
have to have a fair bit of fluff around it to signal to userland that 
the interrupt had occured.  UIO is a clean, standard and powerful form 
of that fluff.  Congrats to all who worked on her.

Regards,
   Ben.
