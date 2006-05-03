Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965235AbWECQTm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965235AbWECQTm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 12:19:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965236AbWECQTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 12:19:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.150]:24236 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S965235AbWECQTl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 12:19:41 -0400
Date: Wed, 3 May 2006 11:19:39 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: "Serge E. Hallyn" <serue@us.ibm.com>
Cc: Andi Kleen <ak@suse.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       herbert@13thfloor.at, dev@sw.ru, linux-kernel@vger.kernel.org,
       sam@vilain.net, xemul@sw.ru, haveblue@us.ibm.com, clg@fr.ibm.com,
       frankeh@us.ibm.com
Subject: Re: [PATCH 7/7] uts namespaces: Implement CLONE_NEWUTS flag
Message-ID: <20060503161939.GC18576@sergelap.austin.ibm.com>
References: <20060501203906.XF1836@sergelap.austin.ibm.com> <200605021017.19897.ak@suse.de> <20060502172031.GA22923@sergelap.austin.ibm.com> <200605021930.45068.ak@suse.de> <20060503161143.GA18576@sergelap.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060503161143.GA18576@sergelap.austin.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Serge E. Hallyn (serue@us.ibm.com):
> Quoting Andi Kleen (ak@suse.de):
> > On Tuesday 02 May 2006 19:20, Serge E. Hallyn wrote:
> > > > With many name spaces you would have smaller task_struct, less cache 
> > > > foot print, better cache use of task_struct because slab cache colouring
> > > > will still work etc.
> > > 
> > > I suppose we could run some performance tests with some dummy namespace
> > > pointers?  9 void *'s directly in the task struct, and the same inside a
> > > refcounted container struct.  The results might add some urgency to
> > > implementing the struct nsproxy.
> > 
> > Not sure you'll notice too much difference on the beginning. I am just
> 
> 9 void*'s is probably more than we'll need, though, so it's not "the
> beginning".   Eric previously mentioned uts, sysvipc, net, pid, and uid,
> to which we might add proc, sysctl, and signals, though those are
> probably just implied through the others.
> 
> What others do you see us needing?
> 
> If the number were more likely to be 50, then in the above experiment
> use 50 instead - the point was to see the performance implications
> without implementing the namespaces first.
> 
> Anyway I guess I'll go ahead and queue up some tests.

Though of course one reason those tests won't be very meaningful is that
the void*'s won't be being dereferenced, so we won't be accounting for
the performance hit of the double dereference and resulting cache
hits...

-serge
