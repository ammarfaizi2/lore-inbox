Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129163AbQKNK7s>; Tue, 14 Nov 2000 05:59:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129461AbQKNK7j>; Tue, 14 Nov 2000 05:59:39 -0500
Received: from mailhost.tue.nl ([131.155.2.5]:56681 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S129163AbQKNK72>;
	Tue, 14 Nov 2000 05:59:28 -0500
Message-ID: <20001114112926.A1498@win.tue.nl>
Date: Tue, 14 Nov 2000 11:29:26 +0100
From: Guest section DW <dwguest@win.tue.nl>
To: Olaf Kirch <okir@caldera.de>, Michal Zalewski <lcamtuf@dione.ids.pl>
Cc: BUGTRAQ@securityfocus.com, linux-kernel@vger.kernel.org
Subject: Re: More modutils: It's probably worse.
In-Reply-To: <Pine.LNX.4.21.0011132040160.1699-100000@ferret.lmh.ox.ac.uk> <Pine.LNX.4.21.0011132352550.31869-100000@dione.ids.pl> <20001114095921.E30730@monad.caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20001114095921.E30730@monad.caldera.de>; from Olaf Kirch on Tue, Nov 14, 2000 at 09:59:22AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 14, 2000 at 09:59:22AM +0100, Olaf Kirch wrote:

> PS: The load_nls code tries to check for buffer overflows, but
>     gets it wrong:
> 
> 	struct nls_table *nls;
> 	char	buf[40];
> 
> 	if (strlen(charset) > sizeof(buf) - sizeof("nls_"))
> 		fail;
> 	sprintf(buf, "nls_%s", charset);
> 
>     This will accept charset names of up to 35 characters,
>     because sizeof("nls_") is 5. This gives you a single NUL byte
>     overflow. Whether it's dangerous or not depends on whether your
>     compiler reserves stack space for the *nls pointer or not...

Where is the overflow? If charset has 35 characters then
	sprintf(buf, "nls_%s", charset);
writes 40 bytes into buf, and that fits.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
