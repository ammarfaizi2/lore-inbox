Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261277AbVARLkM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVARLkM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 06:40:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVARLkM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 06:40:12 -0500
Received: from mail4.hitachi.co.jp ([133.145.228.5]:47536 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S261277AbVARLkC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 06:40:02 -0500
Message-ID: <41ECF0B6.30106@sdl.hitachi.co.jp>
Date: Tue, 18 Jan 2005 20:19:18 +0900
From: Masami Hiramatsu <hiramatu@sdl.hitachi.co.jp>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: ja, en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       lkst-develop@lists.sourceforge.net
Subject: Re: 2.6.11-rc1-mm1
References: <20050114002352.5a038710.akpm@osdl.org> <m1zmzcpfca.fsf@muc.de>
In-Reply-To: <m1zmzcpfca.fsf@muc.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by maila.sdl.hitachi.co.jp id j0IBJ887024679
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I’m a developer of yet another kernel tracer, LKST. I and co-developers 
are very glad to hear that LTT was merged into -mm tree and to talk 
about the kernel tracer on this ML. Because we think that the kernel 
event tracer is useful to debug Linux systems, and to improve the kernel 
reliability.

Andi Kleen wrote:
> Andrew Morton <akpm@osdl.org> writes:
> 
>>- Added the Linux Trace Toolkit (and hence relayfs).  Mainly because I
>>  haven't yet taken as close a look at LTT as I should have.  Probably neither
>>  have you.
> 
> 
> I think it would be better to have a standard set of kprobes instead
> of all the ugly LTT hooks. kprobes could then log to relayfs or another
> fast logging mechanism.

I agree.
I’m interested in kprobes. Currently, LKST can switch off and on each 
hook. But, even if a hook was disabled, there is a little overhead-time 
(one conditional-jump instruction should be executed). I think 
kprobes-based hooks can completely remove this overhead-time. Moreover, 
kprobes-based hooks can be inserted dynamically into the code-point 
specified by user. This feature is greatly useful for debugging. So, I 
have an idea to renew LKST to kprobes-based hooks.
Also, I’m developing a prototype implementation.


> The problem relayfs has IMHO is that it is too complicated. It 
> seems to either suffer from a overfull specification or second system
> effect. There are lots of different options to do everything,
> instead of a nice simple fast path that does one thing efficiently.
> IMHO before merging it should go through a diet and only keep
> the paths that are actually needed and dropping a lot of the current
> baggage.
> 
> Preferably that would be only the fastest options (extremly simple
> per CPU buffer with inlined fast path that drop data on buffer overflow), 
> with leaving out anything more complicated. My ideal is something
> like the old SGI ktrace which was an extremly simple mechanism
> to do lockless per CPU logging of binary data efficiently and
> reading that from a user daemon.

LKST’s logging buffer is (much) simpler than relayfs. It is just the 
linked-perCPU-buffer.

If you are interested in this, please try LKST.


-- 
Masami HIRAMATSU

Hitachi, Ltd., Systems Development Laboratory
E-mail: hiramatu@sdl.hitachi.co.jp
