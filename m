Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275082AbTHGCOp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 22:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275084AbTHGCOp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 22:14:45 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:5792 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S275082AbTHGCOm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 22:14:42 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Thu, 7 Aug 2003 04:14:40 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org, green@namesys.com
Subject: Re: 2.4.22-pre lockups (now decoded oops for pre10)
Message-Id: <20030807041440.12341286.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.44.0308061506170.4979-100000@logos.cnet>
References: <20030806094150.4d7b0610.skraw@ithnet.com>
	<Pine.LNX.4.44.0308061506170.4979-100000@logos.cnet>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Aug 2003 15:15:39 -0300 (BRT)
Marcelo Tosatti <marcelo@conectiva.com.br> wrote:

> Stephan,
> 
> I'm pretty worried about this problem.
> 
> Your oopses seem to be the result of some kind of memory corruption. On
> the other oopses we could see the kernel oopsing on
> remove_page_from_hash_queue due to corrupted pointers (as Willy pointed 
> out). 
> 
> Can you please try to crash your box again with 
> 
> CONFIG_DEBUG_SLAB=y 
> 
> Again, thanks a lot for your reports.

Ok, I have two things. 
First, another oops. I upgraded the system to rc1 yesterday and it did not
survive a single day. Here's the decoded oops, the box was "clean" meaning no
weird modules or the like:


ksymoops 2.4.8 on i686 2.4.22-rc1.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.22-rc1/ (default)
     -m /boot/System.map-2.4.22-rc1 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000004
c0145060
*pde = 00000000
Oops: 0002
CPU:    1
EIP:    0010:[<c0145060>]    Not tainted   
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010283
eax: 00000000   ebx: c822feb4   ecx: c822fe60   edx: e07e7780
esi: 00000000   edi: e07e7780   ebp: f59bfe3c   esp: f59bfe2c
ds: 0018   es: 0018   ss: 0018
Process nfsd (pid: 1737, stackpage=f59bf000)
Stack: f0cce7a0 00000001 f59bfe38 c822fe60 f0cce7f4 eec54ef4 00000000 e07e7760
       f59be000 f59bfea8 c0183ef5 e07e7780 e07e77cc c02ed880 e07e7760 f8c84fc8
       f59bfea8 dfe6c960 00000000 e07e7760 dfe6c960 00000000 f59c6e04 f59bfea8
Call Trace:    [<c0183ef5>] [<f8c84fc8>] [<f8c856f1>] [<f8c8cee4>] [<f8c8e295>]
  [<f8c923f4>] [<f8c80699>] [<f8c65938>] [<f8c923f4>] [<f8c91a38>] [<f8c91a58>]
  [<f8c80411>] [<c010592e>] [<f8c80210>]
Code: 89 50 04 c7 41 54 00 00 00 00 c7 43 04 00 00 00 00 8b 44 24


>>EIP; c0145060 <fsync_buffers_list+50/1b0>   <=====

>>ebx; c822feb4 <_end+7e84c94/3852ee40>
>>ecx; c822fe60 <_end+7e84c40/3852ee40>
>>edx; e07e7780 <_end+2043c560/3852ee40>
>>edi; e07e7780 <_end+2043c560/3852ee40>
>>ebp; f59bfe3c <_end+35614c1c/3852ee40>
>>esp; f59bfe2c <_end+35614c0c/3852ee40>

Trace; c0183ef5 <reiserfs_sync_file+65/d0>
Trace; f8c84fc8 <[nfsd]nfsd_sync+78/d0>
Trace; f8c856f1 <[nfsd]nfsd_commit+a1/b0>
Trace; f8c8cee4 <[nfsd]nfsd3_proc_commit+94/130>
Trace; f8c8e295 <[nfsd]nfs3svc_decode_commitargs+35/e0>
Trace; f8c923f4 <[nfsd]nfsd_procedures3+2f4/320>
Trace; f8c80699 <[nfsd]nfsd_dispatch+119/21d>
Trace; f8c65938 <[sunrpc]svc_process+4d8/570>
Trace; f8c923f4 <[nfsd]nfsd_procedures3+2f4/320>
Trace; f8c91a38 <[nfsd]nfsd_version3+0/10>
Trace; f8c91a58 <[nfsd]nfsd_program+0/28>
Trace; f8c80411 <[nfsd]nfsd+201/370>
Trace; c010592e <arch_kernel_thread+2e/40>
Trace; f8c80210 <[nfsd]nfsd+0/370>

Code;  c0145060 <fsync_buffers_list+50/1b0>
00000000 <_EIP>:
Code;  c0145060 <fsync_buffers_list+50/1b0>   <=====
   0:   89 50 04                  mov    %edx,0x4(%eax)   <=====
Code;  c0145063 <fsync_buffers_list+53/1b0>
   3:   c7 41 54 00 00 00 00      movl   $0x0,0x54(%ecx)
Code;  c014506a <fsync_buffers_list+5a/1b0>
   a:   c7 43 04 00 00 00 00      movl   $0x0,0x4(%ebx)
Code;  c0145071 <fsync_buffers_list+61/1b0>
  11:   8b 44 24 00               mov    0x0(%esp,1),%eax


1 warning issued.  Results may not be reliable.


As you can see reiserfs seems involved. Regarding reiserfs and my last postings
I can assure you that all reiserfs partitions were checked via reiserfsck right
before installation of rc1 - as Oleg advised - and found:
"Comparing bitmaps.. vpf-10640: The on-disk and the correct bitmaps differs"
I was told to use --fix-fixable option which I did and it indeed fixed the
problem. Trying reiserfsck after that found no errors any more. So I see no
chance that corrupt data on the media (through former crashes) is responsible
for this one. Hint: spelling in reiserfsck should be checked ;-)

Second, I re-install the box with CONFIG_DEBUG_SLAB="y" right now. Please tell
me if I should perform special steps (SYSRQ or the like) after the next crash
happens, or if the decoded oops will be sufficient.

Regards,
Stephan
