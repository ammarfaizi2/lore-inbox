Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751436AbWGLVxp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751436AbWGLVxp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 17:53:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbWGLVxp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 17:53:45 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:65303 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751436AbWGLVxp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 17:53:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=p7y8whmLuGYOc4v6tBHFTcB6zvVmxeJi+FV9YZlEcaQi/G9LrdQWfUPuyWW+HiwAFqkI/nx9iGCiJsgMeLE4eWrBvY4eVJulewX11hkrhoWscaqnm680coU3CcmA03F8o1LSxS9Yoyl4Bfc4csPG0LRCSeblkQt9BdGmyHS0qNE=
Message-ID: <a762e240607121453g5cf98ac0s6aef7255e5e35f@mail.gmail.com>
Date: Wed, 12 Jul 2006 14:53:43 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Badari Pulavarty" <pbadari@us.ibm.com>
Subject: Re: xfs fails dbench in 2.6.18-rc1-mm1
Cc: "Martin Bligh" <mbligh@google.com>, "Eric Dumazet" <dada1@cosmosbay.com>,
       lkml <linux-kernel@vger.kernel.org>, "Andrew Morton" <akpm@osdl.org>,
       "Andy Whitcroft" <apw@shadowen.org>
In-Reply-To: <1152739939.22840.1.camel@dyn9047017100.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <44B52A19.3020607@google.com>
	 <200607121912.52785.dada1@cosmosbay.com> <44B557DA.2050208@google.com>
	 <44B55A9E.2010403@us.ibm.com> <44B55AEA.1010608@google.com>
	 <1152739939.22840.1.camel@dyn9047017100.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/12/06, Badari Pulavarty <pbadari@us.ibm.com> wrote:
> On Wed, 2006-07-12 at 13:26 -0700, Martin Bligh wrote:
> > Badari Pulavarty wrote:
> > > Martin Bligh wrote:
> > >
> > >> Eric Dumazet wrote:
> > >>
> > >>> On Wednesday 12 July 2006 18:58, Martin Bligh wrote:
> > >>>
> > >>>> http://test.kernel.org/abat/40891/debug/test.log.1
> > >>>>
> > >>>> Filesystem type for /mnt/tmp is xfs
> > >>>> write failed on handle 13786
> > >>>> 4 clients started
> > >>>> Child failed with status 1
> > >>>> write failed on handle 13786
> > >>>> write failed on handle 13786
> > >>>> write failed on handle 13786
> > >>>>
> > >>>> Works fine in -git4
> > >>>> All other fs's seemed to run OK.
> > >>>>
> > >>>> Machine is a 4x Opteron.
> > >>>
> > >>>
> > >>>
> > >>> You need to revert 92eb7a2f28d551acedeb5752263267a64b1f5ddf
> > >>
> > >>
> > >> Still fails (thanks Andy).
> > >>
> > > Wondering if its my changes :(
> > > Can you back out these and try ?
> > >
> > > Please, Please tell me that, its not me :)
> > >
> > > Thanks,
> > > Badari
> > >
> > > #
> > > vectorize-aio_read-aio_write-fileop-methods.patch
> > > remove-readv-writev-methods-and-use-aio_read-aio_write.patch
> > > streamline-generic_file_-interfaces-and-filemap.patch
> > > streamline-generic_file_-interfaces-and-filemap-ecryptfs.patch
> >
> > You could submit a job to elm3b6 to run dbench on xfs ;-)
> >
> > M.
>
>
> I am not able to "insmod xfs.ko" on my x86-64 machine :(
>
> elm3b29:~ # modprobe xfs
> FATAL: Error inserting xfs (/lib/modules/2.6.18-rc1-
> mm1/kernel/fs/xfs/xfs.ko): Cannot allocate memory
>
> #dmesg shows ..
>
> Could not allocate 8 bytes percpu data
> Could not allocate 8 bytes percpu data
> Could not allocate 8 bytes percpu data
> Could not allocate 8 bytes percpu data
> Could not allocate 8 bytes percpu data
> Could not allocate 8 bytes percpu data
> Could not allocate 328 bytes percpu data
> Could not allocate 328 bytes percpu data
> Could not allocate 328 bytes percpu data
>
>
> Whats happening here ?

The per-cpu area is exhausted in -mm x68_64 (If you pump up the percpu
area or cut down NR_CPUS you can work around it).  I ran into this a
few -mm release ago. There are some details in the 2.6.17-mm6 thread
from July 5th of so.

Thanks,
  Keith
