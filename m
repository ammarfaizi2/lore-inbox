Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263463AbTJVKPO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Oct 2003 06:15:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263468AbTJVKPO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Oct 2003 06:15:14 -0400
Received: from indigo.cs.bgu.ac.il ([132.72.42.23]:7393 "EHLO
	indigo.cs.bgu.ac.il") by vger.kernel.org with ESMTP id S263459AbTJVKPH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Oct 2003 06:15:07 -0400
Date: Wed, 22 Oct 2003 12:16:02 +0200 (IST)
From: Nir Tzachar <tzachar@cs.bgu.ac.il>
To: Erik Andersen <andersen@codepoet.org>, <jaharkes@cs.cmu.edu>,
       <eric@sandall.us>
cc: linux-fsdevel@vger.kernel.org, <linux-kernel@vger.kernel.org>
Subject: Re: srfs - a new file system.
In-Reply-To: <20031022045708.GA5636@codepoet.org>
Message-ID: <Pine.LNX.4.44_heb2.09.0310221008580.22538-100000@nexus.cs.bgu.ac.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

first, id like to thank u guys for playing around with the idea.

now, i want to apologize if my explanation was not clear enough:
self stabilization (original idea by Dijkstra) - A self stabilizing system
is a system that can automatically recover following the occurrence of
( transient ) faults. The idea is to design a system which can be started
in an arbitrary state and still converge to a desired behavior.

Our file system behaves like this:
lets say you have several servers, with different file system trees on
them. If (and when ...) you connect these file systems with an srfs
framework, all servers will display the same file system tree, which is
somewhat of a union between them all.
if you wish to talk in coda terms, you can say all servers operated
disconnectedly, and then were connected at the same time. the conflict
resolving mechanism we use, is by majority.

We differ from coda in the sense we don't have a main server, which pushes
Volumes to sub-servers (im not sure what the coda terminology is... ), and
data is served in a load-balanced way. In Srfs, all the data resides on
all servers (hosts) and is replicated between them.
replication takes place at two levels: tree view (plus meta data) and the
actual data.
tree view - the tree view on all hosts is the same. an `ls` on a dir
            on any host will produce the same output.
data - data will be replicated to all hosts upon a successful write,
       and upon each access to a dirty file on each host.

all replication is lazy, and happens only on access to dirs / files
(and on successful writes - when the file is being closed.)

Thus, the following behavior can be achieved:
lets say you have 2N+1 hosts, all with coherent file system trees.
now, take N of them offline, change the tree, put those N back online,
and their tree will be the same as the other N+1 other hosts.

The main goal of the file system is self stabilization, over long periods
of time and long distances. you can use it as a SAN, or as a data farm,
using system like LinuxVirtualServer to balance the load between nodes.

cheers.

========================================================================
nir.




