Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751847AbWB0XN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbWB0XN4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 18:13:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751848AbWB0XNz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 18:13:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:43162 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751847AbWB0XNy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 18:13:54 -0500
Date: Mon, 27 Feb 2006 15:13:38 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: Paul Jackson <pj@sgi.com>, dgc@sgi.com, steiner@sgi.com,
       Simon.Derr@bull.net, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 01/02] cpuset memory spread slab cache filesys
In-Reply-To: <200602272339.42574.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0602271510320.12637@schroedinger.engr.sgi.com>
References: <20060227070209.1994.26823.sendpatchset@jackhammer.engr.sgi.com>
 <200602272202.34346.ak@suse.de> <Pine.LNX.4.64.0602271414290.12093@schroedinger.engr.sgi.com>
 <200602272339.42574.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2006, Andi Kleen wrote:

> I don't quite get your logic here. For me it would be logical to apply
> the memory policy from the process for anything _but_ slab caches
> that have SLAB_MEM_SPREAD set. For those interleaving should be always used.

Interleaving is a special feature to be used only if we know that the 
objects are used in a system wide fashion. Interleave should never be the 
default option.

F.e. inode interleaving for a process that is running on one 
node and scanning files will reduce performance. This is the typical
case.

On the other hand if files are used by multiple processes in a cpuset then 
interleaving may be beneficial.
 
> Why are you proposing to do it the other way round?

Because these are the types of objects that may benefit from 
interleaving. Other slabs need to always be allocated in a node local 
way.
