Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315609AbSENLJr>; Tue, 14 May 2002 07:09:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315610AbSENLJq>; Tue, 14 May 2002 07:09:46 -0400
Received: from gateway.ukaea.org.uk ([194.128.63.73]:47144 "EHLO
	fuspcnjc.culham.ukaea.org.uk") by vger.kernel.org with ESMTP
	id <S315609AbSENLJp>; Tue, 14 May 2002 07:09:45 -0400
Message-ID: <3CE0F08A.5C41CAFA@ukaea.org.uk>
Date: Tue, 14 May 2002 12:10:02 +0100
From: Neil Conway <nconway.list@ukaea.org.uk>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.9-31 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Martin Dalecki <dalecki@evision-ventures.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.15 IDE 61
In-Reply-To: <3CE0DDBE.F9EC80AC@ukaea.org.uk> <3CE0D067.6010302@evision-ventures.com> <3CE0E306.6171045B@ukaea.org.uk> <3CE0D952.7080403@evision-ventures.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Dalecki wrote:
> There is no problem to go in paralell on different channels for
> requests. The serialization has only to be done
> for the drive setup.

I agree for general chipsets, but my whole point was with regard to
buggy chipsets which need to be serialized on both channels.

If you're saying that even these broken chipsets are OK with having
transfers on one channel while setting up transfers on another channel,
then perhaps you are right but that's not what I believed to be the case
(can't find info to tell me either way right now).

But if that really were the case, then how could the (e.g.) cmd640
problem ever have been manifested?  A spinlock is ALWAYS held while
ide_do_request is executing.  Even if it weren't, only an SMP machine
could be trying to program both channels simultaneously because
interrupts are disabled too.

Neil
