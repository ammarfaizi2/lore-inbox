Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVCFA0n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVCFA0n (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 19:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVCFAXn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 19:23:43 -0500
Received: from smtp09.auna.com ([62.81.186.19]:52630 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id S261274AbVCFAT7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 19:19:59 -0500
Date: Sun, 06 Mar 2005 00:19:54 +0000
From: "J.A. Magallon" <jamagallon@able.es>
Subject: Re: Linux 2.6.11
To: Linus Torvalds <torvalds@osdl.org>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0503012356480.25732@ppc970.osdl.org> (from
	torvalds@osdl.org on Wed Mar  2 09:02:03 2005)
X-Mailer: Balsa 2.3.0
Message-Id: <1110068394l.11446l.1l@werewolf.able.es>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.02, Linus Torvalds wrote:
> 
> Ok,
>  there it is. Only small stuff lately  - as promised. Shortlog from -rc5 
> appended, nothing exciting there, mostly some fixes from various code 
> checkers (like fixed init sections, and some coverity tool finds).
> 
> So it's now _officially_ all bug-free.
> 

Mmm, conflicts in NFS ?

nfsd/nfsctl.c reads:

static int __init init_nfsd(void)
{
...
    if (proc_mkdir("fs/nfs", NULL)) {
        struct proc_dir_entry *entry;
        entry = create_proc_entry("fs/nfs/exports", 0, NULL);
        if (entry)
            entry->proc_fops =  &exports_operations;
    }
...

But nfs-utils 1.0.7 say that you can mount nfsd at /proc/fs/nfsd.
What 'exports' would kernel use ? Just duplicate info or a bug ?

TIA

--
J.A. Magallon <jamagallon()able!es>     \               Software is like sex:
werewolf!able!es                         \         It's better when it's free
Mandrakelinux release 10.2 (Cooker) for i586
Linux 2.6.11-jam1 (gcc 3.4.3 (Mandrakelinux 10.2 3.4.3-3mdk)) #1


