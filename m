Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293201AbSCFEME>; Tue, 5 Mar 2002 23:12:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293203AbSCFELz>; Tue, 5 Mar 2002 23:11:55 -0500
Received: from [198.16.16.39] ([198.16.16.39]:40513 "EHLO carthage")
	by vger.kernel.org with ESMTP id <S293201AbSCFELp>;
	Tue, 5 Mar 2002 23:11:45 -0500
Date: Tue, 5 Mar 2002 22:02:15 -0600
From: James Curbo <jcurbo@acm.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: a couple of USB related Oopses
Message-ID: <20020306040215.GA694@carthage>
Reply-To: James Curbo <jcurbo@acm.org>
In-Reply-To: <20020305184604.GA4590@carthage> <20020305192307.GB10151@kroah.com> <20020305193317.GA5339@carthage> <20020305193732.GC10151@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <20020305193732.GC10151@kroah.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Debian GNU/Linux
Organization: Henderson State University, Arkadelphia, AR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

OK, after some compilation problems with 2.5.6-pre2 (ide-scsi wouldn't
compile, then OSS sound had an error too.. both not essential to me), I
got it up, and still got a panic. It's attached. Should I try the other
UHCI driver now?

On Mar 05, Greg KH wrote:
> On Tue, Mar 05, 2002 at 01:33:17PM -0600, James Curbo wrote:
> > On Mar 05, Greg KH wrote:
> > > Can you reproduce these with the 2.4.6-pre2 kernel?
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > 
> > I presume you mean 2.5.6-pre2, as 2.4 is way past that.. I will try it
> > tonight after I get in from work...
> 
> Yes, sorry about that :)
> 
> greg k-h

-- 
James Curbo <jcurbo@acm.org> <jc108788@rc.hsu.edu>
Undergraduate Computer Science, Henderson State University
PGP Keys at <http://reddie.henderson.edu/~curboj/>
Public Keys: PGP - 1024/0x76E2061B GNUPG - 1024D/0x3EEA7288

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ksymoops-output-3.txt"

ksymoops 2.4.3 on i686 2.5.6-pre2.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.6-pre2/ (default)
     -m /boot/System.map-2.5.6-pre2 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

No modules in ksyms, skipping objects
Warning (read_lsmod): no symbols in lsmod, is /proc/modules a valid lsmod file?
Warning (compare_maps): ksyms_base symbol idle_cpu_R__ver_idle_cpu not found in System.map.  Ignoring ksyms_base entry
Warning (compare_maps): ksyms_base symbol vmalloc_to_page_R__ver_vmalloc_to_page not found in System.map.  Ignoring ksyms_base entry
Unable to handle kernel paging request at virtual address 0080005e
c020a07f
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c020a07f>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 007fff92   ebx: d79e41c0   ecx: d79e41dc   edx: ce55c000
esi: 00000000   edi: d55468c0   ebp: ffffffed   esp: ce55df00
ds: 0018   es: 0018   ss: 0018
Stack: c021b7ca d79e41dc 000001f0 c02dfcc0 c02e0540 d55468c0 c020bd98 d6dad600 
       d55468c0 ce55c000 d55468c0 00000000 d6dad600 c0136d2f d6dad600 d55468c0 
       d55468c0 d6dad600 00000000 c142e380 c0135761 d6dad600 d55468c0 00000000 
Call Trace: [<c021b7ca>] [<c020bd98>] [<c0136d2f>] [<c0135761>] [<c0135672>] 
   [<c0135a57>] [<c0108a1f>] 
Code: 8b 80 cc 00 00 00 85 c0 74 17 8b 50 18 85 d2 74 10 8b 44 24 

>>EIP; c020a07e <usb_submit_urb+e/40>   <=====
Trace; c021b7ca <usblp_open+ba/110>
Trace; c020bd98 <usb_open+68/d0>
Trace; c0136d2e <chrdev_open+5e/a0>
Trace; c0135760 <dentry_open+e0/190>
Trace; c0135672 <filp_open+52/60>
Trace; c0135a56 <sys_open+36/80>
Trace; c0108a1e <syscall_call+6/a>
Code;  c020a07e <usb_submit_urb+e/40>
00000000 <_EIP>:
Code;  c020a07e <usb_submit_urb+e/40>   <=====
   0:   8b 80 cc 00 00 00         mov    0xcc(%eax),%eax   <=====
Code;  c020a084 <usb_submit_urb+14/40>
   6:   85 c0                     test   %eax,%eax
Code;  c020a086 <usb_submit_urb+16/40>
   8:   74 17                     je     21 <_EIP+0x21> c020a09e <usb_submit_urb+2e/40>
Code;  c020a088 <usb_submit_urb+18/40>
   a:   8b 50 18                  mov    0x18(%eax),%edx
Code;  c020a08a <usb_submit_urb+1a/40>
   d:   85 d2                     test   %edx,%edx
Code;  c020a08c <usb_submit_urb+1c/40>
   f:   74 10                     je     21 <_EIP+0x21> c020a09e <usb_submit_urb+2e/40>
Code;  c020a08e <usb_submit_urb+1e/40>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax


4 warnings issued.  Results may not be reliable.

--45Z9DzgjV8m4Oswq--
