Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270814AbRHSWI7>; Sun, 19 Aug 2001 18:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270816AbRHSWIt>; Sun, 19 Aug 2001 18:08:49 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:5092 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S270814AbRHSWIe>;
	Sun, 19 Aug 2001 18:08:34 -0400
Date: Sun, 19 Aug 2001 23:08:46 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>, lists@sapience.com,
        Robert Love <rml@tech9.net>
Cc: Oliver Xymoron <oxymoron@waste.org>, linux-kernel@vger.kernel.org,
        riel@conectiva.com.br,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Entropy from net devices - keyboard & IDE just as 'bad' [was Re:
 [PATCH] let Net Devices feed Entropy, updated (1/2)]
Message-ID: <481261630.998262525@[169.254.45.213]>
In-Reply-To: <479225540.998260489@[169.254.45.213]>
In-Reply-To: <479225540.998260489@[169.254.45.213]>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Because it looks at inter-IRQ timing, the risk is mainly (as per
> previous posting) the theoretical risk of being able to determine
> that inter-IRQ timing from observation of the network(s) connected.

So I looked at this a bit more. The stuff which increases entropy
is meant to be secure from non-root users.

However (standard debian install - headless machine), unpriveleged
account:

$ cat /proc/interrupts
           CPU0
  0: 1116302985          XT-PIC  timer
  1:          2          XT-PIC  keyboard
  2:          0          XT-PIC  cascade
  8:          1          XT-PIC  rtc
  9:   28980016          XT-PIC  usb-uhci, eth0
 14:  698146587          XT-PIC  ide0
 15:          5          XT-PIC  ide1
NMI:          0
ERR:          0

Shock horror - I can continually poll this and spot
when an IRQ occurs.

So polling /proc/interrupts gives me a pretty good indication
of timing for ide0 interrupts (and, if I had one, keyboard
interrupts). The /proc reading routine is sufficiently fast
that by repeating reading (as a user) I should be able to
get the inter-IRQ timing down to a few tens of microseconds,
which I think is a few tens of possible values added to the
entropy pool. This tells me that actually keyboard and ide
interrupt timings are no less observable by non-root people than
network interrupts.

Now if you have an IR or radio keyboard, the situation is even worse.

So I don't think Robert's patch is any more flawed than using
k/b, mouse, ide IRQs.

--
Alex Bligh
