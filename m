Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129045AbQKNX6G>; Tue, 14 Nov 2000 18:58:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129047AbQKNX5z>; Tue, 14 Nov 2000 18:57:55 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:49679 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129045AbQKNX5s>;
	Tue, 14 Nov 2000 18:57:48 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: More modutils: It's probably worse. 
In-Reply-To: Your message of "14 Nov 2000 11:42:42 -0800."
             <8us4ji$dbl$1@cesium.transmeta.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 15 Nov 2000 10:27:43 +1100
Message-ID: <11900.974244463@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Nov 2000 11:42:42 -0800, 
"H. Peter Anvin" <hpa@zytor.com> wrote:
>Seriously, though, I don't see any reason modprobe shouldn't accept
>funky filenames.  There is a standard way to do that, which is to have
>an argument consisting of the string "--"; this indicates that any
>further arguments should be considered filenames and not options.

The original exploit had nothing to do with filenames masquerading as
options, it was: ping6 -I ';chmod o+w .'.  Then somebody pointed out
that -I '-C/my/config/file' could be abused as well.  '--' fixes the
second exploit but not the first.

The problem is the combination of kernel code passing user space
parameters through unchanged (promoting user input to root) plus the
modprobe meta expansion algorithm.  By treating the last parameter from
the kernel as a tainted module name (not an option) and suppressing
meta expansion on tainted parameters, modprobe removes enough of the
problem to be safe.

My changes to modprobe do nothing about this: "ping6 -I binfmt_misc".
That construct lets a user load any module.  However that is a pure
kernel problem which needs to be fixed by the developers who call
request_module.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
