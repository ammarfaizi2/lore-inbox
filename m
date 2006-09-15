Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWIOQpq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWIOQpq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 12:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWIOQpq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 12:45:46 -0400
Received: from smtp-out.google.com ([216.239.45.12]:14938 "EHLO
	smtp-out.google.com") by vger.kernel.org with ESMTP
	id S1750738AbWIOQpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 12:45:45 -0400
DomainKey-Signature: a=rsa-sha1; s=beta; d=google.com; c=nofws; q=dns;
	h=received:subject:from:reply-to:to:cc:in-reply-to:references:
	content-type:organization:date:message-id:mime-version:x-mailer:content-transfer-encoding;
	b=qG1C85eAkQiq9BfeA21hGXE6szui/EA0VqJCBdARGljjftSvCUXsQJBDL6jNMXhoa
	bYn1BUaalhLZaHLp7n8UA==
Subject: Re: [Patch 01/05]- Containers: Documentation on using containers
From: Rohit Seth <rohitseth@google.com>
Reply-To: rohitseth@google.com
To: Rolf Eike Beer <eike-kernel@sf-tec.de>
Cc: Andrew Morton <akpm@osdl.org>, devel@openvz.org,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200609150815.19917.eike-kernel@sf-tec.de>
References: <1158284314.5408.146.camel@galaxy.corp.google.com>
	 <200609150815.19917.eike-kernel@sf-tec.de>
Content-Type: text/plain
Organization: Google Inc
Date: Fri, 15 Sep 2006 09:45:25 -0700
Message-Id: <1158338725.12311.25.camel@galaxy.corp.google.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-09-15 at 08:15 +0200, Rolf Eike Beer wrote:
> Rohit Seth wrote:
> > This patch contains the Documentation for using containers.
> 
> > +5- Remove a task from container
> > +	echo <pid> rmtask
> 
> echo <pid> > rmtask?
> 

rmtask is an attribute defined in test_container directory.  So, first
you have to cd into container directory
(cd /mnt/configfs/containers/test_container and then execute this
command)

> Please also give a short description what containers are for. From what I read 
> here I can only guess it's about gettings some statistics about a group of 
> tasks.

Containers allow different workloads to be run on the same platform with
limits defined on per container basis.  This basically allows a single
platform to be (soft) partitioned among different workloads (each of
which could be running many tasks).  The limits could be amount of
memory, number of tasks among other features.  These two features are
already implemented in the patch set that I posted.  But it is possible
to add other controllers like CPU that allows only finite amount of time
to the processes belonging to a container.

Currently this patch set is only tracking user memory (both file based
and anonymous).  The memory handler is currently deactivating pages
belonging to a container that has gone over the limit. Even though this
allows containers to go over board their limits but 1- once they are
over the limit then they run in degraded manner and 2- if there is any
memory pressure then the (extra) pages belonging to this container are
the prime candidates for swapping (for example).  The statistics that
are shown in each container directory are the current values of each
resource consumption.

Please let me know if you need any more specific information about the
patch set.

-rohit

