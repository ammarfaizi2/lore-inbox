Return-Path: <linux-kernel-owner+w=401wt.eu-S965297AbXAHJ0T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965297AbXAHJ0T (ORCPT <rfc822;w@1wt.eu>);
	Mon, 8 Jan 2007 04:26:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965298AbXAHJ0T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Jan 2007 04:26:19 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:18093 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965297AbXAHJ0T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Jan 2007 04:26:19 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=tqupE5z3aJ7l1q3+WkUbGEavriPemAsDxv4xOEHxQaKLBJHNywUaCdxLq4GqVA9jnyooU1WJ0CNez3l3bTNoYZWAG6r7IIZkDGYVP4DC47LrtkMpMJbQ5O27OrtCxZgtFNZA0RhbjauG4FxYPRvjWsaB1E3aNCN9Lnjza62429s=
Message-ID: <84144f020701080126l550bba8v590cf00b12d46585@mail.gmail.com>
Date: Mon, 8 Jan 2007 11:26:17 +0200
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Amit Choudhary" <amit2030@yahoo.com>
Subject: Re: [PATCH] include/linux/slab.h: new KFREE() macro.
Cc: "Hua Zhong" <hzhong@gmail.com>, "Christoph Hellwig" <hch@infradead.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <552712.75479.qm@web55603.mail.re4.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <84144f020701080045x52b1b9a3u8caf8b88856ceb@mail.gmail.com>
	 <552712.75479.qm@web55603.mail.re4.yahoo.com>
X-Google-Sender-Auth: c6974190079d2aeb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/8/07, Amit Choudhary <amit2030@yahoo.com> wrote:
> It is a programming error because the underlying code cannot handle it.

Yes. Do you also grasp the fact that there is no way for the allocator
to handle it either? So, double-free, from allocator standpoint can
_never_ be no-op.

What you're proposing is _not_ making double-free no-op, but instead,
making sure we never have a reference to p after kfree(p). However,
(1) that bloats the kernel text and (2) doesn't actually guarantee
that there are _no_ references to p (you can have an alias q for it,
but there's no way for us to know that).
