Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261373AbSJLXXE>; Sat, 12 Oct 2002 19:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261374AbSJLXXE>; Sat, 12 Oct 2002 19:23:04 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:31375 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S261373AbSJLXXD>; Sat, 12 Oct 2002 19:23:03 -0400
Date: Sat, 12 Oct 2002 19:28:43 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.42 ide-scsi loads!
Message-ID: <20021012232843.GA1663@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021012213756.GA1582@Master.Wizards> <Pine.LNX.4.44.0210121740330.970-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0210121740330.970-100000@dad.molina>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 12, 2002 at 05:46:07PM -0500, Thomas Molina wrote:
> On Sat, 12 Oct 2002, Murray J. Root wrote:
> 
> > It's fixed.
> > ide-scsi loaded 4 out of 4 tries.
> 
> Modular?  If yes, try rmmod ide-scsi.  I am still getting the exact same 
> oops and hang I got in:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=103351991417181&w=2
> 
> To summarize:  If I load ide-scsi on boot and don't remove any components 
> while up I don't have a problem.  If I rmmod and ide-scsi related module I 
> get an oops with apparent register poisoning (signature 5a5a5a5a in the 
> register).  After one of these oops I get a hang on shutdown.  The oops 
> and hang I get in 2.5.42 is exactly the same as that in the cited message.

Ugh. Here I was all happy that my ide-scsi works and you had to go mess it up.

rmmod fails spectacularly.

[root@Master grimau]# rmmod ide-scsi

 ------------[ cut here ]------------
 kernel BUG at drivers/base/core.c:251!
 invalid operand: 0000
 snd-pcm-oss snd-mixer-oss snd-emu10k1 snd-pcm snd-timer snd-rawmidi snd-util-mem snd-ac97-codec snd-hwdep snd-seq-device snd soundcore sis900 crc32 nls_cp850 vfat fat ide-scsi scsi_mod rtc  
 CPU:    0
 EIP:    0060:[<c01f4741>]    Not tainted
 EFLAGS: 00010202
 EIP is at put_device+0x71/0x90
 eax: 00000001   ebx: f79c3934   ecx: f79c39c8   edx: 00000001
 esi: f7dcd684   edi: f7dcd600   ebp: fa8f9720   esp: f6ea5f18
 ds: 0068   es: 0068   ss: 0068
 Process rmmod (pid: 1327, threadinfo=f6ea4000 task=f708a180)
 Stack: f79c39c8 c03137d0 f79c3800 00000000 fa8e816d f79c3934 f6ea4000 0806f004 
        00035ea6 00000000 00000282 000001ff 00000000 c02e4e7c 00000000 c013903c 
        c02e4cd4 00000206 c02e4d84 c02e0508 fa8f7000 fffffff0 00000000 bfffe918 
 Call Trace:
  [<fa8e816d>] scsi_unregister_host_Rd44b9f19+0x38d/0x510 [scsi_mod]
  [<c013903c>] __alloc_pages+0x7c/0x2a0
  [<fa8f851f>] exit_idescsi_module+0xf/0x20 [ide-scsi]
  [<fa8f9720>] idescsi_template+0x0/0x80 [ide-scsi]
  [<c011be23>] free_module+0xe3/0xf0
  [<c011b0d3>] sys_delete_module+0xd3/0x2a0
  [<c010786b>] syscall_call+0x7/0xb
  
 Code: 0f 0b fb 00 46 57 2c c0 eb d5 e8 e0 17 f2 ff eb c4 8d b4 26
 
-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 

