Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265626AbTGDBWD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 21:22:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265629AbTGDBWD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:22:03 -0400
Received: from holomorphy.com ([66.224.33.161]:35269 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S265626AbTGDBWA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:22:00 -0400
Date: Thu, 3 Jul 2003 18:36:12 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Jamie Lokier <jamie@shareable.org>, "Martin J. Bligh" <mbligh@aracnet.com>,
       Mel Gorman <mel@csn.ul.ie>,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What to expect with the 2.6 VM
Message-ID: <20030704013612.GV26348@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>,
	Jamie Lokier <jamie@shareable.org>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Mel Gorman <mel@csn.ul.ie>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030702233014.GW23578@dualathlon.random> <20030702235540.GK26348@holomorphy.com> <20030703113144.GY23578@dualathlon.random> <20030703114626.GP26348@holomorphy.com> <20030703125839.GZ23578@dualathlon.random> <20030703184825.GA17090@mail.jlokier.co.uk> <20030703185431.GQ26348@holomorphy.com> <20030703193328.GN23578@dualathlon.random> <20030703222113.GS26348@holomorphy.com> <20030704004641.GR23578@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704004641.GR23578@dualathlon.random>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 03, 2003 at 03:21:13PM -0700, William Lee Irwin III wrote:
>> It's obvious what to do about protections.

On Fri, Jul 04, 2003 at 02:46:41AM +0200, Andrea Arcangeli wrote:
> so you agree it'd better be a separate syscall, also given it seems
> the current remap_file_pages api in 2.5 seems unfortunately already
> frozen since I think it's wrong as it should only work on VM_NONLINEAR
> vmas, it's very unclean to allow remap_file_pages to mangle whatever vma
> out there despite it has to deal with truncate etc.. I think the minium
> required change to the API is to add a MAP_NONLINEAR that converts in
> kernel space to a VM_NONLINEAR. You allocate the mapping with
> mmap(MAP_NONLINAER) and only then remap_file_pages will work. This
> solves all the current brekages (and it'll be trivial to skip over
> VM_NONLINEAR in the 2.4 vm too). (then there's the rmap/mlock/munlock
> issue but that's an implementation issue non visible from userspace
> [modulo security with the sysctl], this one instead is a API bug IMHO
> and it'd better be fixed before people puts the backport in production)

sys_chattr_file_pages() etc. sounds fine to me; GC's would love it.

I'll tackle the rest in another (somewhat more inflammatory) post.

-- wli
