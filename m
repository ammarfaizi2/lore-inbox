Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265158AbRGENiy>; Thu, 5 Jul 2001 09:38:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265174AbRGENin>; Thu, 5 Jul 2001 09:38:43 -0400
Received: from pop.gmx.net ([194.221.183.20]:35610 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S265158AbRGENic>;
	Thu, 5 Jul 2001 09:38:32 -0400
Date: Thu, 5 Jul 2001 13:04:55 +0200
From: "Manfred H. Winter" <mahowi@gmx.net>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: [2.4.6] kernel BUG at softirq.c:206!
Message-ID: <20010705130455.A698@marvin.mahowi.de>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010704232816.B590@marvin.mahowi.de>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.5 i686
X-Editor: VIM - Vi IMproved 5.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Wed, 04 Jul 2001, Manfred H. Winter wrote:

> 
> I tried to install kernel 2.4.6 with same configuration as 2.4.5, but
> booting failed with:
> 
> kernel BUG at softirq.c:206!
> invalid operand: 0000
> CPU:    0
> EIP:    0010:[<c0117f2e>]
> EFLAGS: 00010082
> eax: 0000001d  ebx: c025bf80  ecx: 00000001  edx: c0206628
> esi: c025bf80  edi: 00000001  ebp: 00000000  esp: c0213efc
> ds: 0018  es: 0018  ss: 0018
> Process swapper (pid: 0, stackpage=c0213000)
> Stack: c01d896c c01d8a08 000000ce 00000009 c02445c0 c02445c0 c0213f40 c0117d3f
>        c02445c0 00000000 c0242900 00000000 c010818d c020b5e0 c0213f9f 000003c7
>        c0205ba0 000003c7 c0106d80 c020b5e0 00000000 000003c7 c0213f9f 000003c7
> Call Trace: [<c0117d3f>] [<c010818d>] [<c0106d80>] [<c011493f>] [<c0105000>]
> Code: 0f 0b 83 c4 0c 8b 43 08 85 c0 75 18 fb 8b 43 10 50 8b 43 0c
> Kernel panic: Aiee, killing interrupt handler!
> In interrupt handler - not syncing
> 

Because the kernel crashed in early stage of booting, there are no logs,
but I've written it from screen.

Here's what ksymoops says:

>>EIP; c0117f2e <tasklet_hi_action+6a/b4>   <=====
Trace; c0117d3f <do_softirq+3f/68>
Trace; c010818d <do_IRQ+9d/b0>
Trace; c0106d80 <ret_from_intr+0/7>
Trace; c011493f <register_console+22b/234>
Trace; c0105000 <_stext+0/0>
Code;  c0117f2e <tasklet_hi_action+6a/b4>
00000000 <_EIP>:
Code;  c0117f2e <tasklet_hi_action+6a/b4>   <=====
   0:   0f 0b                     ud2a      <=====
Code;  c0117f30 <tasklet_hi_action+6c/b4>
   2:   83 c4 0c                  add    $0xc,%esp
Code;  c0117f33 <tasklet_hi_action+6f/b4>
   5:   8b 43 08                  mov    0x8(%ebx),%eax
Code;  c0117f36 <tasklet_hi_action+72/b4>
   8:   85 c0                     test   %eax,%eax
Code;  c0117f38 <tasklet_hi_action+74/b4>
   a:   75 18                     jne    24 <_EIP+0x24> c0117f52 <tasklet_hi_action+8e/b4>
Code;  c0117f3a <tasklet_hi_action+76/b4>
   c:   fb                        sti
Code;  c0117f3b <tasklet_hi_action+77/b4>
   d:   8b 43 10                  mov    0x10(%ebx),%eax
Code;  c0117f3e <tasklet_hi_action+7a/b4>
  10:   50                        push   %eax
Code;  c0117f3f <tasklet_hi_action+7b/b4>
  11:   8b 43 0c                  mov    0xc(%ebx),%eax

Kernel panic: Aiee, killing interrupt handler!

Hope that helps to find the bug, it's the first kernel in the 2.4 series
which doesn't boot.

Bye,

Manfred
-- 
 /"\                        | PGP-Key available at Public Key Servers
 \ /  ASCII ribbon campaign | or "http://www.mahowi.de/pgp/mahowi.asc"
  X   against HTML mail     | RSA: 0xC05BC0F5 * DSS: 0x4613B5CA
 / \  and postings          | AIM: mahowi42   * ICQ: 61597169
