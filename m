Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbTFJFkY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 01:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbTFJFkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 01:40:24 -0400
Received: from mail.cpt.sahara.co.za ([196.41.29.142]:4859 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S262368AbTFJFkS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 01:40:18 -0400
Subject: Re: [RFC PATCH] Re: [OOPS] w83781d during rmmod (2.5.69-bk17)
From: Martin Schlemmer <azarah@gentoo.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
In-Reply-To: <1055136870.5280.196.camel@workshop.saharacpt.lan>
References: <20030524183748.GA3097@earth.solarsys.private>
	 <3ED8067E.1050503@paradyne.com>
	 <20030601143808.GA30177@earth.solarsys.private>
	 <20030602172040.GC4992@kroah.com>
	 <20030605023922.GA8943@earth.solarsys.private>
	 <20030605194734.GA6238@kroah.com>
	 <1055136870.5280.196.camel@workshop.saharacpt.lan>
Content-Type: text/plain
Organization: 
Message-Id: <1055223515.5280.214.camel@workshop.saharacpt.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 10 Jun 2003 07:38:35 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-09 at 07:34, Martin Schlemmer wrote:
> On Thu, 2003-06-05 at 21:47, Greg KH wrote:
> > On Wed, Jun 04, 2003 at 10:39:22PM -0400, Mark M. Hoffman wrote:
> > > * Greg KH <greg@kroah.com> [2003-06-02 10:20:40 -0700]:
> > > > On Sun, Jun 01, 2003 at 10:38:08AM -0400, Mark M. Hoffman wrote:
> > > > > 
> > > > > This patch against 2.5.70 works for me vs. an SMBus adapter.  It needs
> > > > > re-testing against an ISA adapter since my particular chip is SMBus only.
> > > > 
> > > > I've applied this and will send it off to Linus in a bit.
> > > 
> > > Thanks!
> > > 
> > > This patch fixes the various return values in the w83781d_detect()
> > > error paths.  It also cleans up some formatting here and there.
> > > It should be applied on top of the previous one.
> > > 
> > > It works for me; same caveat as above w.r.t. ISA.
> > 
> > Applied, thanks.
> > 
> 
> Things have changed since I converted this driver to 2.5.  I no longer
> have the 850E chipset mobo with w83781d sensor, but a 875p chipset
> mobo, with W83627THF (basically the same as the W83627HF, just with
> advance fan control .. prob the Q-Fan option in the Asus board?).
> 
> I sorda got the ICH5 talking, and can get the driver loaded for the
> W83627THF (as W83627HF), but all the values seems borked.  Unfortunately
> I cannot get a spec sheet on the  W83627THF.  Is anybody working on
> ICH5/W83627THF support ?
> 
> Anyhow, Only change I have made to the w83781d driver, is one line
> (just tell it to that if the chip id is 0x72, its also of type
> w83726HF), but now (2.5.70-bk1[123]) it segfaults for me on rmmod, where
> it did not with 2.5.68 kernels when I still had the other board.  I will
> attach a oops tomorrow or such when I get home.
> 

Ok, here is the oops.  Shout if more info is needed.

---------
ksymoops 2.4.8 on i686 2.5.70-bk14.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.70-bk14/ (default)
     -m /usr/src/linux/System.map (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Error (regular_file): read_ksyms stat /proc/ksyms failed
No modules in ksyms, skipping objects
No ksyms, skipping lsmod
Oops: 0000 [#1]
CPU:    0
EIP:    0060:[<fc868421>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010203
eax: fc848744   ebx: f6e3851c   ecx: 00000000   edx: 6b6b6b6b
esi: 6b6b6b6b   edi: fc84874c   ebp: fc8485e0   esp: f2195f2c
ds: 007b   es: 007b   ss: 0068
Stack: f6e38310 0000004c f7232b18 00000296 f7ffd760 fc903164 fc903600
00000880
       c0309298 00000000 fc900107 fc903160 c012f049 fc903600 bffff728
0000003b
       00000000 37333877 00643138 c0141620 f757ddf4 f7232b1c f7232870
40016000
Call Trace:
 [<fc903164>] w83781d_driver+0x4/0xa8 [w83781d]
 [<fc903600>] +0x0/0x200 [w83781d]
 [<fc900107>] +0xf/0x13 [w83781d]
 [<fc903160>] w83781d_driver+0x0/0xa8 [w83781d]
 [<c012f049>] sys_delete_module+0x12b/0x195
 [<fc903600>] +0x0/0x200 [w83781d]
 [<c0141620>] do_munmap+0x146/0x183
 [<c010a7d5>] sysenter_past_esp+0x52/0x71
Code: 8b 36 39 c2 75 df 8b 0f 8b 01 89 cf 89 c1 0f 18 00 90 81 ff


>>EIP; fc868421 <_end+3c3981dd/3fb2ddbc>   <=====

>>eax; fc848744 <_end+3c378500/3fb2ddbc>
>>ebx; f6e3851c <_end+369682d8/3fb2ddbc>
>>edi; fc84874c <_end+3c378508/3fb2ddbc>
>>ebp; fc8485e0 <_end+3c37839c/3fb2ddbc>
>>esp; f2195f2c <_end+31cc5ce8/3fb2ddbc>

Trace; fc903164 <_end+3c432f20/3fb2ddbc>
Trace; fc903600 <_end+3c4333bc/3fb2ddbc>
Trace; fc900107 <_end+3c42fec3/3fb2ddbc>
Trace; fc903160 <_end+3c432f1c/3fb2ddbc>
Trace; c012f049 <sys_delete_module+12b/195>
Trace; fc903600 <_end+3c4333bc/3fb2ddbc>
Trace; c0141620 <do_munmap+146/183>
Trace; c010a7d5 <sysenter_past_esp+52/71>

Code;  fc868421 <_end+3c3981dd/3fb2ddbc>
00000000 <_EIP>:
Code;  fc868421 <_end+3c3981dd/3fb2ddbc>   <=====
   0:   8b 36                     mov    (%esi),%esi   <=====
Code;  fc868423 <_end+3c3981df/3fb2ddbc>
   2:   39 c2                     cmp    %eax,%edx
Code;  fc868425 <_end+3c3981e1/3fb2ddbc>
   4:   75 df                     jne    ffffffe5 <_EIP+0xffffffe5>
Code;  fc868427 <_end+3c3981e3/3fb2ddbc>
   6:   8b 0f                     mov    (%edi),%ecx
Code;  fc868429 <_end+3c3981e5/3fb2ddbc>
   8:   8b 01                     mov    (%ecx),%eax
Code;  fc86842b <_end+3c3981e7/3fb2ddbc>
   a:   89 cf                     mov    %ecx,%edi
Code;  fc86842d <_end+3c3981e9/3fb2ddbc>
   c:   89 c1                     mov    %eax,%ecx
Code;  fc86842f <_end+3c3981eb/3fb2ddbc>
   e:   0f 18 00                  prefetchnta (%eax)
Code;  fc868432 <_end+3c3981ee/3fb2ddbc>
  11:   90                        nop    
Code;  fc868433 <_end+3c3981ef/3fb2ddbc>
  12:   81 ff 00 00 00 00         cmp    $0x0,%edi


1 warning and 1 error issued.  Results may not be reliable.



-- 
Martin Schlemmer


