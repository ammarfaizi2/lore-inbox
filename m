Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263315AbSJHXZu>; Tue, 8 Oct 2002 19:25:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263238AbSJHXZk>; Tue, 8 Oct 2002 19:25:40 -0400
Received: from fmr01.intel.com ([192.55.52.18]:36578 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S263283AbSJHXYF>;
	Tue, 8 Oct 2002 19:24:05 -0400
Message-ID: <39B5C4829263D411AA93009027AE9EBB1EF28EFB@fmsmsx35.fm.intel.com>
From: "Luck, Tony" <tony.luck@intel.com>
To: lse-tech@lists.sourceforge.net
Cc: "Kamble, Nitin A" <nitin.a.kamble@intel.com>, linux-kernel@vger.kernel.org,
       tomlins@cam.org, akpm@digeo.com,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: RE: [Lse-tech] [RFC] numa slab for 2.5.41-mm1
Date: Tue, 8 Oct 2002 16:29:45 -0700 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul wrote:

> - is it possible implement ptr_to_nodeid()
>   on all archs efficiently? It will happen for every kfree().

The best platform independent way that I came up with was to stash
the node id in the page structure ... the initial patch that Nitin
posted included code for this (and it's all my fault that this
added an extra element to the page structure).  I think that you
suggested that slab could overload the use of some existing field
if we wanted to pursue this direction.

If ptr_to_nodeid() is made a platform dependent function, then
there are some platforms that can do this very efficiently (since
the nodeid is embedded in some of the high-order address bits), and
some for which this is complex (e.g. platforms that concatenate
memory from each node).

-Tony
