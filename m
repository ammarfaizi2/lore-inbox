Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSF1Lrw>; Fri, 28 Jun 2002 07:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317165AbSF1Lrw>; Fri, 28 Jun 2002 07:47:52 -0400
Received: from e21.nc.us.ibm.com ([32.97.136.227]:42445 "EHLO
	e21.nc.us.ibm.com") by vger.kernel.org with ESMTP
	id <S317148AbSF1Lru>; Fri, 28 Jun 2002 07:47:50 -0400
Subject: Re: efficient copy_to_user and copy_from_user routines in Linux Kernel
To: Andrew Morton <akpm@zip.com.au>
Cc: akpm@us.ibm.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lse-tech@lists.sourceforge.net, Mala Anand <manand@us.ibm.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF89BA678E.7BBDA367-ON85256BE6.00403732@raleigh.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Fri, 28 Jun 2002 06:50:00 -0500
X-MIMETrack: Serialize by Router on D04NM108/04/M/IBM(Release 5.0.9a |January 7, 2002) at
 06/28/2002 07:50:04 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Mala Anand wrote:
>>
>> Here is a 2.5.19 patch that improves the performance of IA32
copy_to_user
>> and copy_from_user routines used by :
>>
>> (1) tcpip protocol stack
>> (2) file systems
>>


>This came up about a year back when zerocopy networking was merged.
>Intel boxes started running more slowly purely because of the 8+8
>alignment thing.

>I changed tcp to use a different copy if either source or dest were
>not eight-byte aligned, and found that the resulting improvement
>across a mixed networking load was only 1%.  Your numbers are higher,
>so perhaps there are different alignments in the mix...

I will test on other workloads when I return back to work after OLS
and vacation.  However we tested an earlier version of this patch on
Netbench using sendfile and gained around 3% improvement. The baseline
profiling showed that Netbench was spending 10% in generic_copy_to_user.
The tcp options are aligned on an 4-byte boundary, so depending on the
options used the address to the data (source address to the
generic_copy_to_user) should fall on an 4 or 8 byte boundary. I agree
with you more test is needed.


>One question:  have you tested on other CPU types?  This problem is
>very specific to Intel hardware.  On AMD, the eight-byte alignement
>artifact does not exist at all.  It could be that your patch is not
>desirable on such CPUs?

I tested only Pentium II and III. I will test it on Pentium IV.
When I said 8-byte alignment, it is 8 and greater.  I will
try to check out AMD also.



Regards,
    Mala


   Mala Anand
   E-mail:manand@us.ibm.com
   Linux Technology Center - Performance
   Phone:838-8088; Tie-line:678-8088




                                                                                                                                       
                      Andrew Morton                                                                                                    
                      <akpm@zip.com.au>        To:       Mala Anand/Austin/IBM@IBMUS                                                   
                      Sent by:                 cc:       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,                     
                      akpm@us.ibm.com           lse-tech@lists.sourceforge.net                                                         
                                               Subject:  Re: efficient copy_to_user and copy_from_user routines in Linux Kernel        
                                                                                                                                       
                      06/25/2002 12:03                                                                                                 
                      PM                                                                                                               
                                                                                                                                       
                                                                                                                                       




-



