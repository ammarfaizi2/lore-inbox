Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWGLKit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWGLKit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 06:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWGLKit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 06:38:49 -0400
Received: from nz-out-0102.google.com ([64.233.162.195]:16001 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751241AbWGLKit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 06:38:49 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BfSMrbJf1r+13phAMJKenS0da2u9T5JsGCr0SzK/8KV1ul3pGk3JRcsf7PE4ejDB1LI9P0K8xouBtdeKYuRDGOZedYzIAd1HO7rltuwig2fEmqzEKxlyUPTykM13A4H66Lwxa5KwkbX/6o89IEiPVdk7GJpWgDD2i77gg4UttHk=
Message-ID: <b0943d9e0607120338r37886ebck56db5fbf29e8e350@mail.gmail.com>
Date: Wed, 12 Jul 2006 11:38:48 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/10] Kernel memory leak detector 0.8
In-Reply-To: <20060712095730.GA19478@nineveh.rivenstone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <6bffcb0e0607110527x4520d5bbne8b9b3639a821a18@mail.gmail.com>
	 <6bffcb0e0607110546r11d2f619pbcd1205999253bd@mail.gmail.com>
	 <6bffcb0e0607110551v272deebcua5dc3f782ed25a7f@mail.gmail.com>
	 <b0943d9e0607110600q345b5ad7y38174b85cf01edba@mail.gmail.com>
	 <20060712095730.GA19478@nineveh.rivenstone.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/07/06, Joseph Fannin <jfannin@gmail.com> wrote:
> On Tue, Jul 11, 2006 at 02:00:05PM +0100, Catalin Marinas wrote:
> > That's a bug in gcc-4. The __builtin_constant_p() function always
> > returns true even when the argument is not a constant. You could try a
> > gcc-3.4 or a patched gcc.
>
>     Which gcc versions are affected by this?

>From gcc-4.0 I think but I don't know when/if it was fixed in the
latest. I use CodeSourcery's toolchain and they fixed in in gcc-4.1
but that's with their own patches. Try to compile the code below. It
should work if the toolchain is OK:

        #include <stdlib.h>

        #define EXPR    atoi(argv[1])

        int main(int argc, char *argv[])
        {
            static int a[] = {
                __builtin_constant_p(EXPR) ? EXPR : 0
            };

            return a[0];
        }

-- 
Catalin
