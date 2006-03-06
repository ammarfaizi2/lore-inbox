Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWCFQtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWCFQtd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 11:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751934AbWCFQtd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 11:49:33 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:51612 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751252AbWCFQtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 11:49:32 -0500
Date: Mon, 6 Mar 2006 22:18:25 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Suzanne Wood <suzannew@cs.pdx.edu>
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org, nickpiggin@yahoo.com.au,
       paulmck@us.ibm.com
Subject: Re: 2.6.16-rc regression: m68k CONFIG_RMW_INSNS=n compile broken
Message-ID: <20060306164825.GA5646@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <200603061613.k26GDfD0017783@wezen.cs.pdx.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200603061613.k26GDfD0017783@wezen.cs.pdx.edu>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2006 at 08:13:41AM -0800, Suzanne Wood wrote:
> Thank you very much.
>   > > struct file fastcall *fget_light(unsigned int fd, int *fput_needed)
>   > > {
>   > > 	struct file *file;
>   > > 	struct files_struct *files = current->files;
>   > > 
>   > > 	*fput_needed = 0;
>   > > 	if (likely((atomic_read(&files->count) == 1))) {
>   > > 		file = fcheck_files(files, fd);
>   > > 	} else {
> 
>   > This means that the fd table is not shared between threads. So,
>   > there can't be any race and no need to protect using
>   > rcu_read_lock()/rcu_read_unlock().
> 
> Then why call fcheck_files() with the rcu_dereference() which would flag 
> an automated check for the need to mark a read-side critical section?
> Would it make sense to introduce the function that doesn't?  The goal of
> keeping the kernel small is balanced with clarity.  The inconsistency of
> how fcheck_files() is used within a single function (fget_light()) was
> my opening question.

Because rcu_dereference() hurts only alpha and we don't care about
alpha :-)

Just kidding!

Good point about automated checkers. However, this isn't an
uncommon thing in multi-threaded programs - can't the checker 
rules be written to take into account sharing and non-sharing of 
the object in question ?

Thanks
Dipankar
