Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268715AbRGZWZI>; Thu, 26 Jul 2001 18:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268717AbRGZWY6>; Thu, 26 Jul 2001 18:24:58 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:36490 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S268715AbRGZWYl>;
	Thu, 26 Jul 2001 18:24:41 -0400
Date: Thu, 26 Jul 2001 23:24:37 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@alex.org.uk
Cc: Dawson Engler <engler@csl.Stanford.EDU>, Evan Parker <nave@stanford.edu>,
        linux-kernel@vger.kernel.org, mc@CS.Stanford.EDU,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [CHECKER] repetitive/contradictory comparison bugs for 2.4.7
Message-ID: <611713474.996189877@[169.254.62.211]>
In-Reply-To: <E15PtGc-0004ad-00@the-village.bc.nu>
In-Reply-To: <E15PtGc-0004ad-00@the-village.bc.nu>
X-Mailer: Mulberry/2.1.0b1 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

<alan@lxorguk.ukuu.org.uk> wrote:
>> How will this be guaranteed to help handle a race, when gcc is
>> likely either to have tmp_buf in a register (not declared
>> volatile), or perhaps even optimize out the second reference.
>
> The function call is a synchronization pointAlan,

Ooops - indeed, yes. Though the cli()/restore_flags() doesn't seem
like the right way to perform a lock. My naive interpretation is
that either it needs a (faster) real lock that doesn't disable IRQs on
multiple CPUs etc., or lock_kernel does the job in which
case cli()/restore_flags() is redundant, and, indeed, so is the
check itself. May be I have missed something (again).

I am presuming even an inline cli() is a synchronization point too,
else there would still be a race if the read of tmp_buf in
if(tmp_buf) and the cli() were reordered.

--
Alex Bligh
