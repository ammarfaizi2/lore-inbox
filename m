Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbTHOJkf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 05:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275485AbTHOJkf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 05:40:35 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:37604 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S261151AbTHOJkc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 05:40:32 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Fri, 15 Aug 2003 11:40:30 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Chris Mason <mason@suse.com>
Cc: marcelo@conectiva.com.br, green@namesys.com, akpm@osdl.org, andrea@suse.de,
       alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030815114030.26890199.skraw@ithnet.com>
In-Reply-To: <1060913337.1493.29.camel@tiny.suse.com>
References: <20030814084518.GA5454@namesys.com>
	<Pine.LNX.4.44.0308141425460.3360-100000@localhost.localdomain>
	<20030814194226.2346dc14.skraw@ithnet.com>
	<1060913337.1493.29.camel@tiny.suse.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Aug 2003 22:08:58 -0400
Chris Mason <mason@suse.com> wrote:

> On Thu, 2003-08-14 at 13:42, Stephan von Krawczynski wrote:
> 
> > Hello Marcelo,
> > 
> > the system is up and running, currently:
> > 
> >   7:40pm  up 4 days  2:34,  21 users,  load average: 2.07, 2.10, 2.06
> > 
> > there is still the verification issue, today I added another 50 GB to the
> > data stream, and therefore got additional 3 verification  errors. But this
> > seems to have no influence on the stability. Box feels ok, reacts
> > completely normal, no strange output in any logs.
> 
> Just to second Oleg's messages so far, the verification issues are still
> serious, it could be the same kind of memory corruptions that could be
> causing crashes on reiserfs, just in a different place.

Well, as you expected I have the oops for you happened just this morning:

ksymoops 2.4.8 on i686 2.4.22-rc2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-rc2/ (default)
     -m /boot/System.map-2.4.22-rc2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

NMI Watchdog detected LOCKUP on CPU0, eip c01457c3, registers:
CPU:    0
EIP:    0010:[<c01457c3>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00000046
eax: 00000019   ebx: effc5c7c   ecx: 00000000   edx: effc6c7c
esi: 00000001   edi: 00000202   ebp: c13956c0   esp: f6ae1e8c
ds: 0018   es: 0018   ss: 0018
Process setiathome (pid: 2696, stackpage=f6ae1000)
Stack: f79ba218 effc5c7c f710eab8 00000008 c02165ea effc5c7c 00000001 ffffffff
       f79ba298 f79ba218 00000001 00000010 00000001 f710ea00 c0216a0f f710ea00
       00000001 00000000 00000001 00000001 ffffffff ffffffff 0000001c 00000000
Call Trace:    [<c02165ea>] [<c0216a0f>] [<c024a47a>] [<c020f6b8>] [<c020f568>]
  [<c01226da>] [<c0122563>] [<c01222d6>] [<c0109508>] [<c010c048>]
Code: 75 eb a8 01 0f 44 f1 8b 52 28 39 da 75 ea c6 05 64 5d 30 c0


>>EIP; c01457c3 <end_buffer_io_async+63/b0>   <=====

>>ebx; effc5c7c <_end+2fbfe61c/38462a00>
>>edx; effc6c7c <_end+2fbff61c/38462a00>
>>ebp; c13956c0 <_end+fce060/38462a00>
>>esp; f6ae1e8c <_end+3671a82c/38462a00>

Trace; c02165ea <__scsi_end_request+ba/250>
Trace; c0216a0f <scsi_io_completion+15f/430>
Trace; c024a47a <rw_intr+5a/200>
Trace; c020f6b8 <scsi_finish_command+98/d0>
Trace; c020f568 <scsi_bottom_half_handler+c8/f0>
Trace; c01226da <bh_action+6a/70>
Trace; c0122563 <tasklet_hi_action+53/a0>
Trace; c01222d6 <do_softirq+76/e0>
Trace; c0109508 <do_IRQ+d8/f0>
Trace; c010c048 <call_do_IRQ+5/d>

Code;  c01457c3 <end_buffer_io_async+63/b0>
00000000 <_EIP>:
Code;  c01457c3 <end_buffer_io_async+63/b0>   <=====
   0:   75 eb                     jne    ffffffed <_EIP+0xffffffed>   <=====
Code;  c01457c5 <end_buffer_io_async+65/b0>
   2:   a8 01                     test   $0x1,%al
Code;  c01457c7 <end_buffer_io_async+67/b0>
   4:   0f 44 f1                  cmove  %ecx,%esi
Code;  c01457ca <end_buffer_io_async+6a/b0>
   7:   8b 52 28                  mov    0x28(%edx),%edx
Code;  c01457cd <end_buffer_io_async+6d/b0>
   a:   39 da                     cmp    %ebx,%edx
Code;  c01457cf <end_buffer_io_async+6f/b0>
   c:   75 ea                     jne    fffffff8 <_EIP+0xfffffff8>
Code;  c01457d1 <end_buffer_io_async+71/b0>
   e:   c6 05 64 5d 30 c0 00      movb   $0x0,0xc0305d64


1 warning issued.  Results may not be reliable.


Obviously the problem seems a lot harder to trigger with ext3, but nevertheless
comes up (this time around 5 days). I will try Chris' suggestions  and see what
happens. I'll keep you informed.

Regards,
Stephan
