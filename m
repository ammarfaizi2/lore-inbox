Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262545AbUDHUIG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 16:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262503AbUDHUHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 16:07:51 -0400
Received: from reformers.mr.itd.umich.edu ([141.211.93.147]:41134 "EHLO
	reformers.mr.itd.umich.edu") by vger.kernel.org with ESMTP
	id S262754AbUDHT52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:57:28 -0400
Date: Thu, 8 Apr 2004 15:57:19 -0400 (EDT)
From: Rajesh Venkatasubramanian <vrajesh@umich.edu>
X-X-Sender: vrajesh@ruby.engin.umich.edu
To: Hugh Dickins <hugh@veritas.com>
cc: mbligh@aracnet.com, akpm@osdl.org, andrea@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
In-Reply-To: <Pine.LNX.4.44.0404082029390.7600-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0404081553070.28416@ruby.engin.umich.edu>
References: <Pine.LNX.4.44.0404082029390.7600-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 8 Apr 2004, Hugh Dickins wrote:

> On Thu, 8 Apr 2004, Rajesh Venkatasubramanian wrote:
> >
> > I guess using vm_private_data for nonlinear is not a problem because
> > we use list i_mmap_nonlinear for nonlinear vmas.
> >
> > As you have found out vm_private_data is only used if vm_file != NULL
> > or VM_RESERVED or VM_DONTEXPAND is set. I think we can revert back to
> > i_mmap{_shared} list for such special cases and use prio_tree for
> > others. I maybe missing something. Please teach me.
>
> Sorry, I don't understand what you're proposing here, and why?
> Oh, to save 4 bytes of vma by making the special cases use a list,
> no need for vm_set_head, and vm_private_data for the driver itself;
> but regular vmas use prio_tree, with vm_set_head in vm_private_data.

Yeah. You are right.

> Hmm, right now it's getting too much for me: can we keep it simplish
> for now, and come back to this later?

Yeah. This complicates the code further. That's why I didn't touch
it now. If things settle down and if we really worry about sizeof
vm_area_struct in the future, then we can remove the 8 bytes used
by prio_tree.

Rajesh



