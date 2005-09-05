Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932401AbVIESeI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932401AbVIESeI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 14:34:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVIESdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 14:33:45 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:38736 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932383AbVIESdh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 14:33:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=frVP3GJYd2zKsdzstRsDEdpLKio2YKEYiXfDjEmqNAYWMHFtGYy+CL1eqFYjBx6ok/4z7rvshabhKe5J/ZxYt65eLB8x95D1WdL4wELWXPp4nDPz+2oq6E49MvH8b0zmBhuUKENKUD3jI3oJ1S0j9GyNoTxChMKoZuz3OTVAw00=
Message-ID: <9a874849050905113369bae774@mail.gmail.com>
Date: Mon, 5 Sep 2005 20:33:34 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Chaskiel Grundman <cg2v@andrew.cmu.edu>
Subject: Re: (alpha) process_reloc_for_got confuses r_offset and r_addend
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0509051334440.8784@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.63.0509051334440.8784@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/5/05, Chaskiel Grundman <cg2v@andrew.cmu.edu> wrote:
> arch/alpha/kernel/module.c:process_reloc_for_got(), which figures out how
> big the .got section for a module should be, appears to be confusing
> r_offset (the file offset that the relocation needs to be applied to) with
> r_addend (the offset of the relocation's actual target address from the
> address of the relocation's symbol). Because of this, one .got entry is
> allocated for each relocation instead of one each unique symbol/addend.
> 
> In the module I am working with, this causes the .got section to be almost
> 10 times larger than it needs to be (75544 bytes instead of 7608 bytes).
> As the .got is accessed with global-pointer-relative instructions, it
> needs to be within the 64k gp "zone", and a 75544 byte .got clearly does
> not fit. The result of this is that relocation overflows are detected
> during module load and the load is aborted.
> 
> Does anyone see anything wrong with this analysis? I tested a patch that
> makes the obvious change to struct got_entry/process_reloc_for_got and it
> seems to work ok.
> 
> (Please cc me on replies. thanks)

Why not post the patch you made for review as well?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
