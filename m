Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131361AbRCPVoq>; Fri, 16 Mar 2001 16:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131364AbRCPVoh>; Fri, 16 Mar 2001 16:44:37 -0500
Received: from imr1.ericy.com ([208.237.135.240]:1529 "EHLO imr1.ericy.com")
	by vger.kernel.org with ESMTP id <S131361AbRCPVoW>;
	Fri, 16 Mar 2001 16:44:22 -0500
Message-ID: <7E67DE81C0B6D311B30500805FFEBAAE03078E3F@lmc35.lmc.ericsson.se>
From: "Mathieu Giguere (LMC)" <lmcmgig@lmc.ericsson.se>
To: "'David S. Miller'" <davem@redhat.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "Claude LeFrancois (LMC)" <lmcclef@lmc.ericsson.se>
Subject: RE: UDP stop transmitting packets!!!
Date: Fri, 16 Mar 2001 16:43:37 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ok fine to live with that for security reason, but the socket will be dead
for ever! (the only way to remove it is to reboot the machine)
Can be possible to have a timer when the queue is full (something like 1
minute) to wait before dequeueing all of it and retrying to continue to
process request?

Because we need to process a large amount of UDP packets and this anoying
trick come break the machine quickly (like 12 minutes).

/mathieu
> -----Original Message-----
> From:	David S. Miller [SMTP:davem@redhat.com]
> Sent:	Friday, March 16, 2001 4:29 PM
> To:	Mathieu Giguere (LMC)
> Cc:	'linux-kernel@vger.kernel.org'; Claude LeFrancois (LMC)
> Subject:	Re: UDP stop transmitting packets!!!
> 
> 
> Mathieu Giguere (LMC) writes:
>  > The problem with the previous code, when the queue become full (for any
>  > reason) you don't try to de-queue packet form it.
> 
> That is right, UDP is an unreliable transport so it doesn't
> matter which packets we drop in such a case.
> 
> In fact, the current choice is optimal.  If the problem is that we are
> being hit with too many packets too quickly, the most desirable course
> of action is the one which requires the least amount of computing
> power.  Doing nothing to the receive queue is better than trying to
> "dequeue" some of the packets there to allow the new one to be added.
> 
> Later,
> David S. Miller
> davem@redhat.com
