Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288951AbSAXTT5>; Thu, 24 Jan 2002 14:19:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288952AbSAXTTs>; Thu, 24 Jan 2002 14:19:48 -0500
Received: from pc-80-195-34-66-ed.blueyonder.co.uk ([80.195.34.66]:22662 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S288951AbSAXTTh>; Thu, 24 Jan 2002 14:19:37 -0500
Date: Thu, 24 Jan 2002 19:19:27 +0000
From: "Stephen C. Tweedie" <sct@redhat.com>
To: frode <frode@freenix.no>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Stephen Tweedie <sct@redhat.com>, ext3-users@redhat.com
Subject: Re: OOPS: kernel BUG at transaction.c:1857 on 2.4.17 while rm'ing 700mb file on ext3 partition.
Message-ID: <20020124191927.A9564@redhat.com>
In-Reply-To: <3C502E3A.9070909@freenix.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C502E3A.9070909@freenix.no>; from frode@freenix.no on Thu, Jan 24, 2002 at 04:54:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 24, 2002 at 04:54:34PM +0100, frode wrote:
> 
> I got the following error while rm'ing a 700mb file from an ext3 partition:
> 
> Assertion failure in journal_unmap_buffer() at transaction.c:1857:
> "transaction == journal->j_running_transaction"

Hmm --- this is not one I think I've ever seen before.

> >>EIP; c015ea1a <journal_unmap_buffer+fa/1b0>   <=====
> Trace; c015eb6e <journal_flushpage+9e/140>
> Trace; c0156ae2 <ext3_flushpage+22/30>
> Trace; c0125738 <do_flushpage+18/30>
> Trace; c0125762 <truncate_complete_page+12/50>
> Trace; c01258c6 <truncate_list_pages+126/190>
> Trace; c0125970 <truncate_inode_pages+40/70>
> Trace; c014485e <iput+ae/200>
> Trace; c0142e4c <d_delete+4c/70>
> Trace; c013c69c <vfs_unlink+13c/170>
> Trace; c013c778 <sys_unlink+a8/120>
> Trace; c0106e8a <system_call+32/38>

Well, that's a straight forward trace, and looks perfectly normal for
a delete operation.  The buffer_head is locked at this point, and the
transaction itself is pinned, so I can't see any way to have an
unrecognised transaction here.

> I use the 'mem=nopentium' option on the lilo prompt while booting, hoping to 
> reduce the rather large amount of oopses I have had recently, as I read 
> something about AMD Athlons and AGP causing troubles.

Those problems included AGP cache coherency problems, but I didn't see
any mention of other instabilities as a result.  Also,

> NVRM: loading NVIDIA NVdriver Kernel Module  1.0.2313  Tue Nov 27 12:01:24 PST 2001

with this driver loaded we really can't make any guarantees about your
system stability at all.  If you manage to eliminate other oopses and
still get the ext3 one, even without the NVidia driver loaded, then
there would be a much better change of debugging things, but right now
it sounds like a hardware problem.

Cheers,
 Stephen
