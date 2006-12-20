Return-Path: <linux-kernel-owner+w=401wt.eu-S964951AbWLTJgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964951AbWLTJgr (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 04:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964964AbWLTJgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 04:36:46 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:49621 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951AbWLTJgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 04:36:45 -0500
X-Greylist: delayed 1991 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 04:36:45 EST
Date: Wed, 20 Dec 2006 10:03:33 +0100 (CET)
From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Subject: Finding hardlinks
Message-ID: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
X-Personality-Disorder: Schizoid
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I've came across this problem: how can a userspace program (such as for 
example "cp -a") tell that two files form a hardlink? Comparing inode 
number will break on filesystems that can have more than 2^32 files (NFS3, 
OCFS, SpadFS; kernel developers already implemented iget5_locked for the 
case of colliding inode numbers). Other possibilities:

--- compare not only ino, but all stat entries and make sure that
 	i_nlink > 1?
 	--- is not 100% reliable either, only lowers failure probability
--- create a hardlink and watch if i_nlink is increased on both files?
 	--- doesn't work on read-only filesystems
--- compare file content?
 	--- "cp -a" won't then corrupt data at least, but will create
 	hardlinks where they shouldn't be.

Is there some reliable way how should "cp -a" command determine that? 
Finding in kernel whether two dentries point to the same inode is trivial 
but I am not sure how to let userspace know ... am I missing something?

Mikulas
