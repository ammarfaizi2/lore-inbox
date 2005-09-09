Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751435AbVIIHwE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbVIIHwE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 03:52:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbVIIHwE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 03:52:04 -0400
Received: from zproxy.gmail.com ([64.233.162.198]:52134 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751435AbVIIHwD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 03:52:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WJBB3Mt1tTJmTbFaaoMPlFBX7AG4V81Vu9rcF+ckjmZ3c3/kvYzdeKaxSIoHAmx1cv438qLLohUUmJQPpKMhSJnu2wf/govZDvDh5/j+vCr9e4E5RWtCi/67YK9nwshEl0nOMudifRyXaLwgvWpXXVG/Oy024Zq4xOSE0SXCgQM=
Message-ID: <aec7e5c3050909005273a0d12b@mail.gmail.com>
Date: Fri, 9 Sep 2005 16:52:00 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: magnus.damm@gmail.com
To: Paul Jackson <pj@sgi.com>
Subject: Re: [PATCH 0/5] SUBCPUSETS: a resource control functionality using CPUSETS
Cc: kurosawa@valinux.co.jp, dino@in.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20050908225539.0bc1acf6.pj@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050908053912.1352770031@sv1.valinux.co.jp>
	 <20050908002323.181fd7d5.pj@sgi.com>
	 <20050908081819.2EA4E70031@sv1.valinux.co.jp>
	 <20050908050232.3681cf0c.pj@sgi.com>
	 <20050909013804.1B64B70037@sv1.valinux.co.jp>
	 <aec7e5c305090821126cea6b57@mail.gmail.com>
	 <20050908225539.0bc1acf6.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/05, Paul Jackson <pj@sgi.com> wrote:
> magnus wrote:
> > Maybe it is possible to have an hierarchical model and keep the
> > framework simple and easy to understand while providing guarantees,
> 
> Dinakar's patches to use cpu_exclusive cpusets to define dynamic
> sched domains accomplish something like this.

Ah. I'm not familiar with Dinakar's patches and how these domains
work. I'm actually more interested in this from the memory resource
control point of view, but these areas are of course somehow related.
 
> What scheduler domains and resource control domains both need
> are non-overlapping subsets of the CPUs and/or Memory Nodes.

Yes, that sounds like a good idea. But because English is not my
native language, I just want to reassure that we mean the same thing.
Non-overlapping subsets of cpu or memory nodes basically mean that
children of a cpuset only clear bits in the bitmap, never sets them.
Please correct me if I'm wrong.

> In the case of sched domains, you normally want the subsets
> to cover all the CPUs.  You want every CPU to have exactly
> one scheduler that is responsible for its scheduling.

Hm, I'm not sure how this relates to memory management, but you
probably need a place to store per-bit (node/cpu) guarantee count
regardless of memory or cpu resource control.

I think one major problem is how the guarantee should be divided
between all subcpusets that share one bit. And using one percent value
(or page count) per cpuset if more than 1 bit is set raises a similar
guarantee question.

One solution to the guarantee dividing problem could be to have a
percent value per bit set in the bitmap, maybe something like this:

# echo 0=50% > /dev/cpuset/foo/cpus

> In the case of resource control domains, you perhaps don't
> care if some CPUs or Memory Nodes have no particular resources
> constraints defined for them.  In that case, every CPU and
> every Memory Node maps to _either_ zero or one resource control
> domain.

These "resource control domains", are they similar to your "meter"
suggestion earlier, or are they something else?
 
> Either way, a 'flat model' non-overlapping partitioning of the
> CPUs and/or Memory Nodes can be obtained from a hierarchical
> model (nested sets of subsets) by selecting some of the subsets
> that don't overlap ;).  In /dev/cpuset, this selection is normally
> made by specifying another boolean file (contains '0' or '1')
> that controls whether that cpuset is one of the selected subsets.

This boolean file, do you mean one of your "meter" files or something else?

Thank you for your comments!

/ magnus - will have a nice weekend now... =)
