Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266435AbUALV1a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:27:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266445AbUALV13
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:27:29 -0500
Received: from chaos.analogic.com ([204.178.40.224]:8064 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266435AbUALV1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:27:25 -0500
Date: Mon, 12 Jan 2004 16:27:21 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: David Schwartz <davids@webmaster.com>
cc: tabris <tabris@tabris.net>, "Hunt, Adam" <ahunt@solvone.com>,
       linux-kernel@vger.kernel.org
Subject: RE: SecuriKey
In-Reply-To: <MDEHLPKNGKAHNMBLJOLKAEDHJHAA.davids@webmaster.com>
Message-ID: <Pine.LNX.4.53.0401121554440.6226@chaos>
References: <MDEHLPKNGKAHNMBLJOLKAEDHJHAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Jan 2004, David Schwartz wrote:

>
> > 	How do you generate a one-time-pad? a one time pad must be
> > by definition
> > truly random, and be used only once. and if you can send the Securikey
> > via a secure channel at the same time as the message, then you don't need
> > the OTP.
>
> 	To truly qualify as an OTP, the data would have to be random, used once,
> and somehow securely transfered to both ends of what will be the secure
> channel. This is, shall we say politely, seldom done for modern
> cryptography.
>
> 	However, many modern encryption schemes do require data that must be
> unpredictable. If you want to encrypt a message using RSA, you generally use
> a random key for a symmetric cypher and use RSA to protect the random key
> rather than the (usually larger) message itself.
>
> > 	I should also mention that the problem with 'generating' an
> > OTP via any
> > mechanical or algorithmic means is impossible as at best an OTP will only
> > be pseudo-random, and therefore with identical inputs (assuming it is
> > possible, which we can assume here for the sake of theory and security),
> > the same OTP can be generated, thus breaking our assumption/necessity of
> > non-deterministic output.
>
> 	Except we don't live in a deterministic world, we live in a quantum world.
> It is nearly trivial to mechanically produce data that is truly random. All
> you need is a reverse biased zener diode.
>
> 	Even if you do believe the world is deterministic, against the weight of
> modern science, I really doubt you believe that anyone outside a sealed box
> can predict microscopic zone temperature variations within a box and
> therefore predict the phase jitter between two crystal oscillators inside
> it.
>
> 	DS
>

Also, the data need not be random, but simply unpredictable. There
are many ways of generating such data, even without hardware. It
is possible to do it, entirely in software. The result can be verified
to never repeat, because the code takes time to execute and, therefore,
the time at which the code is executed will never repeat (time increases
always). Even artifically resetting the time will result in an
unpredictable jitter, making it provably difficult (like "nearly"
impossible) to repeat the same sequence generation if the code is
written towards this goal. Simple example:

Use the microseconds of time as a seed for rand() (rand() is not optimum,
but doesn't have to be).
Modify the number in some manner dependent upon the number of received
network interrupts (perhaps XOR). Wait until the number of network
interrupts increases, use microseconds of time to further modify the
result.

Here we are:

 10:     198919     199027   IO-APIC-level  eth0

The resulting integer can be bounded, but not predicted. It is
likely good enough for one of the components of a cipher. In
this manner, the starting parameter (seed) for the RND is
made unpredictable, then the result is further scrambled by
a non-deterministic external event. By using the fact that
time always increases, plus modification by something that
no code has control over (the network events), one can show
that the result can't be predicted. That's what is needed
for cipher components.

This is not a good way of obtaining unpredictable numbers because
of the long time necessary and the requirement for external
events like network interrupts, but it shows the mechanism.

Could you guess that it would become:

 10:     198924     199076   IO-APIC-level  eth0

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


