Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUDHQyc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 12:54:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbUDHQyc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 12:54:32 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:50133 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261979AbUDHQya (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 12:54:30 -0400
Date: Thu, 08 Apr 2004 10:05:42 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>
cc: Andi Kleen <ak@suse.de>, colpatch@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: NUMA API for Linux
Message-ID: <5470000.1081443942@flay>
In-Reply-To: <Pine.LNX.4.44.0404081641450.7277-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0404081641450.7277-100000@localhost.localdomain>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, 7 Apr 2004, Andrew Morton wrote:
>> 
>> Your patch takes the CONFIG_NUMA vma from 64 bytes to 68.  It would be nice
>> to pull those 4 bytes back somehow.
> 
> How significant is this vma size issue?
> 
> anon_vma objrmap will add 20 bytes to each vma (on 32-bit arches):
> 8 for prio_tree, 12 for anon_vma linkage in vma,
> sometimes another 12 for the anon_vma head itself.

Ewwww. Isn't some of that shared most of the time though?

> anonmm objrmap adds just the 8 bytes for prio_tree,
> remaining overhead 28 bytes per mm.

28 bytes per *mm* is nothing, and I still think the prio_tree is 
completely unneccesary. Nobody has ever demonstrated a real benchmark
that needs it, as far as I recall.

> Seems hard on Andi to begrudge him 4.

I don't care about the 4 bytes much (other than that the current 64 happens
to be a nice size). I just don't see the point in making copies of the 
binding structure all the time ;-) Refcounts aren't that hard ... didn't
Greg do a kref just recently? ...

M.


