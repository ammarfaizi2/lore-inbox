Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264631AbTAEKfW>; Sun, 5 Jan 2003 05:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264644AbTAEKfW>; Sun, 5 Jan 2003 05:35:22 -0500
Received: from tag.witbe.net ([81.88.96.48]:17927 "EHLO tag.witbe.net")
	by vger.kernel.org with ESMTP id <S264631AbTAEKfU>;
	Sun, 5 Jan 2003 05:35:20 -0500
From: "Paul Rolland" <rol@as2917.net>
To: "'Paul Rolland'" <rol@as2917.net>,
       "'Steven Barnhart'" <sbarn03@softhome.net>,
       "'Mark Hahn'" <hahn@physics.mcmaster.ca>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [2.5.54 - Oops] CPUFreq [Was: Re: [2.5.54] OOPS: unable to handle kernel paging request]
Date: Sun, 5 Jan 2003 11:43:50 +0100
Message-ID: <012601c2b4a7$55ce8090$2101a8c0@witbe>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <012501c2b49c$75000a70$2101a8c0@witbe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Good news !
Using the patch : 
http://www.brodo.de/cpufreq/cpufreq-2.5.54-p4-1
it is now booting fine !

1 [11:40] rol@donald:~> cat /proc/cpufreq 
          minimum CPU frequency  -  maximum CPU frequency  -  policy
CPU  0       302902 kHz ( 12 %)  -    2423222 kHz (100 %)  -
performance

Cool...

Paul Rolland, rol@as2917.net

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Paul Rolland
> Sent: Sunday, January 05, 2003 10:26 AM
> To: 'Steven Barnhart'; 'Mark Hahn'
> Cc: linux-kernel@vger.kernel.org
> Subject: [2.5.54 - Oops] CPUFreq [Was: Re: [2.5.54] OOPS: 
> unable to handle kernel paging request]
> 
> 
> Hello,
> 
> I've got it running my serial console. Full trace at boot time is :
> SBF: Simple Boot Flag extension found and enabled.
> SBF: Setting boot flags 0x1
> cpufreq: P4/Xeon(TM) CPU On-Demand Clock Modulation available 
> divide error: 0000
> CPU:    0
> EIP:    0060:[<c01151bb>]    Not tainted
> EFLAGS: 00010246
> Unable to handle kernel paging request at virtual address 
> ffffff8d  printing eip: c012ebcf *pde = 00001067 *pte = 00000000
> Oops: 0002
> CPU:    0
> EIP:    0060:[<c012ebcf>]    Not tainted
> EFLAGS: 00010006
> 
> and ksymoops says :
> 8 [10:21] rol@donald:~> ksymoops -v /usr/src/linux/vmlinux -K 
> -m /boot/System.map-2.5.54 <oops-cpufreq2 ksymoops 2.4.8 on 
> i686 2.4.20.  Options used
>      -v /usr/src/linux/vmlinux (specified)
>      -K (specified)
>      -l /proc/modules (default)
>      -o /lib/modules/2.4.20/ (default)
>      -m /boot/System.map-2.5.54 (specified)
> 
> No modules in ksyms, skipping objects
> No ksyms, skipping lsmod
> CPU:    0
> EIP:    0060:[<c01151bb>]    Not tainted
> Using defaults from ksymoops -t elf32-i386 -a i386
> EFLAGS: 00010246
> Unable to handle kernel paging request at virtual address 
> ffffff8d c012ebcf *pde = 00001067
> Oops: 0002
> CPU:    0
> EIP:    0060:[<c012ebcf>]    Not tainted
> EFLAGS: 00010006
> Warning (Oops_read): Code line not seen, dumping what data is 
> available
> 
> 
> >>EIP; c01151bb <time_cpufreq_notifier+14f/208>   <=====
> >>EIP; c012ebcf <kallsyms_lookup+df/194>   <=====
> 
> 
> 1 warning issued.  Results may not be reliable.
> 
> Problem is that ksymoops seems to decode the paging request 
> fault, not the 0 divide error...
> 
> This comes from a plain 2.5.54 kernel, no patches applied.
> 
> Dominik, you told me last week, with 2.5.53, that a patch was 
> to be used. 
> Is it included in 2.5.54 ?
> If not, forget this mail... just tell me, I'll apply the 
> patch and I'll tell you if it's better.
> 
> Regards,
> Paul
> 
> 
> > -----Original Message-----
> > From: linux-kernel-owner@vger.kernel.org
> > [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> > Steven Barnhart
> > Sent: Friday, January 03, 2003 10:06 PM
> > To: Mark Hahn
> > Cc: linux-kernel@vger.kernel.org
> > Subject: Re: [2.5.54] OOPS: unable to handle kernel paging request
> > 
> > 
> > On Fri, 2003-01-03 at 10:48, Mark Hahn wrote:
> > > it's not very meaningful: some part of the kernel tried
> > dereferencing
> > > a null pointer (as it happens, with a negative offset, such as you
> > > might expect from a variable sitting in the stack). the 
> > negativeness
> > > is not surprising, and the value of the offset would 
> depend on your
> > > cpu/compiler/config.
> > 
> > Well I have a Intel Celeron 1.06 GHz (i686). 384MB ram, gcc
> > 3.2 (redhat 8 release). I don't really know how to decode it 
> > since I have no serial console hookups...anything paticualr I 
> > could get from the oops report during bootup? i.e. what 
> > sections to copy?
> > 
> > --
> > Steven
> > sbarn03@softhome.net
> > GnuPG Fingerprint: 9357 F403 B0A1 E18D 86D5  2230 BB92 6D64 
> D516 0A94
> > 
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to 
> > majordomo@vger.kernel.org More majordomo info at  
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in the body of a message to 
> majordomo@vger.kernel.org More majordomo info at  
http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

