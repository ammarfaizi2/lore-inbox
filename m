Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965125AbVINJqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965125AbVINJqh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:46:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965126AbVINJqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:46:37 -0400
Received: from nproxy.gmail.com ([64.233.182.202]:52374 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965125AbVINJqg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:46:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KXU6aL4CglNccmFjBubiXz2k83uXFLuQhAJOajj9dG6ubeVpH1QukRWV/ESLtxPRSmuIg8JDb2oYN87Bnc00mVfEM5eCuEpBUu6zO8HB46c/mcB9UMadIU712RRG1ZDsc4nvEoGeTbrjujgRa/L+NParGE2dlE8yEgm4UMpMvjM=
Message-ID: <69304d11050914024613878d41@mail.gmail.com>
Date: Wed, 14 Sep 2005 11:46:34 +0200
From: Antonio Vargas <windenntw@gmail.com>
Reply-To: windenntw@gmail.com
To: pcaulfie@redhat.com
Subject: Re: [Linux-cluster] Re: GFS, what's remaining
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <4327E6E3.3050501@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050901104620.GA22482@redhat.com>
	 <20050903214653.1b8a8cb7.akpm@osdl.org>
	 <20050904045821.GT8684@ca-server1.us.oracle.com>
	 <20050903224140.0442fac4.akpm@osdl.org>
	 <20050905043033.GB11337@redhat.com>
	 <20050905015408.21455e56.akpm@osdl.org>
	 <20050905092433.GE17607@redhat.com>
	 <20050905021948.6241f1e0.akpm@osdl.org>
	 <1125922894.8714.14.camel@localhost.localdomain>
	 <4327E6E3.3050501@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/14/05, Patrick Caulfield <pcaulfie@redhat.com> wrote:
> I've just returned from holiday so I'm late to this discussion so let me tell
> you what we do now and why and lets see what's wrong with it.
> 
> [snip lots of useful stuff]
> 
> While having an FD per lock sounds like a nice unixy idea I don't think it would
> work very well in practice. Applications with hundreds or thousands of locks
> (such as databases) would end up with huge pollfd structs to manage, and it

Or rather use epoll instead of poll/select to avoid scalability issues.

> while it helps the refcounting (currently the nastiest bit of the current
> dlm_device code) removes the possibility of having persistent locks that exist

The refcounting is already implemented for FDs and will be kept
working 100% of the time because if it failed the kernel would not
even boot for most people due to initscripts leaking massive memory at
exit time. Not that GFS will not be maintained, but the
kernel-at-large has more people behind it.

> after the process exits - a handy feature that some people do use, though I
> don't think it's in the currently submitted DLM code. One FD per lock also gives

Perhaps persistent locks could be registered with a daemon by passing
them via unix pipes.

> each lock two handles, the lock ID used internally by the DLM and the FD used
> externally by the application which I think is a little confusing.
> 
> I don't think a dlmfs is useful, personally. The features you can export from it
> are either minimal compared to the full DLM functionality (so you have to export
> the rest by some other means anyway) or are going to be so un-filesystemlike as
> to be very awkward to use. Doing lock operations in shell scripts is all very
> cool but how often do you /really/ need to do that?
> 
> I'm not saying that what we have is perfect - far from it - but we have thought
> about how this works and what we came up with seems like a good compromise
> between providing full DLM functionality to userspace using unix features. But
> we're very happy to listen to other ideas - and have been doing I hope.
> 
> --
> 
> patrick
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


-- 
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/

Las cosas no son lo que parecen, excepto cuando parecen lo que si son.
