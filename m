Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129401AbRAEPXe>; Fri, 5 Jan 2001 10:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131749AbRAEPXY>; Fri, 5 Jan 2001 10:23:24 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:17882 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S129401AbRAEPXT>;
	Fri, 5 Jan 2001 10:23:19 -0500
Date: Fri, 5 Jan 2001 16:23:13 +0100 (MET)
From: Mikael Pettersson <mikpe@csd.uu.se>
Message-Id: <200101051523.QAA26873@harpo.it.uu.se>
To: jgarzik@mandrakesoft.com, mea@nic.funet.fi
Subject: 2.4.0 tulip bug (was: And oh, btw..)
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Jan 2001, Linus Torvalds wrote:

>Changes since the prerelease:
>...
>Matti Aarnio:
> - teach tulip driver about media types 5 and 6

This part of the patch introduces a bug in 2.4.0, as noticed by gcc:

media.c: In function `tulip_select_media':
media.c:268: warning: unused variable `csr15val'
media.c:268: warning: unused variable `csr15dir'
media.c:268: warning: unused variable `csr14val'
media.c:268: warning: unused variable `csr13val'
media.c:151: warning: `new_csr6' might be used uninitialized in this function

The last warning indicates a real problem. The patch adds a new
control flow path in which new_csr6 is _not_ assigned a value,
which causes the procedure's second last statement

	tp->csr6 = new_csr6 | (tp->csr6 & 0xfdff) | (tp->full_duplex ? 0x0200 : 0);

to 'or' random bits into tp->csr6.

The patch also adds four unused variables, which looks rather fishy.

/Mikael
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
