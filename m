Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132318AbRDJVlQ>; Tue, 10 Apr 2001 17:41:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132352AbRDJVlG>; Tue, 10 Apr 2001 17:41:06 -0400
Received: from penguin.e-mind.com ([195.223.140.120]:34130 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S132318AbRDJVk5>; Tue, 10 Apr 2001 17:40:57 -0400
Date: Tue, 10 Apr 2001 23:42:58 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Rajagopal Ananthanarayanan <ananth@sgi.com>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de, torvalds@transmeta.com
Subject: Re: BH_Req question
Message-ID: <20010410234258.B6030@athlon.random>
In-Reply-To: <3AD36912.1F9E0654@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3AD36912.1F9E0654@sgi.com>; from ananth@sgi.com on Tue, Apr 10, 2001 at 01:12:02PM -0700
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2001 at 01:12:02PM -0700, Rajagopal Ananthanarayanan wrote:
> 
> Hi,
> 
> It seems BH_Req is set on a buffer_head by submit_bh.
> What part of the code unsets this flag during normal
> operations? One path seems to be block_flushpage->unmap_buffer
> ->clear_bit(BH_Req), but IIRC block_flushpage is used only
> for truncates. There must be another path to unset BH_Req
> under normal memory pressure, or (more unambiguously) on IO completion.
> 
> So: in what ways can BH_Req be unset?

BH_Req is never unset until the buffer is destroyed (put back on the freelist).
BH_Req only says if such a buffer ever did any I/O yet or not. It is basically
only used to deal with I/O errors in sync_buffers().

> PS: In case why the question: I've got a system with tons of
> pages with buffers marked BH_Req, so try_to_free_buffers() bails
> out thinking that the buffer is busy ...

Either your debugging is wrong or you broke try_to_free_buffers because a
buffer with BH_Req must still be perfectly freeable.

Andrea
