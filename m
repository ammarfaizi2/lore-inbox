Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282834AbRK0Ksi>; Tue, 27 Nov 2001 05:48:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282904AbRK0Ks2>; Tue, 27 Nov 2001 05:48:28 -0500
Received: from dmb001.rug.ac.be ([157.193.78.1]:38326 "HELO dmb.rug.ac.be")
	by vger.kernel.org with SMTP id <S282834AbRK0KsO>;
	Tue, 27 Nov 2001 05:48:14 -0500
Message-ID: <3C036F83.2000903@dmb.rug.ac.be>
Date: Tue, 27 Nov 2001 11:48:35 +0100
From: Didier Moens <Didier.Moens@dmb001.rug.ac.be>
Organization: RUG/VIB - Dept. Molecular Biology
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nicolas Aspert <Nicolas.Aspert@epfl.ch>
Cc: Abraham vd Merwe <abraham@2d3d.co.za>,
        Linux Kernel Development <linux-kernel@vger.kernel.org>,
        skraw@ithnet.com
Subject: Re: [Fwd: Re: OOPS in agpgart (2.4.13, 2.4.15pre7)]
In-Reply-To: <linux.kernel.3C021570.4000603@dmb.rug.ac.be> <3C022BB4.7080707@epfl.ch> <1006808870.817.0.camel@phantasy> <3C02BF41.1010303@xs4all.be> <20011127101148.C5778@crystal.2d3d.co.za> <3C034CAE.2090103@dmb.rug.ac.be> <20011127111022.B881@crystal.2d3d.co.za> <3C036245.6080105@dmb.rug.ac.be> <3C036553.3040505@epfl.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nicolas Aspert wrote:

> 
>>
>>
>> To sum up : this is an IBM A30p, with an "external" Radeon Mobility LY 
>> (32 MB), and an 830MP instead of an 830M. The 830MP is common for both 
>> IBM A30 and A30p models.
>>
>>
> 
> OK ! so you _do_ have an external graphic card (that's what looked 
> unclear to me),
> for which AGP should work in the same way it does for other Intel 
> chipsets...
> 
> So why not trying the little patch I attach below, which should make 
> your stuff work, without breaking too much the i830 support for on-board 
> adapters... The patch is for 2.4.16, but is likely to be applied easily 
> on another recent kernel. Keep me informed...


1. modprobe agpgart loads OK :

Nov 27 11:34:47 localhost kernel: Linux agpgart interface v0.99 (c) Jeff 
Hartmann
Nov 27 11:34:47 localhost kernel: agpgart: Maximum main memory to use 
for agp memory: 439M
Nov 27 11:34:47 localhost kernel: agpgart: Detected an Intel 830M, but 
could not find the secondary device.
Nov 27 11:34:47 localhost kernel: agpgart: Trying the Intel 830MP stuff
Nov 27 11:34:47 localhost kernel: agpgart: Detected Intel i830M chipset
Nov 27 11:34:47 localhost kernel: agpgart: AGP aperture is 256M @ 0xd0000000


[root@localhost agp]# /home/didier/repository/kernel/testgart
version: 0.99
bridge id: 0x35758086
agp_mode: 0x1f000217
aper_base: 0xd0000000
aper_size: 256
pg_total: 112384
pg_system: 112384
pg_used: 0
entry.key : 0
entry.key : 1
Allocated 8 megs of GART memory
MemoryBenchmark: 858 mb/s
MemoryBenchmark: 876 mb/s
MemoryBenchmark: 890 mb/s
Average speed: 874 mb/s
Testing data integrity (1st pass): passed on first pass.
Testing data integrity (2nd pass): passed on second pass.




2. compared to Stephan's original patches ("if i830m_dev ..." and 
"break;") :

Nov 27 11:37:07 localhost kernel: Linux agpgart interface v0.99 (c) Jeff 
Hartmann
Nov 27 11:37:07 localhost kernel: agpgart: Maximum main memory to use 
for agp memory: 439M
Nov 27 11:37:07 localhost kernel: agpgart: Detected Intel i830M chipset
Nov 27 11:37:07 localhost kernel: agpgart: AGP aperture is 256M @ 0xd0000000

[root@localhost agp]# /home/didier/repository/kernel/testgart
version: 0.99
bridge id: 0x35758086
agp_mode: 0x1f000217
aper_base: 0xd0000000
aper_size: 256
pg_total: 112384
pg_system: 112384
pg_used: 0
entry.key : 0
entry.key : 1
Allocated 8 megs of GART memory
MemoryBenchmark: 859 mb/s
MemoryBenchmark: 887 mb/s
MemoryBenchmark: 876 mb/s
Average speed: 874 mb/s
Testing data integrity (1st pass): passed on first pass.
Testing data integrity (2nd pass): passed on second pass.



Is the 8 megs of GART OK ?
Is the memory benchmark comparable to equally equipped machines (1.2G 
P-III(M), i830(MP), ATI Radeon(M)) ? (I'm trying to differentiate my 
performance problem between agpgart and X DRI/DRM).



Kind regards,

Didier

