Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263798AbUECRMc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbUECRMc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 May 2004 13:12:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263799AbUECRMc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 May 2004 13:12:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:61369 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263798AbUECRMa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 May 2004 13:12:30 -0400
Date: Mon, 3 May 2004 10:05:07 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: rusty@rustcorp.com.au, zwane@arm.linux.org.uk, ak@suse.de
Subject: missing last symbol in /proc/kallsyms
Message-Id: <20040503100507.4e6b9d86.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(2.6.5)

I want to see _einittext as the last (non-module) symbol in
/proc/kallsyms.

_einittext should be the last kernel image symbol listed in
/proc/kallsyms AFAICT (just before module symbols begin).

It (_einittext) is the last symbol listed in my
.tmp_kallsyms2.S file, but for some reason, it's not listed
in /proc/kallsyms.  I've beat my head on it for a little
while, so I'm hoping that someone else can see the problem.
(Zwane has also looked at it a bit.)

I modified scripts/kallsyms.c to print one more symbol at the
end of its list and to increase kallsyms_num_syms by 1, and
that does enable _einittext to be printed in /proc/kallsyms
(and the added symbol is not printed).

Without that change, the end of my /proc/kallsyms file contains:
c04e71d0 t af_unix_init
c04e7260 t packet_init

and the end of the corresponding .tmp_kallsyms2.S file contains:
        .byte 0x00
        .asciz  "af_unix_init"
        .byte 0x00
        .asciz  "packet_init"
        .byte 0x00
        .asciz  "_einittext"

Where is the off-by-1?  I want my _einittext.

--
~Randy
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature) -- akpm
