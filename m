Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287658AbSANRRW>; Mon, 14 Jan 2002 12:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287743AbSANRRO>; Mon, 14 Jan 2002 12:17:14 -0500
Received: from medusa.sparta.lu.se ([194.47.250.193]:34316 "EHLO
	medusa.sparta.lu.se") by vger.kernel.org with ESMTP
	id <S287658AbSANRRB>; Mon, 14 Jan 2002 12:17:01 -0500
Date: Mon, 14 Jan 2002 17:08:57 +0100 (MET)
From: Bjorn Wesen <bjorn@sparta.lu.se>
Reply-To: Bjorn Wesen <bjorn@sparta.lu.se>
To: Ian Molton <spyro@armlinux.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: IDE code
In-Reply-To: <20020114135745.671cc624.spyro@armlinux.org>
Message-ID: <Pine.LNX.3.96.1020114170101.6885B-100000@medusa.sparta.lu.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Jan 2002, Ian Molton wrote:
> in the ide code the functions ide_[input|output]_data() seem to have become
> polluted by a test for a 'helper function' to be used to read data instead
> of inb() and friends.

I made that change, and I thought about letting the caller check it, but
this was a much cleaner way to fix it overall given that it needed to go 
in the 2.4 stable series. Actually, the caller having to check driver
details is not very nice at all. It has to do this for the dmaproc because
the DMA and PIO modes are fundamentally different, but in this case it's
probably better if the caller does not have to bother.

Now, what is lacking in the current implementation is that the caller
should use the hw ptr directly instead of first calling the ide_xx_data
which subsequently checks for an override, and ide_xx_data could be put as
default in that ptr. But that would require changing in a lot of places in
a very mission critical piece of code - it can be fixed during 2.5 of
course.

> As the writer of an ide card driver that needs this functionality (it uses
> a multiply mapped register concept on ARM hardware to take advantage of its
> multiple load/store instructions for PIO (the hardware cannot do DMA, its
> 15 years old :)), I would appreciate input on wether or not anyone else
> feels this change should / should not be made?

In what way, exactly, does the current mechanism stop you from doing this?

/BW



