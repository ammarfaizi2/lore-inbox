Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318638AbSICDnH>; Mon, 2 Sep 2002 23:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318641AbSICDnH>; Mon, 2 Sep 2002 23:43:07 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:45504 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318638AbSICDnG>; Mon, 2 Sep 2002 23:43:06 -0400
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
To: jamal <hadi@cyberus.ca>
Cc: Bill Hartner <bhartner@us.ibm.com>, davem@redhat.com,
       linux-kernel@vger.kernel.org, Mala Anand <manand@us.ibm.com>,
       netdev@oss.sgi.com, Robert Olsson <Robert.Olsson@data.slu.se>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF83A9561B.62B3A967-ON87256C29.001354D0@boulder.ibm.com>
From: "Mala Anand" <manand@us.ibm.com>
Date: Mon, 2 Sep 2002 22:47:13 -0500
X-MIMETrack: Serialize by Router on D03NM123/03/M/IBM(Release 5.0.10 |March 22, 2002) at
 09/02/2002 09:47:16 PM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>On Tue, 27 Aug 2002, Mala Anand wrote:

>> SPECweb99 profile shows that __kfree_skb is in the top 5 hot routines.
We
>> will test the skb recycle patch on SPECweb99 and add skbinit patch
>> to that and see how it helps.  What I understand is that the skb recycle
>> patch does not attempt to recycle if the skbs are allocated on CPU
>> and freed on another CPU. Is that right? If so, skbinit patch will help
>> those cases.

>yes it will. Not significant is my current thinking. i.e i wouldn't write
>my mother to tell her about it.

I have not looked at Robert's recycle skb patch yet. I couldn't
find it in the link he sent me so I don't know how it works. However
I thought about it a little more and realized that even when you
recycle the skbs, they need to be initialized (cleaned up). I don't
understand how
can the recycle skb patch avoid calling constructors and destructors for
the
skb.  The skbs are given back to the driver instead of freeing to the skb
hot list
or to the slab. That does not eliminate the part of the code of kfree_skb
which
releases dst, initializes part of skb and executes destructor.
Tell me if I am wrong but wouldn't it break the code. So I do think that
recycle skb patch will not mitigate the benefits of the skb init
patch.


Regards,
    Mala


   Mala Anand
   IBM Linux Technology Center - Kernel Performance
   E-mail:manand@us.ibm.com
   http://www-124.ibm.com/developerworks/opensource/linuxperf
   http://www-124.ibm.com/developerworks/projects/linuxperf
   Phone:838-8088; Tie-line:678-8088





