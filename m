Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261274AbVGYW7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVGYW7f (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 18:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261262AbVGYW7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 18:59:22 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:9609 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261180AbVGYW7T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 18:59:19 -0400
Message-Id: <20050725224417.501066000@localhost>
Date: Mon, 25 Jul 2005 15:44:17 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: akpm@osdl.org, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Avantika Mathur <mathurav@us.ibm.com>, Mike Waychison <mike@waychison.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

, miklos@szeredi.hu, Janak Desai <janak@us.ibm.com>, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/7] shared subtree

Hi Andrew/Al Viro,

	Enclosing a final set of well tested patches that implement
	Al Viro's shared subtree proposal.

	These patches provide the ability to mark a mount tree as
	shared/private/slave/unclone, along with the ability to play with these
	trees with operations like bind/rbind/move/pivot_root/namespace-clone
	etc.

	I believe this powerful feature can help build features like
	per-user namespace.  Couple of projects may benefit from
	shared subtrees.
	1) automounter for the ability to automount across namespaces.
	2) SeLinux for implementing polyinstantiated trees.
	3) MVFS for providing versioning file system.
	4) FUSE for per-user namespaces?
	
	Thanks to Avantika for developing about 100+ test cases that tests
	various combintation of private/shared/slave/unclonable trees. All
	these tests have passed. I feel pretty confident about the stability of
	the code.
	
	The patches have been broken into 7 units, for ease of review.  I
	realize that patch-3 'rbind.patch' is a bit heavier than all the other
	patches. The reason being, most of the shared-subtree functionality 
	gets manifestated during bind/rbind operation.

	Couple of work items to be done are:
	1. modify the mount command to support this feature
		eg:  mount --make-shared /tmp
	2. a tool that can help visualize the propogation tree, maybe
		support in /proc?
	3. some documentation on how to use all this functionality.

	Please consider the patches for inclusion in your tree.

	The footprint of this code is pretty small in the normal code path
	where shared-subtree functionality is not used.

	Any suggestions/comments to improve the code is welcome.

Thanks,
RP
