Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281952AbRKUTHM>; Wed, 21 Nov 2001 14:07:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281949AbRKUTHC>; Wed, 21 Nov 2001 14:07:02 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:19879 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S281943AbRKUTG5>; Wed, 21 Nov 2001 14:06:57 -0500
Message-ID: <3BFBFB4F.8090403@redhat.com>
Date: Wed, 21 Nov 2001 14:06:55 -0500
From: Doug Ledford <dledford@redhat.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011115
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jeff Merkey <jmerkey@timpanogas.org>
CC: arjan@fenrus.demon.nl, linux-kernel@vger.kernel.org
Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid opcode
In-Reply-To: <E166S8l-0007hs-00@fenrus.demon.nl> <002401c172ba$b46bed20$f5976dcf@nwfs>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Merkey wrote:

> ----- Original Message -----
> From: <arjan@fenrus.demon.nl>
> To: "Jeff Merkey" <jmerkey@timpanogas.org>
> Cc: <linux-kernel@vger.kernel.org>
> Sent: Wednesday, November 21, 2001 12:49 AM
> Subject: Re: [VM/MEMORY-SICKNESS] 2.4.15-pre7 kmem_cache_create invalid
> opcode
> 
> 
> 
>>In article <003401c1725a$975ad4e0$f5976dcf@nwfs> you wrote:
>>
>>
>>>OK.  Cool.  Now we are making progress.  I think this is a nasty
>>>
> problem.
> 
>>>There are numerous RPMs that will build against the kernel tree and be
>>>busted.  I would expect an rpm -ba on your DEFAULT kernel in Redhat with
>>>the sources contained in the kernel.rpm files to also be broken unless
>>>someone has done this.
>>>
>>That's why Red Hat ships the kernel-source RPM; you can build external
>>modules against that and it has the "make dep" information for all kernels
>>Red Hat ships for that platform (with a smart "if" that selects the
>>currently running one)........... But note the word "external". You build
>>
> in
> 
>>another directory and don't touch the original .config file or tree......
>>Unless you need core changes, that's perfectly possible for almost all
>>modules....
>>
>>
> 
> I would anticipate seeing this problem with their kernel source RPM.  In
> fact, I do,
> you have to do a make distclean before you can use it because of the way
> their rpm
> script munges all the versioned trees into a tmp area during RPM creation.



This is not true at all.  To see what I'm referring to, download the 
module build kit from my website (http://people.redhat.com/dledford) and 
see how it uses box stock kernel include files from our kernel-source 
package to build *all* of the needed modules from one source tree (i386, 
i386smp, i386BOOT, i586, i586SMP, i686, i686SMP, i686enterprise).


> There's only
> one source tree (usually the last one they built) and lots of binary rpm
> versions from the
> one tree (i.e. i386, i686, etc.).


If you look in the linux/include/linux/modversions/*.h files, you will 
see that the different RPM build package versions have all their symbols 
in those files #ifdef'ed so that you get the ones you need to match the 
running kernel (or if you trick the rhversion.h file, whichever version 
you request, see my Makefile).


> Jeff
> 
> 
>>Greetings,
>>    Arjan van de Ven
>>
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 
> 



-- 

  Doug Ledford <dledford@redhat.com>  http://people.redhat.com/dledford
       Please check my web site for aic7xxx updates/answers before
                       e-mailing me about problems

