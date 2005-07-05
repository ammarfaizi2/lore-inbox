Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261766AbVGEBdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261766AbVGEBdX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Jul 2005 21:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261770AbVGEBbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Jul 2005 21:31:55 -0400
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.59]:25988 "EHLO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S261742AbVGEBaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Jul 2005 21:30:20 -0400
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Matthew Wilcox <matthew@wil.cx>
Date: Tue, 5 Jul 2005 11:29:43 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17097.57991.652937.849090@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: REGRESSION in 2.6.13-rc1: Massive slowdown with Adaptec SCSI
In-Reply-To: message from Matthew Wilcox on Tuesday July 5
References: <17097.56705.490622.759154@cse.unsw.edu.au>
	<20050705012141.GB9312@parcelfarce.linux.theplanet.co.uk>
X-Mailer: VM 7.19 under Emacs 21.4.1
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday July 5, matthew@wil.cx wrote:
> On Tue, Jul 05, 2005 at 11:08:17AM +1000, Neil Brown wrote:
> >  On 2.6.13-rc1 the same test takes just short on 1 minute and reports
> >  slightly less than 2 M/Second.
> 
> That sounds like your drives have negotiated an asynchronous transfer
> agreement.  Could you provide your dmesg to confirm that diagnosis?

Yes, that looks right.
The first SCSI device found is some sort of backplane that only talks
async. and we are told that it refuses to negotiate sync.
Remaining devices don't refuse, but end up 'wide asynchronous' anyway.

Below is the relevant section from the log when running 2.6.13-rc1,
followed by the matching section for 2.6.12.

Thanks,
NeilBrown


kernel.log when running 2.6.13-rc1
Jul  5 11:06:56 cage kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Jul  5 11:06:56 cage kernel:         <Adaptec 3960D Ultra160 SCSI adapter>
Jul  5 11:06:56 cage kernel:         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Jul  5 11:06:56 cage kernel: 
Jul  5 11:06:56 cage kernel:   Vendor: DELL      Model: PV22XS            Rev: E.17
Jul  5 11:06:56 cage kernel:   Type:   Processor                          ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target0:0:6: asynchronous.
Jul  5 11:06:56 cage kernel:  target0:0:6: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target0:0:6: Domain Validation skipping write tests
Jul  5 11:06:56 cage kernel: (scsi0:A:6:0): refuses synchronous negotiation. Using asynchronous transfers
Jul  5 11:06:56 cage kernel:  target0:0:6: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target0:0:9: asynchronous.
Jul  5 11:06:56 cage kernel: scsi0:A:9:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target0:0:9: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target0:0:9: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target0:0:9: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target0:0:10: asynchronous.
Jul  5 11:06:56 cage kernel: scsi0:A:10:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target0:0:10: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target0:0:10: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target0:0:10: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target0:0:11: asynchronous.
Jul  5 11:06:56 cage kernel: scsi0:A:11:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target0:0:11: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target0:0:11: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target0:0:11: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target0:0:12: asynchronous.
Jul  5 11:06:56 cage kernel: scsi0:A:12:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target0:0:12: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target0:0:12: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target0:0:12: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target0:0:13: asynchronous.
Jul  5 11:06:56 cage kernel: scsi0:A:13:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target0:0:13: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target0:0:13: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target0:0:13: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target0:0:14: asynchronous.
Jul  5 11:06:56 cage kernel: scsi0:A:14:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target0:0:14: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target0:0:14: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target0:0:14: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target0:0:15: asynchronous.
Jul  5 11:06:56 cage kernel: scsi0:A:15:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target0:0:15: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target0:0:15: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target0:0:15: Ending Domain Validation
Jul  5 11:06:56 cage kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Jul  5 11:06:56 cage kernel:         <Adaptec 3960D Ultra160 SCSI adapter>
Jul  5 11:06:56 cage kernel:         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
Jul  5 11:06:56 cage kernel: 
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target1:0:0: asynchronous.
Jul  5 11:06:56 cage kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target1:0:0: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target1:0:0: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target1:0:0: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target1:0:1: asynchronous.
Jul  5 11:06:56 cage kernel: scsi1:A:1:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target1:0:1: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target1:0:1: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target1:0:1: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target1:0:2: asynchronous.
Jul  5 11:06:56 cage kernel: scsi1:A:2:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target1:0:2: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target1:0:2: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target1:0:2: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target1:0:3: asynchronous.
Jul  5 11:06:56 cage kernel: scsi1:A:3:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target1:0:3: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target1:0:3: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target1:0:3: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target1:0:4: asynchronous.
Jul  5 11:06:56 cage kernel: scsi1:A:4:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target1:0:4: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target1:0:4: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target1:0:4: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target1:0:5: asynchronous.
Jul  5 11:06:56 cage kernel: scsi1:A:5:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target1:0:5: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target1:0:5: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target1:0:5: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: DELL      Model: PV22XS            Rev: E.17
Jul  5 11:06:56 cage kernel:   Type:   Processor                          ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target1:0:6: asynchronous.
Jul  5 11:06:56 cage kernel:  target1:0:6: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target1:0:6: Domain Validation skipping write tests
Jul  5 11:06:56 cage kernel: (scsi1:A:6:0): refuses synchronous negotiation. Using asynchronous transfers
Jul  5 11:06:56 cage kernel:  target1:0:6: Ending Domain Validation
Jul  5 11:06:56 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 11:06:56 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 11:06:56 cage kernel:  target1:0:8: asynchronous.
Jul  5 11:06:56 cage kernel: scsi1:A:8:0: Tagged Queuing enabled.  Depth 253
Jul  5 11:06:56 cage kernel:  target1:0:8: Beginning Domain Validation
Jul  5 11:06:56 cage kernel:  target1:0:8: wide asynchronous.
Jul  5 11:06:56 cage kernel:  target1:0:8: Ending Domain Validation



