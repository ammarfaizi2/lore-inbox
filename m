Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276451AbRJUSDD>; Sun, 21 Oct 2001 14:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276477AbRJUSCx>; Sun, 21 Oct 2001 14:02:53 -0400
Received: from [194.213.32.141] ([194.213.32.141]:21888 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S276468AbRJUSCk>;
	Sun, 21 Oct 2001 14:02:40 -0400
Date: Sun, 21 Oct 2001 19:09:02 +0200
From: Pavel Machek <pavel@Elf.ucw.cz>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, Patrick Mochel <mochel@osdl.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] New Driver Model for 2.5
Message-ID: <20011021190902.A21849@elf.ucw.cz>
In-Reply-To: <Pine.LNX.4.33.0110191708220.2646-100000@penguin.transmeta.com> <20011020092834.24454@smtp.wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011020092834.24454@smtp.wanadoo.fr>
User-Agent: Mutt/1.3.22i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> The problem of suspend-to-disk, which requires, I beleive, that the
> device used for the memory backup, to be state-saved last, is still
> a problem I don't know how to solve. Maybe using flags in the device

Don't care about it. Its easy.

> That would give us the following scenario:
> 
>  - The device for suspend-to-disk is identified and a flag is set
>    in it's device structure. This flag (or a different one to make
>    things clear eventually) is "broadcast" all the way up the tree
>    so it's parent brigdes/controllers are marked as well.

You don't need this.

>  - All devices get "suspend_prepare".
>  - All devices get "suspend_save_state" and block normal IOs
>  - All devices not marked above get "suspend"

... not needed. You are going powerdown (suspend-to-disk ends in
powerdown, right?), so you don't care about state devices are in. You don't need to suspend them.

You just write state to disk and powerdown, now.
								Pavel
-- 
I'm pavel@ucw.cz. "In my country we have almost anarchy and I don't care."
Panos Katsaloulis describing me w.r.t. patents at discuss@linmodems.org
