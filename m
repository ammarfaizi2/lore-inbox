Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280960AbRK3TFL>; Fri, 30 Nov 2001 14:05:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280967AbRK3TFB>; Fri, 30 Nov 2001 14:05:01 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:49868 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S280960AbRK3TEn>; Fri, 30 Nov 2001 14:04:43 -0500
Message-ID: <3C07DDC6.5FAE4E35@t-online.de>
Date: Fri, 30 Nov 2001 20:28:06 +0100
From: Gunther.Mayer@t-online.de (Gunther Mayer)
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Chris Meadors <clubneon@hereintown.net>,
        Martin Eriksson <nitrax@giron.wox.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        martin@jtrix.com
Subject: Re: 'spurious 8259A interrupt: IRQ7' -> read the 8259 datasheet !
In-Reply-To: <Pine.LNX.3.95.1011128084801.10732A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> On Wed, 28 Nov 2001, Chris Meadors wrote:
> 
> > On Wed, 28 Nov 2001, Martin Eriksson wrote:

...
... rumours deleted (e.g. "printer status bits are all ORed into irq7")
...

>From "Harris Semiconductor 82C59A Interrupt Controller Datasheet":
  If no interrupt request is present at step 4 of either sequence
  (i.e., the request was too short in duration), the 82C59A will
  issue an interrupt level 7. 

1. The irq controller sees an interrupt.
2. The irq controller signals "there is _some_ interrupt" to the cpu.
3. The CPU acks via INTA
4. The irq controller looks if the irq is still there
   (and signals IRQ7 if the line is no longer active).

You have some device which doesn't keep the IRQ raised long enough !
(or the CPU doesn't service the irq for a too long time and the 
 edge triggered irq is de-asserted or even serviced by a polling routine)