kernel.log when running 2.6.12
Jul  5 10:36:18 cage kernel: scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Jul  5 10:36:18 cage kernel:         <Adaptec 3960D Ultra160 SCSI adapter>
Jul  5 10:36:18 cage kernel:         aic7899: Ultra160 Wide Channel A, SCSI Id=7, 32/253 SCBs
Jul  5 10:36:18 cage kernel: 
Jul  5 10:36:18 cage kernel:   Vendor: DELL      Model: PV22XS            Rev: E.17
Jul  5 10:36:18 cage kernel:   Type:   Processor                          ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel:  target0:0:6: Beginning Domain Validation
Jul  5 10:36:18 cage kernel:  target0:0:6: Domain Validation skipping write tests
Jul  5 10:36:18 cage kernel: (scsi0:A:6:0): refuses synchronous negotiation. Using asynchronous transfers
Jul  5 10:36:18 cage kernel:  target0:0:6: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi0:A:9:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target0:0:9: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi0:A:9): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi0:A:9): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target0:0:9: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi0:A:10:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target0:0:10: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi0:A:10): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi0:A:10): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target0:0:10: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi0:A:11:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target0:0:11: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi0:A:11): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi0:A:11): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target0:0:11: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi0:A:12:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target0:0:12: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi0:A:12): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi0:A:12): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target0:0:12: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi0:A:13:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target0:0:13: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi0:A:13): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi0:A:13): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target0:0:13: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi0:A:14:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target0:0:14: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi0:A:14): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi0:A:14): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target0:0:14: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi0:A:15:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target0:0:15: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi0:A:15): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi0:A:15): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target0:0:15: Ending Domain Validation
Jul  5 10:36:18 cage kernel: scsi1 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 6.2.36
Jul  5 10:36:18 cage kernel:         <Adaptec 3960D Ultra160 SCSI adapter>
Jul  5 10:36:18 cage kernel:         aic7899: Ultra160 Wide Channel B, SCSI Id=7, 32/253 SCBs
Jul  5 10:36:18 cage kernel: 
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi1:A:0:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target1:0:0: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi1:A:0): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi1:A:0): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target1:0:0: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi1:A:1:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target1:0:1: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi1:A:1): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi1:A:1): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target1:0:1: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi1:A:2:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target1:0:2: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi1:A:2): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi1:A:2): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target1:0:2: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi1:A:3:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target1:0:3: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi1:A:3): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi1:A:3): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target1:0:3: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi1:A:4:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target1:0:4: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi1:A:4): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi1:A:4): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target1:0:4: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi1:A:5:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target1:0:5: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi1:A:5): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi1:A:5): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target1:0:5: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: DELL      Model: PV22XS            Rev: E.17
Jul  5 10:36:18 cage kernel:   Type:   Processor                          ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel:  target1:0:6: Beginning Domain Validation
Jul  5 10:36:18 cage kernel:  target1:0:6: Domain Validation skipping write tests
Jul  5 10:36:18 cage kernel: (scsi1:A:6:0): refuses synchronous negotiation. Using asynchronous transfers
Jul  5 10:36:18 cage kernel:  target1:0:6: Ending Domain Validation
Jul  5 10:36:18 cage kernel:   Vendor: MAXTOR    Model: ATLAS15K_36SCA    Rev: DTA0
Jul  5 10:36:18 cage kernel:   Type:   Direct-Access                      ANSI SCSI revision: 03
Jul  5 10:36:18 cage kernel: scsi1:A:8:0: Tagged Queuing enabled.  Depth 253
Jul  5 10:36:18 cage kernel:  target1:0:8: Beginning Domain Validation
Jul  5 10:36:18 cage kernel: WIDTH IS 1
Jul  5 10:36:18 cage kernel: (scsi1:A:8): 6.600MB/s transfers (16bit)
Jul  5 10:36:18 cage kernel: (scsi1:A:8): 160.000MB/s transfers (80.000MHz DT, offset 127, 16bit)
Jul  5 10:36:18 cage kernel:  target1:0:8: Ending Domain Validation
