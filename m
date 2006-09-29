Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161271AbWI2QxT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161271AbWI2QxT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 12:53:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161274AbWI2QxT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 12:53:19 -0400
Received: from mail.aknet.ru ([82.179.72.26]:1040 "EHLO mail.aknet.ru")
	by vger.kernel.org with ESMTP id S1161271AbWI2QxS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 12:53:18 -0400
Message-ID: <451D4FE1.5060106@aknet.ru>
Date: Fri, 29 Sep 2006 20:54:57 +0400
From: Stas Sergeev <stsp@aknet.ru>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: Hugh Dickins <hugh@veritas.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Ulrich Drepper <drepper@redhat.com>,
       Valdis.Kletnieks@vt.edu, Arjan van de Ven <arjan@infradead.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC MAP_PRIVATE mmaps
References: <45150CD7.4010708@aknet.ru>  <Pine.LNX.4.64.0609231555390.27012@blonde.wat.veritas.com>  <451555CB.5010006@aknet.ru>  <Pine.LNX.4.64.0609231647420.29557@blonde.wat.veritas.com>  <1159037913.24572.62.camel@localhost.localdomain>  <45162BE5.2020100@aknet.ru> <1159106032.11049.12.camel@localhost.localdomain> <45169C0C.5010001@aknet.ru> <4516A8E3.4020100@redhat.com> <4516B2C8.4050202@aknet.ru> <4516B721.5070801@redhat.com> <451ACE29.4080005@aknet.ru> <Pine.LNX.4.64.0609272045560.24191@blonde.wat.veritas.com> <451B5096.6020205@aknet.ru> <Pine.LNX.4.64.0609281707190.27484@blonde.wat.veritas.com>
In-Reply-To: <Pine.LNX.4.64.0609281707190.27484@blonde.wat.veritas.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Hugh Dickins wrote:
> The idea that loader
> should parse library pathname and /proc/mounts output, and thereby
> enforce "noexec" by itself, rather than relying on the kernel's
> mmap implementation to enforce it?
No. Yes, I agree with you that making the user-space app
to enforce the kernel restrictions is a silly solution.

Today I tried the following instead:
With the trivial 3-lines patch I made the loader to
be opened with fsuid=0. (as soon as opened, fsuid
returns back to original value).
That allowed me to control the use of ld.so with chmod.
Since, as I suppose, the users should not run the ld.so
directly, the "chmod 'go-x' ld.so" looks good. It looks
like that approach eliminates the noexec problem completely,
gives you a convinient and natural way to control the things
and costs only a 3 lines of code.
Or is it just another silly idea, or does it open a security hole?

> But again and again I have to point out, just
> because "noexec" has proved inconvenient to you here
Unfortunately, the distributors were caught too.

> There might be a loader which specifically seeks to avoid the
> mmap check, by mmapping without PROT_EXEC then mprotecting with
> PROT_EXEC.  Whether that's an argument for or against now adding
> the test to mprotect depends on your standpoint.
That actually made a lot of sense to me. You were continuously
pointing me to the real root of the problem (ld.so), but I was
distracted by the security claims of other's and thought the
security was the primary goal of these checks. If you think there
should be an official way of bypassing these checks, then I now
can clearly see where you are coming from. Be these really a
security checks, there would be no official way of bypassing them,
so they are obviously not. Now I completely agree that mprotect
should not be affected.
I actually seen a discussion about using an mprotect for the
programs that are currently break on debian, but the upstream
maintainer was worried that one day the mprotect may be restricted
too. Now I think he can change his mind, so at least for that,
this whole discussion was not useless. :)

> But I think I've already said all I have to say on this.
I understand, thanks anyway. As I said, you were the only one
trying to direct the discussion to the right place, sorry for
not seeing this for so long...

