Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270796AbRHSVTY>; Sun, 19 Aug 2001 17:19:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270797AbRHSVTP>; Sun, 19 Aug 2001 17:19:15 -0400
Received: from shed.alex.org.uk ([195.224.53.219]:53731 "HELO shed.alex.org.uk")
	by vger.kernel.org with SMTP id <S270796AbRHSVTK>;
	Sun, 19 Aug 2001 17:19:10 -0400
Date: Sun, 19 Aug 2001 22:19:22 +0100
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: Robert Love <rml@tech9.net>, Oliver Xymoron <oxymoron@waste.org>
Cc: linux-kernel@vger.kernel.org, riel@conectiva.com.br,
        Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: Re: [PATCH] let Net Devices feed Entropy, updated (1/2)
Message-ID: <478297685.998259561@[169.254.45.213]>
In-Reply-To: <998193404.653.12.camel@phantasy>
In-Reply-To: <998193404.653.12.camel@phantasy>
X-Mailer: Mulberry/2.1.0b3 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert,

> I claim there is entropy from what?  The difference between interrupts
> for net devices?  Everyone agrees that there is.  The issues is that an
> external attacker could influence the interrupts to the net device, and
                          ^^^^^^^^^

Actually, to be fair, the true risk is more that an external attacker could
/obvserve/ the timing of packets to the NIC with sufficient accuracy to
predict the inter-IRQ timing, and hence the consequent manipulation of
the pool. This would mean that entropy was being added, (assuming a system
free of entropy to start with), eventually causing /dev/random not to block,
and thus, short of any other entropy, the net effect would be that
/dev/random would become exactly as good/bad a random number source
as /dev/urandom. However, in most environments, it is not possible
to observe and accurately (microseconds) time the packet coming into
the NIC without physical access to the machine (in which case there
are, urm, easier attacks), and there is a largely indeterminable latency
between the arrival of the packet and the consequent network IRQ, this
latency being neither externally visible, nor being determinable by
some non-root user.

--
Alex Bligh
