Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315946AbSH0NOs>; Tue, 27 Aug 2002 09:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315988AbSH0NOs>; Tue, 27 Aug 2002 09:14:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:1483 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315946AbSH0NOr>;
	Tue, 27 Aug 2002 09:14:47 -0400
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
To: jamal <hadi@cyberus.ca>
Cc: Bill Hartner <bhartner@us.ibm.com>, davem@redhat.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       Robert Olsson <Robert.Olsson@data.slu.se>
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFC842923C.BD15E014-ON87256C22.0047BBD6@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Tue, 27 Aug 2002 08:18:36 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/27/2002 07:18:34 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Jamal wrote ..
>On Mon, 26 Aug 2002, Mala Anand wrote:

>> Troy Wilson (who works with me) posted SPECweb99 results using my
>> skbinit patch to lkml on Friday:
>>  http://www.uwsg.iu.edu/hypermail/linux/kernel/0208.2/1470.html
>> I know you don't subscribe to lkml. Have you seen these results?
>> On Numa machine it showed around 3% improvement using SPECweb99.

>The posting you pointed to says 1% - not that it matters. It becomes more
>insignificant when skb recycling comes in play mostly because the alloc
>and freeing of skbs doesnt really show up as hotlist item within
>the profile.
>I am not saying it is totaly useless -- anything that will save a few
>cycles is good;

SPECweb99 profile shows that __kfree_skb is in the top 5 hot routines. We
will test the skb recycle patch on SPECweb99 and add skbinit patch
to that and see how it helps.  What I understand is that the skb recycle
patch does not attempt to recycle if the skbs are allocated on CPU
and freed on another CPU. Is that right? If so, skbinit patch will help
those
cases. I think this patch is pretty safe and I anticipate greater gains
on NUMA systems.

BTW the 3% gain that I reported earlier on NUMA is done at another site
of IBM and it turned out to be it is not a NUMA machine. It is also
an 8-way SMP machine, however those are non-complaint SPECWeb99 runs so
I won't be able to use those results.

The alloc and free routines are not hot in netperf3 profiles. However
I am seeing some gains there also, not significant. I will post netperf3
results with skbinit patch later.



Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088





