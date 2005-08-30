Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932243AbVH3Rz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932243AbVH3Rz6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 13:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVH3Rz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 13:55:58 -0400
Received: from mailout10.sul.t-online.com ([194.25.134.21]:22701 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932241AbVH3Rz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 13:55:57 -0400
Message-ID: <43149E5B.7040006@t-online.de>
Date: Tue, 30 Aug 2005 19:58:51 +0200
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.7) Gecko/20050414
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: Andrew Morton <akpm@osdl.org>, "Antonino A. Daplas" <adaplas@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       Jochen Hein <jochen@jochen.org>
Subject: Re: [Linux-fbdev-devel] [PATCH 1/1 2.6.13] framebuffer: bit_putcs()
 optimization for 8x* fonts
References: <43148610.70406@t-online.de> <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be>
In-Reply-To: <Pine.LNX.4.62.0508301814470.6045@numbat.sonytel.be>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-ID: GuloccZVYewomlYkw15S2lI-FDg-3vcfL8NY55dHpjpGzrpDChij4+@t-dialin.net
X-TOI-MSGID: 2d4c02bb-d883-4929-b55e-4ebabc35657d
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Probably you can make it even faster by avoiding the multiplication, like
>
>    unsigned int offset = 0;
>    for (i = 0; i < image.height; i++) {
>	dst[offset] = src[i];
>	offset += pitch;
>    }
>

More than two decades ago I learned to avoid mul and imul. Use shifts, 
add and lea instead,
that was the credo those days. The name of the game was CP/M 80/86, a86, 
d86 and ddt ;-)

But let´s get serious again.

Your proposed change of the patch results in a 21 ms performance 
decrease on my system.
Yes, I do know that this is hard to believe. I tested a similar 
variation before, and the results
were even worse.

Avoiding mul is a good idea in assembly language today, but often it is 
better to write a
multiplication  with the loop counter in C and not to introduce an extra 
variable instead. The
compiler will optimize the code and it´s easier for gcc without that 
extra variable.

More interesting would be the question what should be done for idx==2 or 
idx==3. Probably
fb_pad_aligned_buffer() is also slower for those cases. But does anybody 
use such fonts?

cu,
 knut
