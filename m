Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130743AbRBEQCb>; Mon, 5 Feb 2001 11:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130622AbRBEQCV>; Mon, 5 Feb 2001 11:02:21 -0500
Received: from cj30520-a.manss1.va.home.com ([24.7.169.75]:32785 "EHLO
	cj30520-a.manss1.va.home.com") by vger.kernel.org with ESMTP
	id <S129316AbRBEQCJ>; Mon, 5 Feb 2001 11:02:09 -0500
Date: Mon, 5 Feb 2001 11:02:07 -0500
From: Matthew Harrell <mharrell@bittwiddlers.com>
To: Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.{1,2pre1} oops in via82cxxx_audio (?)
Message-ID: <20010205110207.A11646@bittwiddlers.com>
In-Reply-To: <20010205104406.A10978@bittwiddlers.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.3.14i
In-Reply-To: <20010205104406.A10978@bittwiddlers.com>; from mharrell@bittwiddlers.com on Mon, Feb 05, 2001 at 10:44:06AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

: I'm not positive that's what's causing the oops but it seems to happen only
: when I load the sound driver and when esd starts to send a noise to the device.
: The oops and config are attached below.  Let me know if it's funny looking -
: I typed it in by hand after it killed the machine but it's easily reproducable.
: Also, while it doesn't seem to be deterministic it happens over 90% of the time

Just realized that some of those symbols were defined in the via82cxxx_audio
module and I needed to load it to get them recognized.  As long as I don't
play any sounds the module will load fine so here is the new and improved
ksymoops output

-- 
  Matthew Harrell                          Behind every great computer sits
  Bit Twiddlers, Inc.                       a skinny little geek.
  mharrell@bittwiddlers.com     

--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=output

ksymoops 0.7c on i686 2.4.2-pre1.  Options used
     -v /usr/src/linux/vmlinux (specified)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.2-pre1/ (default)
     -m /boot/System.map-2.4.2-pre1 (specified)

Unable to handle kernel NULL pointer reference at virtual address 00000004
d883a0a0
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:<d883a0a0>]
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010206
eax: 40000100   ebx: cff5aa38   ecx: 0000000a   edx: 00000000
esi: 00000000   edi: 0000000a   ebp: c02b1fa0   esp: c02b1f40
ds: 0018   es: 0018   ss:0018
Process swapper (pid: 0, stackpage=c02b1000)
Stack: 00001111 cff5a800 d883a15f cff5aa38 cca5da80 04000001 c010a2bf 0000000a
       cff5a800 c02b1fa0 00000280 c02e7b80 0000000a c02b1f98 c010a43e 0000000a
       c02b1fa0 cca5da80 00006f62 c02b0000 c031b820 cca5da80 0008e000 c0108f80
Call Trace: [<d883a15f>] [<c010a2bf>] [<c010a43e>] [<c0108f80>]
            [<c01f480a>] [<c01f4620>] [<c0107130>] [<c01071c2>]
            [<c0105000>] [<c0100191>]
Code: 89 44 f2 04 ff 43 04 8b 53 2c 89 d0 ff 43 1c 03 43 20 89 43

>>EIP; d883a0a0 <[via82cxxx_audio]via_intr_channel+90/120>   <=====
Trace; d883a15f <[via82cxxx_audio]via_interrupt+2f/70>
Trace; c010a2bf <handle_IRQ_event+2f/60>
Trace; c010a43e <do_IRQ+6e/b0>
Trace; c0108f80 <ret_from_intr+0/20>
Trace; c01f480a <acpi_idle+1ea/2b0>
Trace; c01f4620 <acpi_idle+0/2b0>
Trace; c0107130 <default_idle+0/30>
Trace; c01071c2 <cpu_idle+42/60>
Trace; c0105000 <empty_bad_page+0/1000>
Trace; c0100191 <L6+0/2>
Code;  d883a0a0 <[via82cxxx_audio]via_intr_channel+90/120>
00000000 <_EIP>:
Code;  d883a0a0 <[via82cxxx_audio]via_intr_channel+90/120>   <=====
   0:   89 44 f2 04               mov    %eax,0x4(%edx,%esi,8)   <=====
Code;  d883a0a4 <[via82cxxx_audio]via_intr_channel+94/120>
   4:   ff 43 04                  incl   0x4(%ebx)
Code;  d883a0a7 <[via82cxxx_audio]via_intr_channel+97/120>
   7:   8b 53 2c                  mov    0x2c(%ebx),%edx
Code;  d883a0aa <[via82cxxx_audio]via_intr_channel+9a/120>
   a:   89 d0                     mov    %edx,%eax
Code;  d883a0ac <[via82cxxx_audio]via_intr_channel+9c/120>
   c:   ff 43 1c                  incl   0x1c(%ebx)
Code;  d883a0af <[via82cxxx_audio]via_intr_channel+9f/120>
   f:   03 43 20                  add    0x20(%ebx),%eax
Code;  d883a0b2 <[via82cxxx_audio]via_intr_channel+a2/120>
  12:   89 43 00                  mov    %eax,0x0(%ebx)


--fdj2RfSjLxBAspz7--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
