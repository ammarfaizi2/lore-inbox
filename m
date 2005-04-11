Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbVDKUre@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbVDKUre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 16:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVDKUre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 16:47:34 -0400
Received: from fire.osdl.org ([65.172.181.4]:47792 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261924AbVDKUrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 16:47:25 -0400
Date: Mon, 11 Apr 2005 13:46:51 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Stephen C. Tweedie" <sct@redhat.com>
Cc: hifumi.hisashi@lab.ntt.co.jp, marcelo.tosatti@cyclades.com,
       neilb@cse.unsw.edu.au, vherva@viasys.com, linux-kernel@vger.kernel.org,
       sct@redhat.com
Subject: Re: Linux 2.4.30-rc3 md/ext3 problems (ext3 gurus : please check)
Message-Id: <20050411134651.719e3434.akpm@osdl.org>
In-Reply-To: <1113224149.2164.78.camel@sisko.sctweedie.blueyonder.co.uk>
References: <20050326162801.GA20729@logos.cnet>
	<20050328073405.GQ16169@viasys.com>
	<20050328165501.GR16169@viasys.com>
	<16968.40186.628410.152511@cse.unsw.edu.au>
	<20050329215207.GE5018@logos.cnet>
	<16970.9679.874919.876412@cse.unsw.edu.au>
	<20050330115946.GA7331@logos.cnet>
	<1112740856.4148.145.camel@sisko.sctweedie.blueyonder.co.uk>
	<6.0.0.20.2.20050406163929.06ef07b0@mailsv2.y.ecl.ntt.co.jp>
	<1112818233.3377.52.camel@sisko.sctweedie.blueyonder.co.uk>
	<1112889078.2859.264.camel@sisko.sctweedie.blueyonder.co.uk>
	<1113224149.2164.78.camel@sisko.sctweedie.blueyonder.co.uk>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Stephen C. Tweedie" <sct@redhat.com> wrote:
>
> Andrew, what was the exact illegal state of the pages you were seeing
>  when fixing that recent leak?  It looks like it's nothing more complex
>  than dirty buffers on an anon page.

Correct.

>  I think that simply calling
>  try_to_release_page() for all the remaining buffers at umount time will

Presumably these pages have no ->mapping, so try_to_release_page() will
call try_to_free_buffers().

>  be enough to catch these; if that function fails, it tells us that the
>  VM can't reclaim these pages.

Yes, if the buffers are dirty then 2.4's try_to_free_buffers() won't free
them.

>  The only thing that would be required on
>  top of that would be a check that the page is also on the VM LRU lists.

Why do we have dirty buffers left over at umount time?
