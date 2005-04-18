Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261584AbVDRBna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbVDRBna (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 21:43:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVDRBna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 21:43:30 -0400
Received: from tama5.ecl.ntt.co.jp ([129.60.39.102]:497 "EHLO
	tama5.ecl.ntt.co.jp") by vger.kernel.org with ESMTP id S261584AbVDRBnX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 21:43:23 -0400
Message-ID: <42631043.7000409@lab.ntt.co.jp>
Date: Mon, 18 Apr 2005 10:41:23 +0900
From: Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>,
       Daniel Jacobowitz <dan@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 & x86_64: Live Patching Funcion on 2.6.11.7
References: <4261DC62.1070300@lab.ntt.co.jp>	<20050416234439.5464e188.davem@davemloft.net>	<20050417185143.GA5002@nevyn.them.org> <20050417133252.353a5666.davem@davemloft.net>
In-Reply-To: <20050417133252.353a5666.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel-san, David-san,

Pannus project has two targets.
One is user-mode application live patching, and the other one is kernel 
live patching.
What we posted now is user-mode application live patching function.

 >If I'm right, I'm not sure why some of the bits of it were done
 >separately instead of via the existing ptrace mechanism.  And GDB
 >would appreciate a mechanism for mmap/munmap/mprotect in a debugged
 >process, also.

Daniel-san,
GDB based approach seems not fit to our requirements. GDB(ptrace) based 
functions are basically need to be done when target process is stopping. 
 From our experience, sometimes patches became to dozens to hundreds at 
one patching, and in this case GDB based approach cause target process's 
availability descent.

Patch exceeds 50k, so I cut comments and separate architecture, and post 
as in line.

David S. Miller wrote:
> On Sun, 17 Apr 2005 14:51:43 -0400
> Daniel Jacobowitz <dan@debian.org> wrote:
> 
> 
>>Takashi-san's description was not very clear, but it sounds like it's a
>>patching mechanism for userspace applications - not for kernel space.
>>So kprobes would not be a good fit.
> 
> 
> I saw the presentation of this stuff at the Linux Kernel conference
> last year in Tokyo.  I'm pretty sure it's for the kernel. :-)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
Takashi Ikebe
NTT Network Service Systems Laboratories
9-11, Midori-Cho 3-Chome Musashino-Shi,
Tokyo 180-8585 Japan
Tel : +81 422 59 4246, Fax : +81 422 60 4012
e-mail : ikebe.takashi@lab.ntt.co.jp
