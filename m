Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261640AbTAIFzz>; Thu, 9 Jan 2003 00:55:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261642AbTAIFzz>; Thu, 9 Jan 2003 00:55:55 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:44749
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S261640AbTAIFzy>; Thu, 9 Jan 2003 00:55:54 -0500
Message-ID: <3E1D10F2.9060301@tupshin.com>
Date: Wed, 08 Jan 2003 22:04:34 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: oops while vmware-config.pl with kernel 2.4.21-pre2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm going to forward this to the vmware folks, but there's a decent 
chance they are not totally to blame:

I did the following:
sudo vmware-config.pl
at some point during vmware's unloading of modules, compiling of new 
ones, and loading of new ones, I got the enclosed oops.

What is interesting is that the process became unkillable, as has every 
subsequent sudoed command. su works just fine, but everything that is 
sudoed hangs and is unkillable.

-Tupshin


Jan  8 21:40:41 fussbudget kernel: c0213b17
Jan  8 21:40:41 fussbudget kernel: Oops: 0002
Jan  8 21:40:41 fussbudget kernel: CPU:    0
Jan  8 21:40:41 fussbudget kernel: EIP:    0010:[skb_clone+407/448] 
Tainted: PF
Jan  8 21:40:41 fussbudget kernel: EFLAGS: 00010246
Jan  8 21:40:41 fussbudget kernel: eax: 00000000   ebx: caa92074   ecx: 
00000000   edx: 00000000
Jan  8 21:40:41 fussbudget kernel: esi: caa920d0   edi: c4db7a1c   ebp: 
c4db79c0   esp: dc169e54
Jan  8 21:40:41 fussbudget kernel: ds: 0018   es: 0018   ss: 0018
Jan  8 21:40:41 fussbudget kernel: Process ifconfig (pid: 4563, 
stackpage=dc169000)
Jan  8 21:40:41 fussbudget kernel: Stack: ddb63004 ddb63000 00000000 
ddb63000 e4f287e3 caa92074 00000020 000000c8
Jan  8 21:40:41 fussbudget kernel:        0012a4e7 00000001 c0225a95 
c03745a0 caa92000 caa92074 caa92074 00000000
Jan  8 21:40:41 fussbudget kernel:        e4f27fb1 ddb6304c caa92074 
caa92074 00000000 656e6d76 00000000 00001002
Jan  8 21:40:41 fussbudget kernel: Call Trace:    [<e4f287e3>] 
[rt_cache_flush+181/224] [<e4f27fb1>] [<e4f29c1c>] [dev_open+76/176]
Jan  8 21:40:41 fussbudget kernel: Code: ff 00 8b 83 98 00 00 00 c6 43 
69 01 85 c0 74 04 8b 00 ff 00
Using defaults from ksymoops -t elf32-i386 -a i386


 >>ebx; caa92074 <_end+a71aaac/20609a98>
 >>esi; caa920d0 <_end+a71ab08/20609a98>
 >>edi; c4db7a1c <_end+4a40454/20609a98>
 >>ebp; c4db79c0 <_end+4a403f8/20609a98>
 >>esp; dc169e54 <_end+1bdf288c/20609a98>

Trace; e4f287e3 <[vmnet]VNetHubReceive+57/a7>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   ff 00                     incl   (%eax)
Code;  00000002 Before first symbol
    2:   8b 83 98 00 00 00         mov    0x98(%ebx),%eax
Code;  00000008 Before first symbol
    8:   c6 43 69 01               movb   $0x1,0x69(%ebx)
Code;  0000000c Before first symbol
    c:   85 c0                     test   %eax,%eax
Code;  0000000e Before first symbol
    e:   74 04                     je     14 <_EIP+0x14>
Code;  00000010 Before first symbol
   10:   8b 00                     mov    (%eax),%eax
Code;  00000012 Before first symbol
   12:   ff 00                     incl   (%eax)

