Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262074AbVBPQPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262074AbVBPQPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 11:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262066AbVBPQOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 11:14:11 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:19536 "EHLO
	MTVMIME03.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S262060AbVBPQLU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 11:11:20 -0500
Date: Wed, 16 Feb 2005 16:10:20 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: "Richard F. Rebel" <rrebel@whenu.com>
cc: Mauricio Lin <mauriciolin@gmail.com>, linux-kernel@vger.kernel.org,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Subject: Re: /proc/*/statm, exactly what does "shared" mean?
In-Reply-To: <1108567021.32711.529.camel@rebel.corp.whenu.com>
Message-ID: <Pine.LNX.4.61.0502161559360.18376@goblin.wat.veritas.com>
References: <1108161173.32711.41.camel@rebel.corp.whenu.com> 
    <Pine.LNX.4.61.0502121158190.18829@goblin.wat.veritas.com> 
    <1108219160.12693.184.camel@blue.obulous.org> 
    <Pine.LNX.4.61.0502121509170.19562@goblin.wat.veritas.com> 
    <3f250c710502160241222dce47@mail.gmail.com> 
    <Pine.LNX.4.61.0502161142240.17264@goblin.wat.veritas.com> 
    <3f250c7105021607022362013c@mail.gmail.com> 
    <1108567021.32711.529.camel@rebel.corp.whenu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2005, Richard F. Rebel wrote:
> 
> I have heard that this particular information, while very important to
> userland developers like me, is probably too expensive to keep track of
> for most users.
> 
> Perhaps a way to enable it for developers, whom are willing to spend the
> cpu cycles, and disable it for regular use would be a solution.
> 
> Would it be possible develop a solution allowing us to enable/disable
> this tracking via a sysctl call?

Possible, but I don't think a sysctl would make much sense here.

The most important thing is that any heavyweight information gathering
should not be happening by default, as a side-effect of something
frequently run.

So a lot of people would oppose putting back any such heavyweight
work into any of the /proc/<pid>/statm fields.  But if it goes into
a separate /proc/<pid>/whatever, not read by current tools, then
it's much less of a problem.

I'm still resistant, because I think if the information you're
interested in (how many private pages shared across forks) really
were of interest to many people, then someone would soon write a
top-like tool which kept sampling these values, and we'd be back to
the original situation.  Or if it's not of interest to many people,
then isn't it better off as an out-of-tree patch?

But I don't have a dogmatic position on it,
and trust others' judgement better than my own.

Hugh
