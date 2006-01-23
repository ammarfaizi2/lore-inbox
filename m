Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWAWBYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWAWBYE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jan 2006 20:24:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWAWBYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jan 2006 20:24:04 -0500
Received: from wproxy.gmail.com ([64.233.184.193]:64659 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750885AbWAWBYD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jan 2006 20:24:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AoHsp4bdzJdvLBh60t2WLJ1Co+FYqsuNc1r2taPylrYdsi4U2C4qHG00kA3t32ISVxdseKBcALx4ndBzFQOygscG49KhSTLKVm6AK74BX/B/c8C/Zr/G9NkGgalRK+MGXElOTdFwUAhyfjimfIcDfOct/Mn+1ZXqgiNaBCQfnDo=
Message-ID: <787b0d920601221717v460283eclc72380ae541d7fef@mail.gmail.com>
Date: Sun, 22 Jan 2006 20:17:21 -0500
From: Albert Cahalan <acahalan@gmail.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: anon unions are cool
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <5AB1D65D-8F03-4CDF-9847-D75143EC0A9C@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <787b0d920601221636h7acbb891wd52b88e0aea75aaf@mail.gmail.com>
	 <5AB1D65D-8F03-4CDF-9847-D75143EC0A9C@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/22/06, Kyle Moffett <mrmacman_g4@mac.com> wrote:
> On Jan 22, 2006, at 19:36, Albert Cahalan wrote:
> > For example, suppose we wanted to rename a badly-named struct
> > member. If the struct is used all over the kernel, this becomes a
> > giant project with huge potential for patch conflicts.
>
> Actually, pure struct-member renames are not that common, however it
> _is_ common to add an accessor method due to upcoming locking/
> virtualization changes or similar.  For that case (Using a random
> recent example from the list.  This was decided to not be the best
> route for pid virtualization, but it's just an example):
>
> struct task_struct {
>         [...]
>
>         pid_t pid;
>
>         [...]
> };

This case is rather interesting. At more than one place I've worked,
I found people assuming that the kernel's "pid" was a pid, when in
fact it is a tid. (a "task ID" or "thread ID") The confusion probably
leads to kernel bugs. I've seen many bugs related to this, though I
can't be 100% sure that they don't all involve code that existed prior
to the tgid concept.
