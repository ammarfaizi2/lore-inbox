Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263230AbTCNDcM>; Thu, 13 Mar 2003 22:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263232AbTCNDcM>; Thu, 13 Mar 2003 22:32:12 -0500
Received: from NODE-1.HOSTING-NETWORK.COM ([66.186.193.1]:7433 "HELO
	unix113.hosting-network.com") by vger.kernel.org with SMTP
	id <S263230AbTCNDcK>; Thu, 13 Mar 2003 22:32:10 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 63.109.146.2
X-Authenticated-Timestamp: 22:53:46(EST) on March 13, 2003
X-HELO-From: rohan.arnor.net
X-Mail-From: <thoffman@arnor.net>
X-Sender-IP-Address: 63.109.146.2
Subject: Re: Oops in firewire (2.4.21-pre5 with 2.4.21-pre4 firewire driver)
From: Torrey Hoffman <thoffman@arnor.net>
To: Ben Collins <bcollins@debian.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030313061144.GV563@phunnypharm.org>
References: <1047517628.1172.8.camel@rohan.arnor.net> 
	<20030313061144.GV563@phunnypharm.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Mar 2003 19:42:56 -0800
Message-Id: <1047613378.1180.9.camel@rohan.arnor.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-03-12 at 22:11, Ben Collins wrote:
[about firewire problems]
> I'd suggest with trying the latest BK cset patch (which fixes -pre5 and
> also fixes some things in general).

Although I said things were working, it turns out firewire is not bug
free quite yet.

Here's another oops to look at.

The kernel was a bitkeeper snapshot from last night (March 12), no other
patches or modifications, and the hardware is a single CPU Pentium III,
a Maxtor-brand firewire controller, with an ATA-6 supporting 
IDE-to-Firewire bridge hooked up to it.  

This occurred when rc.sysinit loaded ohci1394.  sbp2 is automatically
loaded by the hotplug driver, so that may have actually been the source
of the problem.  

The system continued to boot after the oops (and in fact it's running
now as I write this...)

ksymoops 2.4.5 on i686 2.4.21-bk-0312.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.21-bk-0312/ (default)
     -m /boot/System.map-2.4.21-bk-0312 (default)

Warning: You did not tell me where to find symbol information.  I will
assume that the log matches the kernel and modules that are running
right now and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can get
more accurate output by telling me the kernel version and where to find
map, modules, ksyms etc.  ksymoops -h explains the options.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
d3848227
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d3848227>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010246
eax: 00000000   ebx: 00000000   ecx: 00000001   edx: d24b2000
esi: d24b2000   edi: 00000002   ebp: 00000002   esp: ce0c9fa8
ds: 0018   es: 0018   ss: 0018
Process knodemgrd (pid: 211, stackpage=ce0c9000)
Stack: 00000001 00000000 d24b20f4 0000ffc2 d38482d7 d24b2000 00000002 00000002 
       c1361da0 c1361db8 d384f1f8 d24b2000 d384836a d24b2000 00000018 00000f00 
       d2461e50 d24b2000 c010744e c1361da0 d3848300 c1361da4 
Call Trace:    [<d38482d7>] [<d384f1f8>] [<d384836a>] [<c010744e>] [<d3848300>]
Code: 8b 1b 3d 08 f2 84 d3 75 f0 58 5b 5e 5f c3 39 78 20 74 eb 89 


>>EIP; d3848227 <[ieee1394]nodemgr_node_probe_cleanup+27/50>   <=====

>>edx; d24b2000 <_end+1218d108/134fe168>
>>esi; d24b2000 <_end+1218d108/134fe168>
>>esp; ce0c9fa8 <_end+dda50b0/134fe168>

Trace; d38482d7 <[ieee1394]nodemgr_node_probe+87/b0>
Trace; d384f1f8 <[ieee1394]nodemgr_serialize+0/10>
Trace; d384836a <[ieee1394]nodemgr_host_thread+6a/b0>
Trace; c010744e <kernel_thread+2e/40>
Trace; d3848300 <[ieee1394]nodemgr_host_thread+0/b0>

Code;  d3848227 <[ieee1394]nodemgr_node_probe_cleanup+27/50>
00000000 <_EIP>:
Code;  d3848227 <[ieee1394]nodemgr_node_probe_cleanup+27/50>   <=====
   0:   8b 1b                     mov    (%ebx),%ebx   <=====
Code;  d3848229 <[ieee1394]nodemgr_node_probe_cleanup+29/50>
   2:   3d 08 f2 84 d3            cmp    $0xd384f208,%eax
Code;  d384822e <[ieee1394]nodemgr_node_probe_cleanup+2e/50>
   7:   75 f0                     jne    fffffff9 <_EIP+0xfffffff9>
Code;  d3848230 <[ieee1394]nodemgr_node_probe_cleanup+30/50>
   9:   58                        pop    %eax
Code;  d3848231 <[ieee1394]nodemgr_node_probe_cleanup+31/50>
   a:   5b                        pop    %ebx
Code;  d3848232 <[ieee1394]nodemgr_node_probe_cleanup+32/50>
   b:   5e                        pop    %esi
Code;  d3848233 <[ieee1394]nodemgr_node_probe_cleanup+33/50>
   c:   5f                        pop    %edi
Code;  d3848234 <[ieee1394]nodemgr_node_probe_cleanup+34/50>
   d:   c3                        ret    
Code;  d3848235 <[ieee1394]nodemgr_node_probe_cleanup+35/50>
   e:   39 78 20                  cmp    %edi,0x20(%eax)
Code;  d3848238 <[ieee1394]nodemgr_node_probe_cleanup+38/50>
  11:   74 eb                     je     fffffffe <_EIP+0xfffffffe>
Code;  d384823a <[ieee1394]nodemgr_node_probe_cleanup+3a/50>
  13:   89 00                     mov    %eax,(%eax)


1 warning issued.  Results may not be reliable.









