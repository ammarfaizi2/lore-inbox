Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318745AbSHANPF>; Thu, 1 Aug 2002 09:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318746AbSHANPF>; Thu, 1 Aug 2002 09:15:05 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:48308 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S318745AbSHANPE>; Thu, 1 Aug 2002 09:15:04 -0400
Date: Thu, 1 Aug 2002 18:52:36 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Mala Anand <manand@us.ibm.com>
Cc: "Luck, Tony" <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
       lse <lse-tech@lists.sourceforge.net>,
       Bill Hartner <Bill_Hartner@us.ibm.com>
Subject: Re: [Lse-tech] [RFC]  per cpu slab fix to reduce freemiss
Message-ID: <20020801185236.B32256@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <OFAA15AB55.4677568D-ON87256C07.0049E839@boulder.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OFAA15AB55.4677568D-ON87256C07.0049E839@boulder.ibm.com>; from manand@us.ibm.com on Thu, Aug 01, 2002 at 07:42:10AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 01, 2002 at 07:42:10AM -0500, Mala Anand wrote:
> 
> 
> Tony Luck wrote..
> >> No I am using the object(beginning space) to store the links. When
> >> allocated, I can initialize the space occupied by the link address.
> 
> >You can't use the start of the object (or any other part) in this way,
> >you'll have no way to restore the value you overwrote.
> 
> >Take a look at Jeff Bonwick's paper on slab allocators which explains
> >this a lot better than I can:
> 
> >
> http://www.usenix.org/publications/library/proceedings/bos94/full_papers/bon
> 
> >wick.a
> 
> In the present design there is a limit on how many free objects are held
> in the per cpu array. So when an object is freed it might end in another
> cpu more often.  The main cost lies in memory latency than execution of
> initializing the fields.  I doubt if we get the same gain as explained in
> the paper by preserving the fields between uses on an SMP/NUMA machines.
> 
> I agree that preserving read only variables that can be used between uses
> will help performance. We still can do that by revising the assumption to
> leave the first 4 or whatever bytes needed to store the links. What do you
> think?

Mala,

Isn't it possible to tune the cpucache limit by writing to
/proc/slabinfo so that you avoid frequent draining of free objects ?
Am I missing something here ?

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
