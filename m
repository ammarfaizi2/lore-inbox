Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSHWXgB>; Fri, 23 Aug 2002 19:36:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314149AbSHWXgB>; Fri, 23 Aug 2002 19:36:01 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:26582 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S313867AbSHWXgA>; Fri, 23 Aug 2002 19:36:00 -0400
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, bcrl@redhat.com,
       "Bill Hartner" <bhartner@us.ibm.com>, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       lse-tech-admin@lists.sourceforge.net
X-Mailer: Lotus Notes Release 5.0.7  March 21, 2001
Message-ID: <OFF2DE6049.2BE570E3-ON87256C1E.0080C56A@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Fri, 23 Aug 2002 18:38:59 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 08/23/2002 05:39:00 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Dave Hansen <haveblue@us.ibm.com>
   Date: Fri, 23 Aug 2002 09:39:13 -0700

   Where are interrupts disabled?   I just went through a set of kernprof
   data and traced up the call graph.  In the most common __kfree_skb
   case, I do not believe that it has interupts disabled.  I could be
   wrong, but I didn't see it.

>That's completely right.  interrupts should never be disabled when
>__kfree_skb is executed.  It used to be possible when we allowed
>it to be invoked from interrupt handlers, but that is illegal and
>we have kfree_skb_irq which just reschedules the actual __kfree_skb
>to a software interrupt.

>So I agree with you, Mala's claims seem totally bogus and not well
>founded at all.
To name a few, interrupts are disabled when skbs are put back to the
hot_list
and when the cache list is accessed in the slab allocator. Am I missing
something? Please help me to understand.


Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088






