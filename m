Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272493AbRIKPzO>; Tue, 11 Sep 2001 11:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272507AbRIKPzF>; Tue, 11 Sep 2001 11:55:05 -0400
Received: from d06lmsgate-3.uk.ibm.com ([195.212.29.3]:34945 "EHLO
	d06lmsgate-3.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S272493AbRIKPyt>; Tue, 11 Sep 2001 11:54:49 -0400
Subject: Re: Kernel stack....
To: Emmanuel Varagnat-AEV010 <Emmanuel_Varagnat-AEV010@email.mot.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
X-Mailer: Lotus Notes Release 5.0.5  September 22, 2000
Message-ID: <OF320808EF.12D7A841-ON80256AC4.005690AE@portsmouth.uk.ibm.com>
From: "Richard J Moore" <richardj_moore@uk.ibm.com>
Date: Tue, 11 Sep 2001 16:53:49 +0100
X-MIMETrack: Serialize by Router on D06ML023/06/M/IBM(Release 5.0.8 |June 18, 2001) at
 11/09/2001 16:54:51
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If you have an interrupt stack, and that's not strictly necessary in OS
design, then you either need one per processor or to handle interrupts on
only one processor. If you use the task time kernel stack, which under IA32
you will do as soon as the CPU processes the interrupt gate for that IRQ,
then the interrupt stack frame wil appear on the task time stack. Things in
theory can continue this was. Eventually the stack will unwind with the
interrupt frame being finally removed with an IRET. No it is possible to
switch to a separate stack but that has to be engineered by the system
interrupt handler. I don't recall whether Linux does this. If it does
you'll see it happening in the /arch code for interrupt handling.

Richard Moore -  RAS Project Lead - Linux Technology Centre (ATS-PIC).
http://oss.software.ibm.com/developerworks/opensource/linux
Office: (+44) (0)1962-817072, Mobile: (+44) (0)7768-298183
IBM UK Ltd,  MP135 Galileo Centre, Hursley Park, Winchester, SO21 2JN, UK


                                                                                                                                   
                    Emmanuel Varagnat                                                                                              
                    <Emmanuel_Varagnat-AEV010@emai       To:     Richard J Moore/UK/IBM@IBMGB                                      
                    l.mot.com>                           cc:                                                                       
                                                         Subject:     Re: Kernel stack....                                         
                    11/09/2001 16:26                                                                                               
                    Please respond to Emmanuel                                                                                     
                    Varagnat-AEV010                                                                                                
                                                                                                                                   
                                                                                                                                   




Richard J Moore wrote:
>
> Emmanuel Varagnat wrote:
>
> >Yes but there is one stack per processor ?
>
> One per process.

Yes I know, but inside the kernel when an IRQ is handled
the kernel use its own stack. But if there is many processors
many IRQ handler are supposed "turn". And if they share the
same stack, data are melted.

Thanks for your answer.

-Manu




