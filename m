Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUCSJCb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 04:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262035AbUCSJCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 04:02:31 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:46087 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262022AbUCSJCZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 04:02:25 -0500
Message-ID: <405AB72B.4030204@aitel.hist.no>
Date: Fri, 19 Mar 2004 10:02:35 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: sched_setaffinity usability
References: <40595842.5070708@redhat.com> <20040318112913.GA13981@elte.hu> <20040318120709.A27841@infradead.org> <Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org> <20040318182407.GA1287@elte.hu>
In-Reply-To: <20040318182407.GA1287@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> 
>>sysconf() is a user-level implementation issue, and so is something
>>like "number of CPU's". Damn, the simplest way to do it is as a
>>environment variable, for christ sake! Just make a magic environment
>>variable called __SC_ARRAY, and make it be some kind of binary
>>encoding if you worry about performance.
> 
> 
> i am not arguing for any sysconf() support at all - it clearly belongs
> into glibc. Just doing 'man sysconf' shows that it should be in
> user-space. No argument about that.
> 
> But how about the original issue Ulrich raised: how does user-space
> figure out the NR_CPUS value supported by the kernel? (not the current #
> of CPUs, that can be figured out using /proc/cpuinfo)
> 
> one solution would be what you suggest: to build some sort of /etc/info
> file that glibc can access, which file is build during the kernel build
> and contains the necessary constants. One problem with this approach is
> that a user could boot via any arbitrary kernel, how does glibc (or even
> a supposed early-init info-setup mechanism) know what info belongs to
> which kernel? Kernel version numbers are not required to be unique. A
> single non-modular bzImage can be used to have a fully working
> userspace. Right now the kernel and glibc is isolated pretty much and
> this gives us flexibility.

Let the compile create that info file.  Then handle it much like a module,
except that it is a "module" without any code.  
I.e. copy it to /lib/modules/<kernelversion> if installing modules,
or stuff the file into the initrd if making an initrd.  

Now it is in a place specific to the kernel, where a library can find it.

Helge Hafting


