Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129132AbQKPGpc>; Thu, 16 Nov 2000 01:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129492AbQKPGpW>; Thu, 16 Nov 2000 01:45:22 -0500
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:14137 "EHLO
	pneumatic-tube.sgi.com") by vger.kernel.org with ESMTP
	id <S129132AbQKPGpL> convert rfc822-to-8bit; Thu, 16 Nov 2000 01:45:11 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: "H. Peter Anvin" <hpa@zytor.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Modprobe local root exploit 
In-Reply-To: Your message of "15 Nov 2000 22:04:47 -0800."
             <8uvtdv$c3q$1@cesium.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Date: Thu, 16 Nov 2000 17:14:54 +1100
Message-ID: <10170.974355294@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Nov 2000 22:04:47 -0800, 
"H. Peter Anvin" <hpa@zytor.com> wrote:
>No, it's correct, actually, but probably not what you want.  It will
>include all letters [A-Za-z], but if a module named "ärlig"...

Trying to sanitise the module name in request_module is the wrong fix
anyway, the kernel can ask for any module name it likes.  What it must
not do is treat user supplied input _unchanged_ as a module name.

modutils 2.3.20 (just released) fixes all the known local root
exploits, without kernel changes.  However 2.3.20 does nothing about
this problem: "ping6 -I module_name" which lets any user load any
module.  That problem exists because the kernel passes user supplied
data unchanged to request_module.  The only fix is to add a prefix to
user supplied input (say 'user-interface-') before passing the text to
request_module.  This has to be fixed in the higher layers of the
kernel, it cannot be fixed in request_module or modprobe.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
