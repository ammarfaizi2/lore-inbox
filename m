Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266295AbUITLrB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266295AbUITLrB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 07:47:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266310AbUITLrB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 07:47:01 -0400
Received: from holomorphy.com ([207.189.100.168]:37309 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266295AbUITLqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 07:46:55 -0400
Date: Mon, 20 Sep 2004 04:46:16 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] why switch_exec_pids() changes thread group leader pid?
Message-ID: <20040920114616.GT9106@holomorphy.com>
References: <414EBF2B.5090909@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414EBF2B.5090909@sw.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 03:29:47PM +0400, Kirill Korotaev wrote:
> I've been looking through switch_exec_pids() function and found that it 
> changes thread group leader PID/TGID. Is it really a good idea to change 
>  pid of the process during it's lifetime? I could understand if it was 
> happenning in the context of that process, but pid changes everytime a 
> thread calls do_execve().
> As far as I can see, leader doesn't have to do any of detach_pid()'s. 
> Instead thread should change it's PID/TGID.

It's only done when a thread that is not a thread group leader
execve()'s. This is actually pretty rare and confined to threaded
applications, so it should be almost never called.


-- wli
