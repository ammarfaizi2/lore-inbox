Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314102AbSDLPfV>; Fri, 12 Apr 2002 11:35:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314103AbSDLPfU>; Fri, 12 Apr 2002 11:35:20 -0400
Received: from smtp-sec1.zid.nextra.de ([212.255.127.204]:52236 "EHLO
	smtp-sec1.zid.nextra.de") by vger.kernel.org with ESMTP
	id <S314102AbSDLPfU>; Fri, 12 Apr 2002 11:35:20 -0400
Date: Fri, 12 Apr 2002 17:35:13 +0200 (CEST)
From: Guennadi Liakhovetski <gl@dsa-ac.de>
To: <linux-kernel@vger.kernel.org>
Subject: serial driver question
Message-ID: <Pine.LNX.4.33.0204121733460.15512-100000@pcgl.dsa-ac.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(asking on kernelnewbies didn't produceany results, so, I'm protected:-))

Hello all

The function
static int size_fifo(struct async_struct *info)
{
...
ends as follows:
	serial_outp(info, UART_LCR, UART_LCR_DLAB);
	serial_outp(info, UART_DLL, old_dll);
	serial_outp(info, UART_DLM, old_dlm);

	return count;
}

Which means, that DLAB is not re-set, and, in particular, all subsequent
read/write operations on offsets 0 and 1 will not affect the data and
interrupt enable registers, but the divisor latch register... Or is this
register somehow magically restored elsewhere or by the hardware (say, on
an interrupt)? This function seems to be only called for startech UARTs.

Thanks
Guennadi
---------------------------------
Guennadi Liakhovetski, Ph.D.
DSA Daten- und Systemtechnik GmbH
Pascalstr. 28
D-52076 Aachen
Germany


