Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316597AbSEPHhn>; Thu, 16 May 2002 03:37:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316598AbSEPHhn>; Thu, 16 May 2002 03:37:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:20744 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316597AbSEPHhm>;
	Thu, 16 May 2002 03:37:42 -0400
Message-ID: <3CE362B0.CA79EB33@zip.com.au>
Date: Thu, 16 May 2002 00:41:36 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [RFC][PATCH] iowait statistics
In-Reply-To: <Pine.LNX.4.44L.0205132214480.32261-100000@imladris.surriel.com> <3CE073FA.57DAC578@zip.com.au> <200205151200.g4FC0MY13196@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> On 14 May 2002 00:18, Andrew Morton wrote:
> > Rik van Riel wrote:
> > > 4) on SMP systems the iowait time can be overestimated, no big
> > >    deal IMHO but cheap suggestions for improvement are welcome
> >
> > I suspect that a number of these statistical accounting mechanisms
> > are going to break.  The new irq-affinity code works awfully well.
> >
> > The kernel profiler in 2.5 doesn't work very well at present.
> > When investigating this, I ran a busy-wait process.  It attached
> > itself to CPU #3 and that CPU received precisely zero interrupts
> > across a five minute period.  So the profiler cunningly avoids profiling
> > busy CPUs, which is rather counter-productive.  Fortunate that oprofile
> > uses NMI.
> 
> What, even local APIC interrupts did not happen on CPU#3
> in these five mins?

CPU1 is busy:

quad:/home/akpm> cat /proc/interrupts ; sleep 10 ; cat /proc/interrupts
           CPU0       CPU1       CPU2       CPU3       
  0:      36059      33847      38948      33846    IO-APIC-edge  timer
  1:          1          1          1          4    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  4:          1          1          1          0    IO-APIC-edge  GDB-stub
  8:          0          0          0          1    IO-APIC-edge  rtc
 12:          0          1          0          0    IO-APIC-edge  PS/2 Mouse
 14:          1          2          0          3    IO-APIC-edge  ide0
 15:       7558       7557       7633       8025    IO-APIC-edge  ide1
 19:      17088      17707      17210      18610   IO-APIC-level  ide2, ide3, ide4, ide5
 35:         38         71         56        174   IO-APIC-level  aic7xxx
 38:        955       1798        584        517   IO-APIC-level  eth0
 58:      25368      19911      27931      20695   IO-APIC-level  aic7xxx
NMI:     164030     164030     164030     164030 
LOC:     142543     142543     142542     142542 
ERR:          0
MIS:          0
           CPU0       CPU1       CPU2       CPU3       
  0:      36388      33847      39289      34178    IO-APIC-edge  timer
  1:          1          1          1          4    IO-APIC-edge  keyboard
  2:          0          0          0          0          XT-PIC  cascade
  4:          1          1          1          0    IO-APIC-edge  GDB-stub
  8:          0          0          0          1    IO-APIC-edge  rtc
 12:          0          1          0          0    IO-APIC-edge  PS/2 Mouse
 14:          1          2          0          3    IO-APIC-edge  ide0
 15:       7565       7557       7633       8026    IO-APIC-edge  ide1
 19:      17088      17707      17210      18610   IO-APIC-level  ide2, ide3, ide4, ide5
 35:         38         71         56        174   IO-APIC-level  aic7xxx
 38:        969       1798        590        525   IO-APIC-level  eth0
 58:      25368      19911      27931      20695   IO-APIC-level  aic7xxx
NMI:     165032     165032     165032     165032 
LOC:     143545     143545     143544     143544 
ERR:          0
MIS:          0


-
