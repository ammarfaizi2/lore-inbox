Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292429AbSBPQmh>; Sat, 16 Feb 2002 11:42:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292430AbSBPQm1>; Sat, 16 Feb 2002 11:42:27 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:18694 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S292429AbSBPQmK>; Sat, 16 Feb 2002 11:42:10 -0500
Subject: Re: Disgusted with kbuild developers
To: esr@thyrsus.com
Date: Sat, 16 Feb 2002 16:55:47 +0000 (GMT)
Cc: jgarzik@mandrakesoft.com (Jeff Garzik), davej@suse.de (Dave Jones),
        lm@work.bitmover.com (Larry McVoy),
        arjan@pc1-camc5-0-cust78.cam.cable.ntl.com (Arjan van de Ven),
        linux-kernel@vger.kernel.org
In-Reply-To: <20020216095345.N23546@thyrsus.com> from "Eric S. Raymond" at Feb 16, 2002 09:53:45 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16c87n-0006bd-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's not that simple, either.  You have to track the symbols that are
> *supposed* to be different between trees.  The devil is in the details --
> and it's a big devil.

(Not tested but something like this ought to split them neatly out of
 a master tree into the 2.4 format)

for i in $(find . -name "[Cc]onfig.in" -print)
do
	grep CONFIG_ '$i'
done | sort -u |
while read x
do
	grep -B1 -A200 '$x' MasterConfigHelpFile |
	( 
		read A
		read B
		cat > frob
	)
	ed frob << 'FOO'
	/^$
	.,$d
	wq
	'FOO' >/dev/null
	cat frob
done

