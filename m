Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261404AbREMOEE>; Sun, 13 May 2001 10:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261405AbREMODy>; Sun, 13 May 2001 10:03:54 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:7689 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S261404AbREMODm>;
	Sun, 13 May 2001 10:03:42 -0400
To: Abramo Bagnara <abramo@alsa-project.org>
Cc: "David S. Miller" <davem@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: unsigned long ioremap()?
In-Reply-To: <3AF10E80.63727970@alsa-project.org> <Pine.LNX.4.05.10105030852330.9438-100000@callisto.of.borg> <15089.979.650927.634060@pizda.ninka.net> <11718.988883128@redhat.com> <3AF12B94.60083603@alsa-project.org> <15089.63036.52229.489681@pizda.ninka.net> <3AF25700.19889930@alsa-project.org>
From: Jes Sorensen <jes@sunsite.dk>
Date: 13 May 2001 16:00:45 +0200
In-Reply-To: Abramo Bagnara's message of "Fri, 04 May 2001 09:15:12 +0200"
Message-ID: <d37kzltkky.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Abramo" == Abramo Bagnara <abramo@alsa-project.org> writes:

Abramo> "David S. Miller" wrote:
>> One final point, I want to reiterate that I believe:
>> 
>> foo = readl(&regs->bar);
>> 
>> is perfectly legal and should not be discouraged and in particular,
>> not made painful to do.

Abramo> I disagree: regs it's not a dereferenceable thing and I think
Abramo> it's an abuse of pointer type. You're keeping a pointer that
Abramo> need a big sign on it saying "Don't dereference me", it's a
Abramo> mess.

Thats complete rubbish, in many cases the regs structure matches a
regs structure seen by another CPU on the other side of the PCI bus
(ie. the firmware case). There is nothing wrong with the above
approach as long as you keep in mind that you cannot dereference the
struct without using readl and you have to make sure to explicitly do
padding in the struct (not all CPUs guarantee the same natural
alignment).

Jes
