Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbWIXUHh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbWIXUHh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 16:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWIXUHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 16:07:37 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:28902 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751373AbWIXUHg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 16:07:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=JPZIVy+B+3ytVFA+I424Tp9ZMT7QuNEktEc7KG5advVoyBT35hXiiOxScL/P3KQLB4ali3iMO5JFQlLA/buv4ZlcsKoJ3qkmAgbFkTAyIASKnxK9HsD0OceaYTAdhIAIROIshxkSBUrjR6p9076C6YjccwQrXtTxMynwTk9cDLs=
From: Denis Vlasenko <vda.linux@googlemail.com>
To: Stas Sergeev <stsp@aknet.ru>
Subject: Re: [patch] remove MNT_NOEXEC check for PROT_EXEC mmaps
Date: Sun, 24 Sep 2006 22:06:20 +0200
User-Agent: KMail/1.8.2
Cc: Ulrich Drepper <drepper@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Hugh Dickins <hugh@veritas.com>, Andrew Morton <akpm@osdl.org>,
       Linux kernel <linux-kernel@vger.kernel.org>
References: <45150CD7.4010708@aknet.ru> <4516B721.5070801@redhat.com> <4516C9D0.3080606@aknet.ru>
In-Reply-To: <4516C9D0.3080606@aknet.ru>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609242206.20446.vda.linux@googlemail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 24 September 2006 20:09, Stas Sergeev wrote:
> Ulrich Drepper wrote:
> > The consensus has been to add the same checks to mprotect.  They were
> > not left out intentionally.
> But how about the anonymous mmap with PROT_EXEC set?
> This is exactly what the malicious loader will do, it

If attacker has malicious loaders on the system,
the situation is already sort of hopeless.

Stas, I think noexec mounts are meant to prevent
_accidental_ execution of binaries/libs from that
filesystem. Think VFAT partition here, where all
files have execute bits set.

If user wants to execute binary blob from that fs
bad enough, he will do it. Maybe just by
copying file first to /tmp.

> won't do the shared (or private) file-backed mmap.
> So your technique doesn't restrict the malicious
> loaders, including the potential script loader you
> were referring to. It doesn't even make their life
> any harder. Only the properly-written programs suffer.
> Or, in case of ceasing to use noexec - the security.
--
vda
