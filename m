Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313544AbSDPDLh>; Mon, 15 Apr 2002 23:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313545AbSDPDLg>; Mon, 15 Apr 2002 23:11:36 -0400
Received: from smtp.comcast.net ([24.153.64.2]:20135 "EHLO smtp.comcast.net")
	by vger.kernel.org with ESMTP id <S313544AbSDPDLf>;
	Mon, 15 Apr 2002 23:11:35 -0400
Date: Mon, 15 Apr 2002 22:11:27 -0500
From: Josh McKinney <forming@comcast.net>
Subject: Re: [PATCH]
In-Reply-To: <Pine.LNX.4.10.10204151258400.1699-100000@master.linux-ide.org>
To: linux-kernel@vger.kernel.org
Mail-followup-to: linux-kernel@vger.kernel.org
Message-id: <20020416031127.GA1030@cy599856-a>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-disposition: inline
User-Agent: Mutt/1.3.28i
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.4.19-pre6 i686
X-Processor: Athlon XP 2000+
X-Uptime: 22:07:37 up 11 min,  2 users,  load average: 1.05, 0.83, 0.40
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Mon, Apr 15, 2002 at 12:59:20PM -0700, Andre Hedrick wrote:
> 
> http://www.linuxdiskcert.org/ide-2.4.19-p6.all.convert.3a.patch.bz2
> 
> Lets try it again, I diffed the wrong tree :-/
> 

Well it compiled fine this time, but it seems to have problems with gcc-3.0.4 I am using to
compile kernels.  This gcc has been fine for all other uses, but it must be something with this
particular build because gcc-2.95.4 works without a problem.  Anyways, here is the oops report
if it may interest you.

<1>Unable to handle kernel paging request at virtual address 3fff432a
c01c2c90
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<c01c2c90>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010202
eax: 3fff427a   ebx: c02fc928   ecx: 00000001   edx: dda11e04
esi: c02fc928   edi: dda11e98   ebp: bffff7f0   esp: dda11e04
ds: 0018   es: 0018   ss: 0018
Process hdparm (pid: 492, stackpage=dda11000)
Stack: 3fff427a 00100000 0258e100 0010003f 000e0000 2d575744 39504d41 30353136
       31003238 00000000 10000003 30320028 35422e30 57443032 57444320 30423630
       3332422d 41304358 20202020 20202020 20202020 20202020 20202020 80102020
Code: 0f b7 80 b0 00 00 00 8b 93 f0 00 00 00 66 89 82 b0 00 00 00


>>EIP; c01c2c90 <ide_driveid_update+30/90>   <=====

>>eax; 3fff427a Before first symbol
>>ebx; c02fc928 <ide_hwifs+388/20a8>
>>edx; dda11e04 <_end+1d70bb50/2253ad4c>
>>esi; c02fc928 <ide_hwifs+388/20a8>
>>edi; dda11e98 <_end+1d70bbe4/2253ad4c>
>>ebp; bffff7f0 Before first symbol
>>esp; dda11e04 <_end+1d70bb50/2253ad4c>

Code;  c01c2c90 <ide_driveid_update+30/90>
00000000 <_EIP>:
Code;  c01c2c90 <ide_driveid_update+30/90>   <=====
   0:   0f b7 80 b0 00 00 00      movzwl 0xb0(%eax),%eax   <=====
Code;  c01c2c97 <ide_driveid_update+37/90>
   7:   8b 93 f0 00 00 00         mov    0xf0(%ebx),%edx
Code;  c01c2c9d <ide_driveid_update+3d/90>
   d:   66 89 82 b0 00 00 00      mov    %ax,0xb0(%edx)

