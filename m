Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286821AbSBCLZh>; Sun, 3 Feb 2002 06:25:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286825AbSBCLZ1>; Sun, 3 Feb 2002 06:25:27 -0500
Received: from smtpde02.sap-ag.de ([194.39.131.53]:27844 "EHLO
	smtpde02.sap-ag.de") by vger.kernel.org with ESMTP
	id <S286821AbSBCLZL>; Sun, 3 Feb 2002 06:25:11 -0500
From: Christoph Rohland <cr@sap.com>
To: "Andrew Tipton" <andrew@cadre5.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Tmpfs and loop device don't get along
In-Reply-To: <00fb01c1ab66$2fbc5490$6400a8c0@africa.cadre5.com>
Organisation: SAP LinuxLab
Date: Sat, 02 Feb 2002 10:48:14 +0100
In-Reply-To: <00fb01c1ab66$2fbc5490$6400a8c0@africa.cadre5.com> ("Andrew
 Tipton"'s message of "Fri, 1 Feb 2002 16:19:50 -0500")
Message-ID: <m3elk4p63l.fsf@linux.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Artificial
 Intelligence, i386-suse-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-SAP: out
X-SAP: out
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Fri, 1 Feb 2002, Andrew Tipton wrote:
> If I have an image (initrd.img for example) located on a tmpfs
> filesystem, when I attempt to mount it:
> 
> % mount -o loop /initrd.img /mnt
> ioctl: LOOP_SET_FD: Invalid argument

In the latest 2.4 sources you will find a file
Documentation/filesystems/tmpfs.txt which describes this problem.

> What is the best way to fix this short-term?  I could bypass the
> readpage check in loop_set_fd, or I could add a dummy readpage entry
> to the address_space_operations struct for tmpfs.  Would either of
> these have serious repercussions?

I do not see an easy and clean way so far. The check for readpage is
definitely needed. loop.c does rely on generic_file_{read,write} and
not on the files read and write operations. So IMHO the cleanest way
is to provide readpage et.al. in shmem.c and use generic_file_{read,write}
instead of specialized shmem_{read,write} functions. Unfortunately
this would mean a nontrivial change to the readpage semantics.

Greetings
		Christoph


