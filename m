Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272518AbRIOTTL>; Sat, 15 Sep 2001 15:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272519AbRIOTTB>; Sat, 15 Sep 2001 15:19:01 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:48710 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S272518AbRIOTSo>; Sat, 15 Sep 2001 15:18:44 -0400
To: Byron Stanoszek <gandalf@winds.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Strange /dev/loop behavior
In-Reply-To: <Pine.LNX.4.33.0109141505530.29038-100000@winds.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 15 Sep 2001 13:10:24 -0600
In-Reply-To: <Pine.LNX.4.33.0109141505530.29038-100000@winds.org>
Message-ID: <m13d5otgm7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Byron Stanoszek <gandalf@winds.org> writes:

> Is there any known method of copying/compressing the loopback-mounted file-
> system that always guarantees consistency after a sync, without requiring the
> fs to be unmounted first?

Mounting read-only and then syncing might do it.  Going directly to
the block device on 2.4.x is not supported when the filesystem is
mounted.  This is because the page cache is not coherent with the
block cache, and there are now plans to make this the case.   In
general this won't work anyway because some other program might 
be modifying your fs while you read the block device.

Eric
