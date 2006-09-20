Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751858AbWITQo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751858AbWITQo0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 12:44:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751865AbWITQo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 12:44:26 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:43224 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751858AbWITQoX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 12:44:23 -0400
Date: Wed, 20 Sep 2006 09:43:48 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Rohit Seth <rohitseth@google.com>
cc: Andrew Morton <akpm@osdl.org>, CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       devel@openvz.org, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch01/05]:Containers(V2): Documentation
In-Reply-To: <1158718655.29000.47.camel@galaxy.corp.google.com>
Message-ID: <Pine.LNX.4.64.0609200940550.30754@schroedinger.engr.sgi.com>
References: <1158718655.29000.47.camel@galaxy.corp.google.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sep 2006, Rohit Seth wrote:

> +Currently we are tracking user memory (both file based
> +and anonymous).  The memory handler is currently deactivating pages
> +belonging to a container that has gone over the limit. Even though this
> +allows containers to go over board their limits but 1- once they are
> +over the limit then they run in degraded manner and 2- if there is any
> +memory pressure then the (extra) pages belonging to this container are
> +the prime candidates for swapping (for example).  The statistics that
> +are shown in each container directory are the current values of each
> +resource consumption.

Containers via cpusets allow a clean implementation of a restricted memory 
area. The system will swap and generate an OOM message if no memory can be 
recovered.

> +4- Add a task to container
> +	cd /mnt/configfs/cotnainers/test_container
> +	echo <pid> > addtask
> +
> +Now the <pid> and its subsequently forked children will belong to container
> +test_container.
> +
> +5- Remove a task from container
> +	echo <pid> > rmtask

Could you make that compatible with the way cpusets do it?

> +9- Freeing a container
> +	cd /mnt/configfs/containers/
> +	rmdir test_container

Adding and removal is the same way as cpusets.
