Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUHGPY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUHGPY6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Aug 2004 11:24:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263019AbUHGPY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Aug 2004 11:24:58 -0400
Received: from mail01.hpce.nec.com ([193.141.139.228]:46006 "EHLO
	mail01.hpce.nec.com") by vger.kernel.org with ESMTP id S263062AbUHGPYr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Aug 2004 11:24:47 -0400
From: Erich Focht <efocht@hpce.nec.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Date: Sat, 7 Aug 2004 17:22:36 +0200
User-Agent: KMail/1.6.2
Cc: mbligh@aracnet.com, lse-tech@lists.sourceforge.net, akpm@osdl.org,
       hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de, sivanich@sgi.com
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200408061730.06175.efocht@hpce.nec.com> <20040806231013.2b6c44df.pj@sgi.com>
In-Reply-To: <20040806231013.2b6c44df.pj@sgi.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200408071722.36705.efocht@hpce.nec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 August 2004 08:10, Paul Jackson wrote:
> > I think cpusets and CKRM should be
> > made to come together. One of CKRM's user interfaces is a filesystem
> > with the file-tree representing the class hierarchy. It's the same for
> > cpusets.
> 
> Hmmm ... this suggestion worries me, for a couple of reasons.
> 
> Just because cpusets and CKRM both have a hierarchy represented in a
> file system doesn't mean it is, or can be, the same file system.  Not
> all trees are the same.

Cpusets are a complex resource which needs to be managed. You already
provided an interface for management but on the horizon there is this
CKRM thing... I really don't care too much about the interface as long
as it is comfortable (advocating for your bitset manipulation routines
here ;-). CKRM will some day come in and maybe try to unify the
resource control through a generalized interface. In my understand
CKRM "classes" are (for the cpusets resource) your "sets". I was
trying to anticipate that CKRM might want to present the single entry
point for managing resources, including cpusets.

If I understand correctly, CKRM is fine for simple resources like
amount of memory or cputime and designed to control flexible sharing
of these resources and ensure some degree of fairness. Cpusets is a
complex NUMA specific compound resource which actually only allows for
a rather static distribution across processes (especially with the
exclusive bits set). Including cpusets control into CKRM will be
trivial, because you already provide all that's needed.

What I proposed was to include cpusets ASAP. As we learned from
Hubertus, CKRM is undergoing some redesign (after the kernel summit),
so let's now get used to cpusets and forget about the generic resource
controller until that is mature to enter the kernel. When that happens
people might love the generic way of controlling resources and the
cpusets user interface will be yet another filesystem for controlling
some hierarchical structures... The complaints about the huge size of
the patch should therefore have in mind that we might well get rid of
the user interface part of it. The core infrastructure of cpusets will
be needed anyway and the amount of code is the absolutely required
minimum, IMHO.


> The other reason that this suggestion worries me is a bit more
> philosophical.  I'm sure that for all the other, well known,
> resources that CKRM manages, no one is proposing replacing whatever
> existing names and mechanisms exist for those resources, such as
> bandwidth, compute cycles, memory, ...  Rather I presume that CKRM
> provides an additional resource management layer on top of the
> existing resources, which retain their classic names and apparatus.
> [...]

I hope cpusets will be an "existing resource" when CKRM comes into
play. It's a compound resource built of cpus and memories (and the
name cpuset is a bit misleading) but it fully makes sense on a NUMA
machine to have these two elementary resources glued together. If CKRM
was to build a resource controller for cpu masks and memories, or two
separate resource controllers, the really acceptable end result would
look like the current cpusets infrastructure. So why waste time?

Later cpusets could borrow the user interface of CKRM or, if the
cpusets user interface is better suited, maybe we can just have a
/rcfs/cpusets/ directory tree with the current cpusets look and feel?
Question to CKRM people: would it make sense to have a class with
another way of control than the shares/targets/members files?

> I'd hate to see cpusets hidden behind resource management terms from day
> one.

That's an argument. Less RTFM mails, happier admins and users... A
better world ;-)

Regads,
Erich

