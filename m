Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964944AbWEBRbA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964944AbWEBRbA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 13:31:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964945AbWEBRbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 13:31:00 -0400
Received: from cantor2.suse.de ([195.135.220.15]:45217 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964944AbWEBRa7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 13:30:59 -0400
From: Andi Kleen <ak@suse.de>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
Date: Tue, 2 May 2006 19:30:44 +0200
User-Agent: KMail/1.9.1
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, herbert@13thfloor.at,
       dev@sw.ru, linux-kernel@vger.kernel.org, sam@vilain.net, xemul@sw.ru,
       haveblue@us.ibm.com, clg@fr.ibm.com, frankeh@us.ibm.com
References: <20060501203906.XF1836@sergelap.austin.ibm.com> <200605021017.19897.ak@suse.de> <20060502172031.GA22923@sergelap.austin.ibm.com>
In-Reply-To: <20060502172031.GA22923@sergelap.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200605021930.45068.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 02 May 2006 19:20, Serge E. Hallyn wrote:
> Quoting Andi Kleen (ak@suse.de):
> > On Tuesday 02 May 2006 10:03, Eric W. Biederman wrote:
> > 7 additional bits will probably not be enough. I still don't
> > quite understand why you want individual bits for everything.
> > Why not group them into logical pieces? 
> 
> I wouldn't be surprised if it makes sense to combine some of them.  For
> instance, perhaps utsname and networking?

I frankly would just combine everything new.

> 
> > Have a proxy structure which has pointers to the many name spaces and a bit
> > mask for "namespace X is different".
> 
> different from what?

>From the parent.

> 
> Oh, you mean in case we want to allow cloning a namespace outside of
> fork *without* cloning the nsproxy struct?

Basically every time any name space changes you need a new nsproxy.

> 
> > This structure would be reference
> > counted. task_struct has a single pointer to it.
> 
> If it is reference counted, that implies it is shared between some
> processes.  But namespace pointers themselves are shared between some of
> these nsproxy's.  The lifetime mgmt here is one reason I haven't tried a
> patch to do this.

The livetime management is no different from having individual pointers.

> > With many name spaces you would have smaller task_struct, less cache 
> > foot print, better cache use of task_struct because slab cache colouring
> > will still work etc.
> 
> I suppose we could run some performance tests with some dummy namespace
> pointers?  9 void *'s directly in the task struct, and the same inside a
> refcounted container struct.  The results might add some urgency to
> implementing the struct nsproxy.

Not sure you'll notice too much difference on the beginning. I am just
the opinion memory/cache bloat needs to be attacked at the root, not
when it's too late.

-Andi
