Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261439AbSKBV43>; Sat, 2 Nov 2002 16:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261440AbSKBV43>; Sat, 2 Nov 2002 16:56:29 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:26607 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S261439AbSKBV42>; Sat, 2 Nov 2002 16:56:28 -0500
Subject: Re: [PATCHSET] Mobile IPv6 for 2.5.45
To: Pekka Savola <pekkas@netcore.fi>
Cc: ajtuomin@tml.hut.fi, davem@redhat.com, kkumar@beaverton.ibm.com,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, lpetande@tml.hut.fi,
       netdev@oss.sgi.com, "Venkata Jagana" <jagana@us.ibm.com>,
       YOSHIFUJI Hideaki / =?iso-2022-jp?B?GyRCNUhGIzFRTEAbKEI=?= 
	<yoshfuji@linux-ipv6.org>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OFB7772DA2.01708E94-ON87256C65.006EDAE7@boulder.ibm.com>
From: "Krishna Kumar" <kumarkr@us.ibm.com>
Date: Sat, 2 Nov 2002 13:13:22 -0800
X-MIMETrack: Serialize by Router on D03NM801/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 11/02/2002 03:02:35 PM
MIME-Version: 1.0
Content-type: text/plain; charset=iso-2022-jp
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I agree with Pekka, hence the response to Jeff's and Yoshifuji's mail is
the same - what you are suggestting is feasible but we need more work in
the kernel either way. We can do many/most of these things in userspace
provided we either duplicate a lot of the code from kernel to user space
(leading to maintainability issues), or  modularize exisiting kernel
routines (eg a different interface to DAD) and provide hooks for the same
to user (portability?). To clean up and provide more hooks in the kernel to
support common user activities means a major over write, but I agree it is
a good idea in the long run.

Another concern to think about is whether an integral part of the HA
functionality should be kept separate in user space, and whether making the
break in the HA to have a user process and kernel component makes sense.
Also other things to worry about when integral components are kept in
userspace -  what happens when signals (KILL) are sent to that process ? We
don't want the home agent functionality to stop in that case, even if it is
a system admin error. This part is very critical to supporting possibly
hundreds of mobile devices in the future.

Thanks,

- KK



                                                                                                                       
                      Pekka Savola                                                                                     
                      <pekkas@netcore.f        To:       YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>        
                      i>                       cc:       Krishna Kumar/Beaverton/IBM@IBMUS, <davem@redhat.com>,        
                                                <ajtuomin@tml.hut.fi>, <kkumar@beaverton.ibm.com.sgi.com>,             
                      11/02/2002 12:36          <kuznet@ms2.inr.ac.ru>, <linux-kernel@vger.kernel.org>,                
                      AM                        <lpetande@tml.hut.fi>, <netdev@oss.sgi.com>, Venkata                   
                                                Jagana/Beaverton/IBM@IBMUS                                             
                                               Subject:  Re: [PATCHSET] Mobile IPv6 for 2.5.45                         
                                                                                                                       
                                                                                                                       
                                                                                                                       



I believe there could be more hooks in the kernel to let userspace do
certain tasks, for example, sending router solicitations and processing
the responses -- sure, this can be done in the userspace but means code
duplication.  If the code in the kernel could also be called from the
userspace, there might be less need for duplication (though this would
result in portability issues of course).

Similar would appear to be the case some other features listed here.

On Sat, 2 Nov 2002, YOSHIFUJI Hideaki / [iso-2022-jp] !
!


