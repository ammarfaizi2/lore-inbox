Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbULRSJA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbULRSJA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 13:09:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261215AbULRSJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 13:09:00 -0500
Received: from main.gmane.org ([80.91.229.2]:34457 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261213AbULRSIv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 13:08:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Joseph Seigh" <jseigh_02@xemaps.com>
Subject: Re: What does atomic_read actually do?
Date: Sat, 18 Dec 2004 13:14:25 -0500
Message-ID: <opsi7uaby0s29e3l@grunion>
References: <opsi7o5nqfs29e3l@grunion> <20041218181102.69c37e84@tux.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.ne.client2.attbi.com
User-Agent: Opera M2/7.54 (Win32, build 3865)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Dec 2004 18:11:02 +0100, Paolo Ornati <ornati@fastwebnet.it>  
wrote:

> On Sat, 18 Dec 2004 11:23:37 -0500
> "Joseph Seigh" <jseigh_02@xemaps.com> wrote:
>
>> It doesn't do anything that would actually guarantee that the fetch
>> from memory would be atomic as far as I can see, at least in the x86
>> version. The C standard has nothing to say about atomicity w.r.t.
>> multithreading or multiprocessing.  Is this a gcc compiler thing?  If
>> so, does gcc guarantee that it will fetch aligned ints with a single
>> instruction on all platforms or just x86?   And what's with volatile
>> since if the C standard implies nothing about multithreading then it
>> follows that volatile has no meaning with respect to multithreading
>> either?  Also a gcc thing?  Are volatile semantics well defined enough
>> that you can use it to make the compiler synchronize memory state as
>> far as it is concerned?
>
> http://www.gnu.org/software/libc/manual/html_node/Atomic-Data-Access.html#Atomic%20Data%20Access
>
> http://www.gnu.org/software/libc/manual/html_node/Atomic-Types.html#Atomic%20Types

sig_atomic_t is only meaningful with respect to unix signals and is  
meaningless with
respect to threads.  And sig_atomic_t isn't atomic_t anyway.  And it has  
to useful
size, it could be in int on some platforms but only a byte on others.   
Signals and
threading are difficult enough as separate subjects.  Combining them is  
insanely
difficult but that's another topic.

>
> http://gcc.gnu.org/onlinedocs/gcc/Volatiles.html

"The C standard leaves it implementation defined as to what constitutes a  
volatile access."
Plus, I'm not sure sequence points are defined in C, and IIRC, C++ can  
combine and/or
reorder volatile accesses between sequence points.

Joe Seigh

