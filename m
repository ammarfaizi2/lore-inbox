Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272419AbTGZE0T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Jul 2003 00:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272420AbTGZE0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Jul 2003 00:26:19 -0400
Received: from CPE000625926cd6-CM014480115318.cpe.net.cable.rogers.com ([24.157.137.42]:9601
	"EHLO daedalus.samhome.net") by vger.kernel.org with ESMTP
	id S272419AbTGZE0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Jul 2003 00:26:16 -0400
Subject: Re: Firewire (One fix worked, now getting oops)
From: Sam Bromley <sbromley@cogeco.ca>
Reply-To: sbromley@cogeco.ca
To: Ben Collins <bcollins@debian.org>
Cc: gaxt <gaxt@rogers.com>, Torrey Hoffman <thoffman@arnor.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       linux firewire devel <linux1394-devel@lists.sourceforge.net>
In-Reply-To: <20030725201128.GA535@phunnypharm.org>
References: <20030725154009.GF1512@phunnypharm.org>
	 <20030725160706.GK23196@ruvolo.net> <20030725161803.GJ1512@phunnypharm.org>
	 <1059155483.2525.16.camel@torrey.et.myrio.com>
	 <20030725181303.GO23196@ruvolo.net> <20030725181252.GA607@phunnypharm.org>
	 <3F217A39.2020803@rogers.com> <20030725182642.GD607@phunnypharm.org>
	 <20030725184506.GE607@phunnypharm.org> <20030725193515.GQ23196@ruvolo.net>
	 <20030725201128.GA535@phunnypharm.org>
Content-Type: text/plain
Message-Id: <1059194478.655.49.camel@daedalus.samhome.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 26 Jul 2003 00:41:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-25 at 16:11, Ben Collins wrote:
> On Fri, Jul 25, 2003 at 12:35:15PM -0700, Chris Ruvolo wrote:
> > On Fri, Jul 25, 2003 at 02:45:06PM -0400, Ben Collins wrote:
> > > Maybe it wont. Try reverting back to stock, and apply this patch. I am
> > > pretty sure this will fix the problem for anyone having this issue.
> > 
> > Yes, I think this did it!  One change: needed to change HSBP_VERBOSE to
> > HSBP_DEBUG in csr.c.  
> > 
> > I will try turning on my DV camera tonight (I'm remote now) and I'll let you
> > know how that goes.
> 
> Kick ass. I've commited this change to the 1394 repo. Linus will get the
> fix soon. I'll also send it to Marcelo for 2.4.22.
> 
> Please, if you are testing, use the code at www.linux1394.org's viewcvs
> (trunk tarball will replace drivers/ieee1394 in 2.6, branches/linux-2.4
> will do the same for 2.4).
> 
> 
> Thanks for help in tracking this down.

Hi,
First, thank you all for being so diligent.
The unsolicited packet problem seems to have
been resolved. However, by running gscanbus,
then unplugging a camera and replugging it in,
I got the following oops:

Unable to handle kernel paging request at virtual address 08103a8c
 printing eip:
402fd1de
*pde = 07b1c067
*pte = 00000000
Oops: 0006 [#1]
CPU:    0
EIP:    0073:[<402fd1de>]    Not tainted
EFLAGS: 00010202
EIP is at 0x402fd1de
eax: 00001579   ebx: 4039ff60   ecx: 00001009   edx: 08103a88
esi: 00000004   edi: 00000000   ebp: bfffc788   esp: bfffc760
ds: 007b   es: 007b   ss: 007b
Process gscanbus (pid: 2525, threadinfo=c2314000 task=dc4af000)
 <6>note: gscanbus[2525] exited with preempt_count 1

-----------
Ok, you'll have to forgive me here, as I've never used
ksymoops before, but here is my attempt:


ksymoops 2.4.8 on i686 2.6.0-test1-ac1.  Options used
     -v /boot/vmlinuz-2.6.0-test1-ac2 (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.6.0-test1-ac1/ (default)
     -m /boot/System.map-2.6.0-test1-ac2 (specified)

/usr/bin/nm: /boot/vmlinuz-2.6.0-test1-ac2: File format not recognized
Error (pclose_local): read_nm_symbols pclose failed 0x100
Warning (read_vmlinux): no kernel symbols in vmlinux, is
/boot/vmlinuz-2.6.0-test1-ac2 a valid vmlinux file?
Error (regular_file): read_ksyms stat /proc/ksyms failed
ksymoops: No such file or directory
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Reading Oops report from the terminal
402fd1de
*pde = 07b1c067
*pte = 00000000
Oops: 0006 [#1]
CPU:    0
EIP:    0073:[<402fd1de>]    Not tainted
EFLAGS: 00010202
EIP is at 0x402fd1de
eax: 00001579   ebx: 4039ff60   ecx: 00001009   edx: 08103a88
esi: 00000004   edi: 00000000   ebp: bfffc788   esp: bfffc760
ds: 007b   es: 007b   ss: 007b
Process gscanbus (pid: 2525, threadinfo=c2314000 task=dc4af000)
 <6>note: gscanbus[2525] exited with preempt_count 1
402fd1de
*pde = 07b1c067
Oops: 0006 [#1]
CPU:    0
EIP:    0073:[<402fd1de>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 00001579   ebx: 4039ff60   ecx: 00001009   edx: 08103a88
esi: 00000004   edi: 00000000   ebp: bfffc788   esp: bfffc760
ds: 007b   es: 007b   ss: 007b

Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; 402fd1de <__crc_param_set_short+2b6895/75bf8f>   <=====

>>ebx; 4039ff60 <__crc_param_set_short+359617/75bf8f>
>>edx; 08103a88 <__crc_ip_finish_output+23c39/133bb1>
>>ebp; bfffc788 <__crc_class_device_add+4dfb67/51fa16>
>>esp; bfffc760 <__crc_class_device_add+4dfb3f/51fa16>


2 warnings and 2 errors issued.  Results may not be reliable.

--------
Please point me to a quick reference to the proper
usage of ksymoops if this info is at your finger tips.

Since I see the preempt bit above, I'll try compiling
without a preemtible kernel and will report the results
tomorrow.

Cheers,
Sam.




