Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273371AbRI0Pl0>; Thu, 27 Sep 2001 11:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273376AbRI0PlR>; Thu, 27 Sep 2001 11:41:17 -0400
Received: from dict.and.org ([63.113.167.10]:3493 "EHLO mail.and.org")
	by vger.kernel.org with ESMTP id <S273371AbRI0PlF>;
	Thu, 27 Sep 2001 11:41:05 -0400
To: Andreas Schwab <schwab@suse.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.10-pre11 -- __builtin_expect
In-Reply-To: <20010918031813.57E1062ABC@oscar.casa.dyndns.org.suse.lists.linux.kernel>
	<E15jBLy-0008UF-00@the-village.bc.nu.suse.lists.linux.kernel>
	<9o6j9l$461$1@cesium.transmeta.com.suse.lists.linux.kernel>
	<oup4rq0bwww.fsf_-_@pigdrop.muc.suse.de>
	<jeelp4rbtf.fsf@sykes.suse.de>
	<20010918143827.A16003@gruyere.muc.suse.de>
	<nn3d59qzho.fsf@code.and.org> <jezo7gu78f.fsf@sykes.suse.de>
From: James Antill <james@and.org>
Content-Type: text/plain; charset=US-ASCII
Date: 27 Sep 2001 11:41:22 -0400
In-Reply-To: <jezo7gu78f.fsf@sykes.suse.de>
Message-ID: <nnvgi4prod.fsf@code.and.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Academic Rigor)
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Schwab <schwab@suse.de> writes:

> James Antill <james@and.org> writes:
> 
> |>  unlikely() also needs to be...
> |> 
> |> #define unlikely(x)  __builtin_expect(!(x), 1) 
> |> 
> |> ...or...
> |> 
> |> #define unlikely(x)  __builtin_expect(!!(x), 0) 
> 
> This is not needed, since only 0 is the likely value and !! does not
> change that.

 Yes it is, given the code...

struct blah *ptr = NULL;

if (unlikely(ptr))

...you'll get a warning from gcc because you are implicitly converting
from a pointer to a long.

-- 
# James Antill -- james@and.org
:0:
* ^From: .*james@and\.org
/dev/null
