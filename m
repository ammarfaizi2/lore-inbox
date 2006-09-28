Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751660AbWI1Qmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbWI1Qmg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751930AbWI1Qmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:42:36 -0400
Received: from excu-mxob-2.symantec.com ([198.6.49.23]:50649 "EHLO
	excu-mxob-2.symantec.com") by vger.kernel.org with ESMTP
	id S1751660AbWI1Qmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:42:35 -0400
Date: Thu, 28 Sep 2006 17:42:08 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@blonde.wat.veritas.com
To: Stas Sergeev <stsp@aknet.ru>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ulrich Drepper <drepper@redhat.com>,
       Valdis.Kletnieks@vt.edu, Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC MAP_PRIVATE mmaps
In-Reply-To: <451B5096.6020205@aknet.ru>
Message-ID: <Pine.LNX.4.64.0609281707190.27484@blonde.wat.veritas.com>
References: <45150CD7.4010708@aknet.ru>  <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>
  <451555CB.5010006@aknet.ru>  <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>
  <1159037913.24572.62.camel@localhost.localdomain>  <45162BE5.2020100@aknet.ru>
 <1159106032.11049.12.camel@localhost.localdomain> <45169C0C.5010001@aknet.ru>
 <4516A8E3.4020100@redhat.com> <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com>
 <451ACE29.4080005@aknet.ru> <Pine.LNX.4.64.0609272045560.24191@blonde.wat.veritas.com>
 <451B5096.6020205@aknet.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 28 Sep 2006 16:42:01.0258 (UTC) FILETIME=[0581B0A0:01C6E31D]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sep 2006, Stas Sergeev wrote:
> Hugh Dickins wrote:
> > since executables are typically mapped MAP_PRIVATE, I suspect
> > your patch will simply break mmap's intended MNT_NOEXEC check.
> The one with ld.so you mean? But its a user-space issue,
> I haven't seen anyone claiming the opposite (and you even
> explicitly confirmed it is).

I'm not sure what you're referring to there.  The idea that loader
should parse library pathname and /proc/mounts output, and thereby
enforce "noexec" by itself, rather than relying on the kernel's
mmap implementation to enforce it?  Well, I'm glad I won't need
to implement that, since the kernel's mmap _is_ doing the check,
and I still see no reason to change that after all this time.

> 
> > I think you need to face up to the fact that "noexec"
> > doesn't suit your mount, and just leave it at that.
> But noone have answered this question:
> Which configuration is more secure - the one where all
> the user-writable fs are mounted with "noexec" (in old
> sense of noexec), or the one without "noexec" at all
> because I should no longer use it here and there (actually,
> everywhere)?

I'll leave comparisons of security to those who know what they're
talking about.  But again and again I have to point out, just
because "noexec" has proved inconvenient to you here, does not
imply that it's useless everywhere, and does not imply that
the kernel should change its behaviour to suit you.

> 
> > But I do concede that I'm reluctant to present that patch Alan
> > encouraged, adding a matching MNT_NOEXEC check to mprotect: it
> > would be consistent, and I do like consistency, but in this case
> > fear that change in behaviour may cause new userspace breakage.
> I can't think of a single real-life example where it will
> break something over whatever is broken already by the mmap
> check. But I am not encouraging such a change of course.

There might be a loader which specifically seeks to avoid the
mmap check, by mmapping without PROT_EXEC then mprotecting with
PROT_EXEC.  Whether that's an argument for or against now adding
the test to mprotect depends on your standpoint.

But I think I've already said all I have to say on this.

Hugh
