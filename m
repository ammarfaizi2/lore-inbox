Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVF1Mus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVF1Mus (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 08:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVF1Mur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 08:50:47 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:14860 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S261315AbVF1Mug
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 08:50:36 -0400
To: "Al Boldi" <a1426z@gawab.com>
Cc: "'Marcelo Tosatti'" <marcelo.tosatti@cyclades.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Kswapd flaw
References: <200506281147.OAA20216@raad.intranet>
From: Nix <nix@esperi.org.uk>
X-Emacs: featuring the world's first municipal garbage collector!
Date: Tue, 28 Jun 2005 13:50:18 +0100
In-Reply-To: <200506281147.OAA20216@raad.intranet> (Al Boldi's message of
 "28 Jun 2005 12:49:42 +0100")
Message-ID: <87irzy63xx.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28 Jun 2005, Al Boldi yowled:
> Nix wrote:
>> On 28 Jun 2005, Al Boldi murmured woefully:
>>> Kswapd starts evicting processes to fullfil a malloc, when it should 
>>> just deny it because there is no swap.
>> I can't even tell what you're expecting. Surely not that no pages are ever
>> evicted or flushed; your memory would fill up with page cache in no time.
> 
> Please do flush anytime, and do it in sync during OOMs; but don't evict
> procs especially not RUNNING procs, that is overkill.

But processes (really, mapped text pages; really, read-only mapped pages
of all kinds) are loaded piecemeal in any case. Would you really like a
system where once something was faulted in, it could never leave? You'd
run out of memory *awfully* fast.

A system in which pages can be faulted in *and* out is consistent: one
in which they can only be faulted in is both inconsistent and very
deadlock-prone.

-- 
`I lost interest in "blade servers" when I found they didn't throw knives
 at people who weren't supposed to be in your machine room.'
    --- Anthony de Boer
