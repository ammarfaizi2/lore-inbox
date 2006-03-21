Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751704AbWCUUK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbWCUUK2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 15:10:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932145AbWCUUK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 15:10:27 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:65180 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1751704AbWCUUK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 15:10:26 -0500
Date: Tue, 21 Mar 2006 21:05:13 +0100
From: Pavel Machek <pavel@suse.cz>
To: Xin Zhao <uszhaoxin@gmail.com>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Al Viro <viro@ftp.linux.org.uk>,
       mingz@ele.uri.edu, mikado4vn@gmail.com,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org
Subject: Re: Question regarding to store file system metadata in database
Message-ID: <20060321200513.GC3931@elf.ucw.cz>
References: <4ae3c140603182048k55d06d87ufc0b9f0548574090@mail.gmail.com> <441CE71E.5090503@gmail.com> <4ae3c140603190948s4fcd135er370a15003a0143a8@mail.gmail.com> <1142791121.31358.21.camel@localhost.localdomain> <4ae3c140603191011r7b68f4aale01238202656d122@mail.gmail.com> <1142792787.31358.28.camel@localhost.localdomain> <4ae3c140603191050k3bf7e960q9b35fe098e2fbe35@mail.gmail.com> <20060319194723.GA27946@ftp.linux.org.uk> <20060320130950.GA9334@thunk.org> <4ae3c140603200713m24a5af0agd891a709286deb47@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ae3c140603200713m24a5af0agd891a709286deb47@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Second, I might want to give the background on which we are
> considering the possibility of storing metadata in database. We are
> currently developing a file system that allows multiple virtual
> machines to share base software environment. With our current design,
> a new VM can be deployed in several seconds by inheriting the file
> system of an existing VM. If a VM is to modify a shared file, the file
> system will do copy-on-write to gernerate a private copy for this VM.
> Thus, there could be multiple physical copies for a virtual pathname.
> Even more complicated, a physical copy could be shared by arbitrary
> subset of VMs.  Now let's consider how to support this using regular
> file system. You  can treat VMs as clients or users of a standard
> linux.  Consider the following scenario: VM2 inherit VM1's file
> system. The physical copy for virtual file F is F.1. Then, it modified
> file F and get its private copy F.2. Now VM3 inherit VM2's file
> system. The inherit graph is as follow:
> VM1-->VM2-->VM3
> 
> Now VM3 wants to access virtual file F. It has to determine the right 
> physical copy. The right answer is F.2. But in the file system, we
> have F.1 and F.2. So some mapping mechanism must be devised. No matter
> how we manipulate the pathname of physical copies, several disk
> accesses seem to be required for a mapping operation. That is the
> reason we are considering database to store metadata.

Hardlinks? ext3cow (google it)?
								Pavel

-- 
Picture of sleeping (Linux) penguin wanted...
