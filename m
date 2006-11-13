Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753820AbWKMCQc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820AbWKMCQc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Nov 2006 21:16:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753821AbWKMCQc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Nov 2006 21:16:32 -0500
Received: from wx-out-0506.google.com ([66.249.82.227]:6940 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1753820AbWKMCQb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Nov 2006 21:16:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RyWwwoCvNAGNeCCJWf9U9T+HF1Ke2Rc3Kb0EHQPbY9mxXAaR5/T1THTE/63iKnW5lO47h/VIfcn4TybWvOkZrVy012upGt5mBdMzXDSEyQiDTyf4jtyzyF0f+TQUh8ytu8GueWNI0zsQk4QU47EGEq54aLiDNymZO68oGYr8P3E=
Message-ID: <aec7e5c30611121816s2087c455o6dea419d13de5615@mail.gmail.com>
Date: Mon, 13 Nov 2006 11:16:19 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Jeremy Fitzhardinge" <jeremy@goop.org>
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
Cc: "David Miller" <davem@davemloft.net>, horms@verge.net.au,
       ebiederm@xmission.com, magnus@valinux.co.jp,
       linux-kernel@vger.kernel.org, vgoyal@in.ibm.com, ak@muc.de,
       fastboot@lists.osdl.org, anderson@redhat.com
In-Reply-To: <4555256F.2050006@goop.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45550D2F.2070004@goop.org>
	 <20061110.153930.23011358.davem@davemloft.net>
	 <455518C6.8000905@goop.org>
	 <20061110.164349.35665774.davem@davemloft.net>
	 <4555256F.2050006@goop.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/11/06, Jeremy Fitzhardinge <jeremy@goop.org> wrote:
> David Miller wrote:
> > We should be OK with the elf note header since n_namesz, n_descsz, and
> > n_type are 32-bit types even on Elf64.  But for the contents embedded
> > in the note, I am not convinced that there are no potential issues
>
> PT_NOTE segments are not generally mmaped directly, nor are they
> generally very large.  There should be no problem for a note-using
> program to load/copy the notes into memory with appropriate alignment.
> I guess a lot of the contents of core elf notes are register dumps and
> so on, so debuggers must be already dealing with this.

Someone apparently thought that 32-bit alignment was a good thing and
put it in the spec for the 32-bit format. You argue that most programs
copy instead of mmap() which sounds correct, but if someone wants to
mmap() then our current 32-bit aligned 64-bit elf note implementation
is broken. Which may or may not be ok.

So why was 32-bit alignment put in the 32-bit spec? I suspect the
reason was to support direct access of note contents. Either using
mmap() or read() and direct access. Remeber that the notes could
contain anything which may require properly aligned data for direct
access. I think this was the reason the word size alignment was put in
the spec for in the first place.

Thanks,

/ magnus
