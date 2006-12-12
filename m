Return-Path: <linux-kernel-owner+w=401wt.eu-S1751255AbWLLMYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWLLMYO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 07:24:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWLLMYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 07:24:14 -0500
Received: from smtpout.mac.com ([17.250.248.175]:61799 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751255AbWLLMYN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 07:24:13 -0500
In-Reply-To: <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
References: <457D750C.9060807@shadowen.org> <20061211163333.GA17947@aepfle.de> <Pine.LNX.4.64.0612110840240.12500@woody.osdl.org> <Pine.LNX.4.64.0612110852010.12500@woody.osdl.org> <20061211180414.GA18833@aepfle.de> <20061211181813.GB18963@aepfle.de> <Pine.LNX.4.64.0612111022140.12500@woody.osdl.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <320BD259-74D6-411F-82A4-4BF3CB15012F@mac.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Mach-O binary format support and Darwin syscall personality [Was: uts banner changes]
Date: Tue, 12 Dec 2006 07:23:17 -0500
To: LKML Kernel <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
X-Proofpoint-Virus-Version: vendor=fsecure engine=4.65.5446:2.3.11,1.2.37,4.0.164 definitions=2006-12-12_03:2006-12-12,2006-12-10,2006-12-12 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=3.1.0-0612050001 definitions=main-0612120006
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec 11, 2006, at 13:26:13, Linus Torvalds wrote:
> On Mon, 11 Dec 2006, Olaf Hering wrote:
>> Hmm, even moving this to linux_banner doesnt work, just because  
>> __initdata is in a different section.
>
> Heh. Let's just change the "version_read_proc" string to not trigger.
>
> Something like this instead (which replaces the "Linux" with "%s"  
> in /proc, and just takes it from "utsname()->sysname" instead. So  
> now you can lie and call yourself "OS X" in your virtual partition  
> if you want to ;)

Funny you should mention that...  I'm currently tinkering with a  
binfmt_mach_o kernel module and associated Darwin syscall personality  
to try to load and run console Mach-O binaries natively under PPC or  
X86 linux (depending on what architectures the Mach-O binary supports).

I've basically got the binary loader part working; the Mach-O dynamic  
loader gets mapped into memory at the appropriate location, the  
kernel jumps to the specified location in the code... and then the  
program comes crashing to a halt when it starts calling invalid  
syscalls with bogus arguments.

So now I have to figure out how to set up a new syscall personality  
with a bunch of wrapper syscalls which reorder arguments and  
translate constant values before calling into the rest of the Linux  
code.  I'm fairly sure it's possible because you can run some Solaris  
binaries under Linux if you turn on the appropriate BINFMT_* config  
option(s), but I'm totally unsure as to _how_.

I'd much appreciate any advice you can give!

Cheers,
Kyle Moffett

