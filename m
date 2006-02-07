Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965032AbWBGLnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965032AbWBGLnj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 06:43:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965030AbWBGLni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 06:43:38 -0500
Received: from lucidpixels.com ([66.45.37.187]:45545 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S965033AbWBGLni (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 06:43:38 -0500
Date: Tue, 7 Feb 2006 06:43:36 -0500 (EST)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: linux-kernel@vger.kernel.org
cc: taroon-list@vger.kernel.org, redhat-list@redhat.com
Subject: Kernel 2.4.21 or RHEL AS3 Bug under Taroon?
Message-ID: <Pine.LNX.4.64.0602070608470.23943@p34>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a quad-cpu server running RHEL AS 3, Taroon that acts as an NFS 
server for some other machines.

It had a 390 uptime when the problem occured.

Essentially, the directory paths it serves out stopped working, attempting 
to mount the directory on two client boxes results in:

box1# mount rhelas3_box:/share1 /mnt/share1
mount: RPC: Program not registered

box2# mount rhelas3_box:/share2 /mnt/share2
mount: RPC: Program not registered

My guess as to what happened is portmap died on the server and then the 
rpc commands could not be established between the server and the clients.

The options used for the mount are as follows:
rhelas3_box:/share1  /mnt/share1  nfs 
ro,tcp,nfsvers=3,rsize=8192,timeo=11,hard,intr,defaults
rhelas3_box:/share2  /mnt/share2  nfs 
ro,tcp,nfsvers=3,rsize=8192,timeo=11,hard,intr,defaults

On the server in /etc/exports, the shares are below:
/mnt/share1  1.2.3.4(rw,no_root_squash,sync)
/mnt/share2  1.2.3.4(rw,no_root_squash,sync)

Is this more of a kernel issue or specifically the portmap daemon?  I have 
not seen this error in the past where NFS mounts randomly die, disappear 
or fail to work.

Other than checking the logs during the time of the failure, what is the 
best way to begin troubleshooting this issue?

Thanks,

Justin.


