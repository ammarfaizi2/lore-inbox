Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278128AbRJRUkI>; Thu, 18 Oct 2001 16:40:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278133AbRJRUj5>; Thu, 18 Oct 2001 16:39:57 -0400
Received: from toad.com ([140.174.2.1]:4 "EHLO toad.com") by vger.kernel.org
	with ESMTP id <S278128AbRJRUjz>; Thu, 18 Oct 2001 16:39:55 -0400
Message-ID: <3BCF3E55.350038DA@mandrakesoft.com>
Date: Thu, 18 Oct 2001 16:40:53 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Patrick Mochel <mochelp@infinity.powertie.org>
CC: Jonathan Lundell <jlundell@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
In-Reply-To: <Pine.LNX.4.21.0110181237360.17191-100000@marty.infinity.powertie.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mochel wrote:
> When the driver gets a save_state request, that is its notification that
> it is going to sleep. It should then stop/finish all I/O requests. It
> should then prevent itself from taking any more - by setting a flag or
> whatever. Then, device save state.
> 
> From that point in, it should know not to take any requests, theoretically
> preserving state.
> 
> When it gets the restore_state() call, it should first restore device
> state. Once it does that, it knows that it can take I/O requests again.
> 
> That should work, right?

Seems reasonable.  If a save_state is refused, I assume you
restore_state for all other devices and bring the system from a
half-working state [at the time the suspend was rejected] to a
full-working state?

Consider that it will take some amount of time to stop pending I/O
requests.  You might want to walk the tree, and tell devices "start
saving", and then walk the tree again and say "finish saving."

	Jeff


-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno
