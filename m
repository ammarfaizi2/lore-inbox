Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316490AbSFPSIf>; Sun, 16 Jun 2002 14:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316491AbSFPSIe>; Sun, 16 Jun 2002 14:08:34 -0400
Received: from [202.131.151.113] ([202.131.151.113]:26870 "HELO sandstorm.net")
	by vger.kernel.org with SMTP id <S316490AbSFPSId>;
	Sun, 16 Jun 2002 14:08:33 -0400
Date: Fri, 14 Jun 2002 23:13:53 +0530
From: Abhishek Nayani <abhi@kernelnewbies.org>
To: linux-kernel@vger.kernel.org
Subject: Doubt (bug?) in dup_mmap()
Message-ID: <20020614174353.GA3792@SandStorm.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

	In the function dup_mmap() in kernel/fork.c, 

	file = tmp->vm_file;
	if (file) {
		struct inode *inode = file->f_dentry->d_inode;
		get_file(file);
		if(tmp->vm_flags & VM_DENYWRITE)
			atomic_dec(&inode->i_writecount);

	After this piece of code, shouldn't there be :
	
		else
			atomic_inc(&inode->i_writecount);

	as this is a read-write mapping ?
	
				
					Bye,
						Abhi.
	
Linux Kernel Documentation Project
http://freesoftware.fsf.org/lkdp

	
--------------------------------------------------------------------------------
Those who cannot remember the past are condemned to repeat it - George Santayana
--------------------------------------------------------------------------------
                          Home Page: http://www.abhi.tk
-----BEGIN GEEK CODE BLOCK------------------------------------------------------
GCS d+ s:- a-- C+++ UL P+ L+++ E- W++ N+ o K- w--- O-- M- V- PS PE Y PGP 
t+ 5 X+ R- tv+ b+++ DI+ D G e++ h! !r y- 
------END GEEK CODE BLOCK-------------------------------------------------------

