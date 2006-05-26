Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932357AbWEZMJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932357AbWEZMJz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 08:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbWEZMJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 08:09:55 -0400
Received: from sigrand.ru ([80.66.88.167]:29605 "EHLO mail.sigrand.com")
	by vger.kernel.org with ESMTP id S932357AbWEZMJy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 08:09:54 -0400
Date: Fri, 26 May 2006 18:40:28 +0700
From: art <art@sigrand.ru>
X-Mailer: The Bat! (v1.38e) S/N A1D26E39 / Educational
Reply-To: art <art@sigrand.ru>
Organization: Sigrand LLC
X-Priority: 3 (Normal)
Message-ID: <1778.060526@sigrand.ru>
To: "Maciej W. Rozycki" <macro@linux-mips.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re[2]: Problem with TLB mcheck!
In-reply-To: <Pine.LNX.4.64N.0605241304090.7887@blysk.ds.pg.gda.pl>
References: <Pine.LNX.4.64N.0605241304090.7887@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Maciej, thanks for answer! when it is at first time it is wery
important :)!

Wednesday, May 24, 2006, 7:45:26 PM, you wrote:

MWR>  The "linux-mips" mailing list (as cc-ed in this response) is a better
MWR> place to ask such questions.

MWR>  You haven't included some important information, such as the version 
MWR> number of your Linux kernel and where you got your sources from.  Without 
MWR> that bit all I can say is there is something wrong with handling of the 
MWR> TLB.

MWR>  Ralf, BTW -- shouldn't we report the Index, EntryHi and possibly EntryLo* 
MWR> registers in show_regs() if the cause is a machine check?  I think it 
MWR> would be useful and these registers shouldn't have been corrupted since 
MWR> the triggering tlbw* instruction.  A call to show_code() could be useful 
MWR> too, to determine which kind of TLB exception has been taken originally.  

MWR>   Maciej

I know about linux-mips, but I have not get answer from that for two
days! Maybe I write not complete message.
I will try Ralf Baechles diff and send the result a bit later.
Information about kernel sources (how can I forgot this!!):
   Version: linux-2.6.12-rc1-mipscvs-20050403 (this is tar-s full
   name). So I think this kernel is from linux-mips cvs repositary.
   It was downloaded from http://www.student.tue.nl/Q/t.f.a.wilms/adm5120/

Here is mcheck with respect to your patch:
   
