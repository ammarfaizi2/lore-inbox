Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422909AbWJPUih@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422909AbWJPUih (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 16:38:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422910AbWJPUih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 16:38:37 -0400
Received: from e31.co.us.ibm.com ([32.97.110.149]:24456 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1422909AbWJPUig
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 16:38:36 -0400
Subject: Re: AIO, DIO fsx tests failures on 2.6.19-rc1-mm1
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Zach Brown <zach.brown@oracle.com>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
In-Reply-To: <4533E7E2.6010506@oracle.com>
References: <1161013338.32606.2.camel@dyn9047017100.beaverton.ibm.com>
	 <4533C6A1.40203@oracle.com>
	 <1161021586.32606.6.camel@dyn9047017100.beaverton.ibm.com>
	 <4533E7E2.6010506@oracle.com>
Content-Type: text/plain
Date: Mon, 16 Oct 2006 13:38:19 -0700
Message-Id: <1161031099.32606.14.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-10-16 at 13:13 -0700, Zach Brown wrote:
> > Here is the easiest case to fix first :)
> > simple DIO wrote more than asked for :(
> > 
> > elm3b29:~ # /root/fsx-linux -N 10000 -o 128000 -r 2048 -w 4096 -Z -R -W
> > jnk
> > mapped writes DISABLED
> > truncating to largest ever: 0x32740
> > truncating to largest ever: 0x39212
> > truncating to largest ever: 0x3bae9
> > short write: 0x17000 bytes instead of 0x14000   <<<<<<
> 
> So the answer is that -rc1-mm1 doesn't quite have the most recent
> version of this patch.  Grab the final patch at the end of this post
> from Andrew:
> 
> 	http://lkml.org/lkml/2006/10/11/234
> 
> It fixes up a misunderstanding that came from
> generic_file_buffered_write()'s habit of adding its 'written' input into
> the amount of bytes it announces having written in its return value.
> 
> From mm-commits it looks like -mm2 will have the full patch.
> 

Hmm.. with that patch applied, I still have fsx failures.
This time read() returning -EINVAL. Are there any other fixes
missing in -mm ?

Thanks,
Badari

elm3b29:~ # /root/fsx-linux -N 10000 -o 128000 -r 2048 -w 4096 -Z -R -W
jnkI
mapped writes DISABLED
truncating to largest ever: 0x32740
truncating to largest ever: 0x39212
truncating to largest ever: 0x3bae9
truncating to largest ever: 0x3c1e3
truncating to largest ever: 0x3d1cd
truncating to largest ever: 0x3e8b8
truncating to largest ever: 0x3ed14
truncating to largest ever: 0x3f9c2
truncating to largest ever: 0x3ff9f
doread: read: Invalid argument
Segmentation fault


