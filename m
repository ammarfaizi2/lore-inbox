Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUAFMos (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jan 2004 07:44:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262123AbUAFMor
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jan 2004 07:44:47 -0500
Received: from paja.kn.vutbr.cz ([147.229.191.135]:41746 "EHLO
	paja.kn.vutbr.cz") by vger.kernel.org with ESMTP id S262009AbUAFMoq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jan 2004 07:44:46 -0500
Message-ID: <3FFAADB9.6030801@stud.feec.vutbr.cz>
Date: Tue, 06 Jan 2004 13:44:41 +0100
From: Michal Schmidt <xschmi00@stud.feec.vutbr.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040104
X-Accept-Language: cs, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.1-rc1 affected?
References: <1aFW7-39l-11@gated-at.bofh.it> <1aG5G-3mf-21@gated-at.bofh.it>
In-Reply-To: <1aG5G-3mf-21@gated-at.bofh.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> I'd actually personally prefer a stronger test than the one in 2.4.24, and 
> my personal preference would be for just disallowing the degenerate cases
> entirely.  I don't see a "mremap away" as being a valid thing to do, since 
> if that is what you want, why not just do a "munmap()"?
> 

I belive your fix isn't correct.
Should that test be:
   if(!old_len || !new_len)
        goto out;
?

The difference is when old_len!=0 and new_len==0:
With the fix that Marcelo merged, mremap does nothing and returns -1.
With your fix, mremap does do_munmap and then returns -1.

Michal Schmidt