[4294701.476000] Got mcheck at 8011c818
[4294701.476000] Hi    : 00000000
[4294701.476000] Pagemask: ffffffff
[4294701.476000] EntryHi : c008a013
[4294701.476000] EntryLo0: 0000f25f
[4294701.476000] EntryLo1: 0000ff9f
[4294701.476000]
[4294701.476000] Cpu 0
[4294701.476000] $ 0   : 00000000 10008400 00000000 802b17ac
[4294701.476000] $ 4   : 802b13ac 00000400 c008ac00 80353d6c
[4294701.476000] $ 8   : 10008400 1000001f 80393000 fffffff8
[4294701.476000] $12   : 802b0000 802b0000 00000001 ffffffff
[4294701.476000] $16   : 00000400 802b17ab 80353d6c 00000020
[4294701.476000] $20   : 80353e38 81144800 00000400 802b13ac
[4294701.476000] $24   : 00000006 0048ce30
[4294701.476000] $28   : 80352000 80353c70 7faf5d98 8011ce94
[4294701.476000] Hi    : 00000000
[4294701.476000] Lo    : 000c3500
[4294701.476000] epc   : 8011c818 vsnprintf+0x54/0x6bc     Not tainted
[4294701.476000] ra    : 8011ce94 vscnprintf+0x14/0x30
[4294701.476000] Status: 10208402    KERNEL EXL
[4294701.476000] Cause : 00800060
[4294701.476000] PrId  : 0001800b
[4294701.476000]
[4294701.476000] Index:  0 pgmask=4kb va=0050a000 asid=13
[4294701.476000]                        [pa=00000000 c=0 d=0 v=0 g=0]
[4294701.476000]                        [pa=00379000 c=3 d=1 v=1 g=0]
[4294701.476000]
[4294701.476000] Index:  1 pgmask=4kb va=7faf4000 asid=13
[4294701.476000]                        [pa=00000000 c=0 d=0 v=0 g=0]
[4294701.476000]                        [pa=0031b000 c=3 d=1 v=1 g=0]
[4294701.476000]
[4294701.476000] Index:  2 pgmask=4kb va=0048a000 asid=13
[4294701.476000]                        [pa=011bc000 c=3 d=0 v=1 g=0]
[4294701.476000]                        [pa=011bd000 c=3 d=0 v=1 g=0]
[4294701.476000]
[4294701.476000] Index:  5 pgmask=4kb va=00492000 asid=13
[4294701.476000]                        [pa=011c4000 c=3 d=0 v=1 g=0]
[4294701.476000]                        [pa=011c5000 c=3 d=0 v=1 g=0]
[4294701.476000]
[4294701.476000] Index:  6 pgmask=4kb va=004ee000 asid=13
[4294701.476000]                        [pa=0028a000 c=3 d=0 v=1 g=0]
[4294701.476000]                        [pa=011f7000 c=3 d=1 v=1 g=0]
[4294701.476000]
[4294701.476000] Index:  7 pgmask=4kb va=0048c000 asid=13
[4294701.476000]                        [pa=011be000 c=3 d=0 v=1 g=0]
[4294701.476000]                        [pa=011bf000 c=3 d=0 v=1 g=0]
[4294701.476000]
[4294701.476000] Index:  8 pgmask=4kb va=004f0000 asid=13
[4294701.476000]                        [pa=00322000 c=3 d=1 v=1 g=0]
[4294701.476000]                        [pa=00000000 c=0 d=0 v=0 g=0]
[4294701.476000]
[4294701.476000] Index:  9 pgmask=4kb va=00480000 asid=13
[4294701.476000]                        [pa=011b0000 c=3 d=0 v=1 g=0]
[4294701.476000]                        [pa=011b1000 c=3 d=0 v=1 g=0]
[4294701.476000]
[4294701.476000] Index: 10 pgmask=4kb va=00488000 asid=13
[4294701.476000]                        [pa=011b8000 c=3 d=0 v=1 g=0]
[4294701.476000]                        [pa=011b9000 c=3 d=0 v=1 g=0]
[4294701.476000]
[4294701.476000] Index: 11 pgmask=4kb va=7faf6000 asid=13
[4294701.476000]                        [pa=00357000 c=3 d=1 v=1 g=0]
[4294701.476000]                        [pa=00000000 c=0 d=0 v=0 g=0]
[4294701.476000]
[4294701.476000] Index: 12 pgmask=4kb va=00478000 asid=13
[4294701.476000]                        [pa=00000000 c=0 d=0 v=0 g=0]
[4294701.476000]                        [pa=011a9000 c=3 d=0 v=1 g=0]
[4294701.476000]
[4294701.476000] Index: 13 pgmask=4kb va=c008c000 asid=13
[4294701.476000]                        [pa=003ff000 c=3 d=1 v=1 g=1]
[4294701.476000]                        [pa=01200000 c=3 d=1 v=1 g=1]
[4294701.476000]
[4294701.476000] Index: 14 pgmask=4kb va=004aa000 asid=13
[4294701.476000]                        [pa=00286000 c=3 d=0 v=1 g=0]
[4294701.476000]                        [pa=00287000 c=3 d=0 v=1 g=0]
[4294701.476000]
[4294701.476000] Index: 15 pgmask=4kb va=00508000 asid=13
[4294701.476000]                        [pa=0031c000 c=3 d=1 v=1 g=0]
[4294701.476000]                        [pa=00000000 c=0 d=0 v=0 g=0]
[4294701.476000]
[4294701.476000]
[4294701.476000] Code: 0222102b  14400034  00000000 <80c60000> 14c00014  02e08021  0230102b  10400021  00001821
[4294701.476000] Caught Machine Check exception - caused by multiple matching entries in the TLB


-- 
Best regards,
 art                            mailto:art@sigrand.ru


