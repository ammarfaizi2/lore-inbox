Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312194AbSDCV2w>; Wed, 3 Apr 2002 16:28:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312235AbSDCV2n>; Wed, 3 Apr 2002 16:28:43 -0500
Received: from brooklyn-bridge.emea.veritas.com ([62.172.234.2]:47964 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id <S312194AbSDCV2Y>;
	Wed, 3 Apr 2002 16:28:24 -0500
Date: Wed, 3 Apr 2002 22:26:34 +0100 (BST)
From: Tigran Aivazian <tigran@aivazian.fsnet.co.uk>
X-X-Sender: <tigran@einstein.homenet>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Andrea Arcangeli <andrea@suse.de>, Arjan van de Ven <arjanv@redhat.com>,
        Hugh Dickins <hugh@veritas.com>, Ingo Molnar <mingo@redhat.com>,
        Stelian Pop <stelian.pop@fr.alcove.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <E16ssCe-0004Xj-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0204032207170.1612-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Apr 2002, Alan Cox wrote:
> eg I'd love to be able to do
> 	EXPORT_SYMBOL_TO(sym, "i2o*.o");
>
> for the i2o code and know that nobody is going to try and use those routines
> for non i2o stuff thinking "that looks handy".

yes, I did imply two parts: serious (the "to some modules only") and
joking (the one where kernel decides whether a module is "worthy" based on
its license). Arjan also pointed out in a private email that such
interface would be helpful in splitting things into multiple modules.

>
> I'm not sure if its that managable, _INTERNAL works for a lot of things from
> my point of view. Knowing what is and isnt claimed to be an interface helps
> so much. Complicating it seems to have few extra payoffs
>

I agree. The only thing where I disagree is that I think EXPORT_SYMBOL_GPL
is not really useful if understood literally, but if it is understood as
EXPORT_SYMBOL_INTERNAL then it should be called EXPORT_SYMBOL_INTERNAL.
I.e. not _INTERNAL + _GPL but only _INTERNAL.

Why is EXPORT_SYMBOL_GPL not so useful?
Because it relies too much on human emotions rather than logic and reason.
Even reason and logic are vanity and of no real value, how much less are
emotions and feelings... Worse than that, it relies on arbitrary temporal
(and temporary) definitions of what is "added functionality" and what can
binary modules be allowed to use "because it was already there". This
is the trend that I am seeing and I feel such trend is not to the benefit
of Linux. Ok, granted, there must be some alleys and exploits that the
commercial vendors can take advantage of and we should be careful about it
but I still believe that exporting or not exporting symbols based on
_license_ is fundamentally wrong.

Exporting based on some sort of subsystem registration (like dri core only
to dri drivers etc) would be a nice idea. But until that is implemented
(and really needed) a simple boundary provided by EXPORT_SYMBOL and
EXPORT_SYMBOL_INTERNAL (if _GPL gets renamed to it) is, imho, sufficient.

Regards,
Tigran






