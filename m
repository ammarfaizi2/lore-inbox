Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266362AbUITMYt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266362AbUITMYt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 08:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266366AbUITMYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 08:24:49 -0400
Received: from holomorphy.com ([207.189.100.168]:50621 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266362AbUITMYr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 08:24:47 -0400
Date: Mon, 20 Sep 2004 05:24:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [Q] why switch_exec_pids() changes thread group leader pid?
Message-ID: <20040920122410.GU9106@holomorphy.com>
References: <414EBF2B.5090909@sw.ru> <20040920114616.GT9106@holomorphy.com> <414EC805.8070105@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414EC805.8070105@sw.ru>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 20, 2004 at 03:29:47PM +0400, Kirill Korotaev wrote:
>>> I've been looking through switch_exec_pids() function and found that it 
>>> changes thread group leader PID/TGID. Is it really a good idea to change 
>>> pid of the process during it's lifetime? I could understand if it was 
>>> happenning in the context of that process, but pid changes everytime a 
>>> thread calls do_execve().
>>> As far as I can see, leader doesn't have to do any of detach_pid()'s. 
>>> Instead thread should change it's PID/TGID.

William Lee Irwin III wrote:
>> It's only done when a thread that is not a thread group leader
>> execve()'s. This is actually pretty rare and confined to threaded
>> applications, so it should be almost never called.

On Mon, Sep 20, 2004 at 04:07:33PM +0400, Kirill Korotaev wrote:
> Heh, rare doesn't mean correct, yeah? :)

The semantic it implements is that the thread calling execve() kills
all other threads of the process and assumes the identity of the thread
group leader. It should be clear that when the thread were already the
group leader, such as it is for unthreaded processes, one need only
kill the other threads, of which there are none for unthreaded
processes. I'm largely not involved with the implementation of POSIX
threading semantics, so there is some limit regarding the amount of
detail in which I can go on about it without resorting to research.

Ingo Molnar, Roland McGrath, and Ulrich Drepper will likely have more
information if you should care to question so deeply as to ask e.g.
whether this is actually faithful to whatever standard they followed.


-- wli
