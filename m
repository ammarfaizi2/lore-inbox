Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263214AbSJHXdm>; Tue, 8 Oct 2002 19:33:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263241AbSJHXdN>; Tue, 8 Oct 2002 19:33:13 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:59557 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S261441AbSJHXcq>;
	Tue, 8 Oct 2002 19:32:46 -0400
Date: Tue, 08 Oct 2002 16:34:09 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Luck, Tony" <tony.luck@intel.com>, lse-tech@lists.sourceforge.net
cc: "Kamble, Nitin A" <nitin.a.kamble@intel.com>, linux-kernel@vger.kernel.org,
       tomlins@cam.org, akpm@digeo.com
Subject: RE: [Lse-tech] [RFC] numa slab for 2.5.41-mm1
Message-ID: <599040000.1034120049@flay>
In-Reply-To: <39B5C4829263D411AA93009027AE9EBB1EF28EFB@fmsmsx35.fm.intel.com>
References: <39B5C4829263D411AA93009027AE9EBB1EF28EFB@fmsmsx35.fm.intel.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> - is it possible implement ptr_to_nodeid()
>>   on all archs efficiently? It will happen for every kfree().
> 
> The best platform independent way that I came up with was to stash
> the node id in the page structure ... the initial patch that Nitin
> posted included code for this (and it's all my fault that this
> added an extra element to the page structure).  I think that you
> suggested that slab could overload the use of some existing field
> if we wanted to pursue this direction.
> 
> If ptr_to_nodeid() is made a platform dependent function, then

I think that's really the key .... the platforms should just make this
efficient, it's not something for the slab to worry about specifically.
Those of us that have virtual address space to burn can stick it in
struct page, whereas other people (eg me) might have to find some
other way to do it .... but that's the arch people's problem ;-)

> there are some platforms that can do this very efficiently (since
> the nodeid is embedded in some of the high-order address bits), and
> some for which this is complex (e.g. platforms that concatenate
> memory from each node).

M.

