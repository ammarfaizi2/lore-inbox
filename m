Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129492AbQKPGrM>; Thu, 16 Nov 2000 01:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129738AbQKPGrC>; Thu, 16 Nov 2000 01:47:02 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:40975 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S129492AbQKPGqs> convert rfc822-to-8bit; Thu, 16 Nov 2000 01:46:48 -0500
Message-ID: <3A137BC7.CE072C5F@transmeta.com>
Date: Wed, 15 Nov 2000 22:16:39 -0800
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10-pre3 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Keith Owens <kaos@ocs.com.au>
CC: "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit
In-Reply-To: <10170.974355294@kao2.melbourne.sgi.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id WAA07998
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens wrote:
> 
> On 15 Nov 2000 22:04:47 -0800,
> "H. Peter Anvin" <hpa@zytor.com> wrote:
> >No, it's correct, actually, but probably not what you want.  It will
> >include all letters [A-Za-z], but if a module named "ärlig"...
> 
> Trying to sanitise the module name in request_module is the wrong fix
> anyway, the kernel can ask for any module name it likes.  What it must
> not do is treat user supplied input _unchanged_ as a module name.
> 
> modutils 2.3.20 (just released) fixes all the known local root
> exploits, without kernel changes.  However 2.3.20 does nothing about
> this problem: "ping6 -I module_name" which lets any user load any
> module.  That problem exists because the kernel passes user supplied
> data unchanged to request_module.  The only fix is to add a prefix to
> user supplied input (say 'user-interface-') before passing the text to
> request_module.  This has to be fixed in the higher layers of the
> kernel, it cannot be fixed in request_module or modprobe.
> 

Sure, but if you have to change the kernel anyway you ought to pass the
"--" option so modprobe knows that regardless what the string is, it's a
module name and not an option.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
