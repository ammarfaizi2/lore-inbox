Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261725AbSJHJdw>; Tue, 8 Oct 2002 05:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261732AbSJHJdw>; Tue, 8 Oct 2002 05:33:52 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:13832 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S261725AbSJHJdv>;
	Tue, 8 Oct 2002 05:33:51 -0400
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kbuild news 
In-reply-to: Your message of "Mon, 07 Oct 2002 07:24:26 MST."
             <20021007.072426.93474936.davem@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 08 Oct 2002 19:39:17 +1000
Message-ID: <28870.1034069957@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Oct 2002 07:24:26 -0700 (PDT), 
"David S. Miller" <davem@redhat.com> wrote:
>No, the kallsyms object file would not need to be seen by
>the btfixup.o generator.  It could therefore be done validly
>as:
>
>	1) build .tmp_vmlinux
>	2) build btfixup.o
>	3) build kallsyms
>	4) link final vmlinux image
>
>The order of #2 and #3 could be transposed and that would be fine too.

Wrong.  Anything that changes the address or size of any symbol or
section invalidates the kallsyms data.  kallsyms must be run on the
definitive vmlinux contents, with everything else already included and
all sizes must be stable.

