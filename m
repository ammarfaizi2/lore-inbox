Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSLMRZD>; Fri, 13 Dec 2002 12:25:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261581AbSLMRZD>; Fri, 13 Dec 2002 12:25:03 -0500
Received: from dhcp-66-212-193-131.myeastern.com ([66.212.193.131]:62671 "EHLO
	mail.and.org") by vger.kernel.org with ESMTP id <S261518AbSLMRZC>;
	Fri, 13 Dec 2002 12:25:02 -0500
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Symlink indirection
References: <3DF9F780.1070300@walrond.org>
	<mailman.1039792562.8768.linux-kernel2news@redhat.com>
	<200212131616.gBDGGH302861@devserv.devel.redhat.com>
From: James Antill <james.antill@redhat.com>
Content-Type: text/plain; charset=US-ASCII
Date: 13 Dec 2002 12:32:50 -0500
In-Reply-To: <200212131616.gBDGGH302861@devserv.devel.redhat.com>
Message-ID: <m3y96t964d.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Honest Recruiter)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pete Zaitcev <zaitcev@redhat.com> writes:

> >> Is the number of allowed levels of symlink indirection (if that is the
> >> right phrase; I mean symlink -> symlink -> ... -> file) dependant on the
> >> kernel, or libc ? Where is it defined, and can it be changed?
> > 
> > fs/namei.c
> > 
> >  if (current->link_count >= 5)
> > 
> > change to a higher value.
> 
> This is vey, very misleading statement. The counter mentioned above
> is there to protect stacks from overflow, but our symlink resolution
> is largely non-recursive, and certainly not in case of a tail
> recursion within the same directory.

 tail recursion is a bad name, as that implies the last element of the
path can go beyond the above value. A better way is to say that each
element of the path can have at most link_count and the total path can
have at most total_link_count symlinks (or that nested symlinks are
limited to a small number, in Al's words).

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
