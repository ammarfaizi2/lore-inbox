Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132871AbRDIXHQ>; Mon, 9 Apr 2001 19:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132875AbRDIXHG>; Mon, 9 Apr 2001 19:07:06 -0400
Received: from green.mif.pg.gda.pl ([153.19.42.8]:28420 "EHLO
	green.mif.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S132871AbRDIXGx>; Mon, 9 Apr 2001 19:06:53 -0400
From: Andrzej Krzysztofowicz <ankry@green.mif.pg.gda.pl>
Message-Id: <200104092307.BAA01708@green.mif.pg.gda.pl>
Subject: Re: PROBLEM: make oldconfig can change Alpha system type on 2.2.19
To: bacam@tardis.ed.ac.uk
Date: Tue, 10 Apr 2001 01:07:14 +0200 (CEST)
Cc: linux-kernel@vger.kernel.org (kernel list), linux-alpha@vger.kernel.org
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From kufel!ankry  Tue Apr 10 01:04:13 2001
Return-Path: <kufel!ankry>
Received: from kufel.UUCP (uucp@localhost)
	by green.mif.pg.gda.pl (8.9.3/8.9.3) with UUCP id BAA01672
	for green.mif.pg.gda.pl!ankry; Tue, 10 Apr 2001 01:04:13 +0200
Received: (from ankry@localhost)
	by kufel.dom (8.9.3/8.9.3) id BAA03695
	for ankry@green.mif.pg.gda.pl; Tue, 10 Apr 2001 01:04:06 +0200
From: Andrzej Krzysztofowicz <kufel!ankry>
Message-Id: <200104092304.BAA03695@kufel.dom>
Subject: Re: PROBLEM: make oldconfig can change Alpha system type on 2.2.19
To: kufel!green.mif.pg.gda.pl!ankry
Date: Tue, 10 Apr 2001 01:04:06 +0200 (CEST)
In-Reply-To: <200104051300.PAA16390@sunrise.pg.gda.pl> from "Andrzej Krzysztofowicz" at kwi 05, 2001 03:00:40 
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

"Brian Campbell wrote:"
> To: linux-kernel@vger.kernel.org
> From: Brian Campbell <bacam@tardis.ed.ac.uk>

> [1.] One line summary of the problem:    
> make oldconfig can change Alpha system type on 2.2.19
> 
> [2.] Full description of the problem/report:
> With the system type set to `Cabriolet' (CONFIG_ALPHA_CABRIOLET)
> running make oldconfig causes it to change to `EB64+' (CONFIG_ALPHA_EB64P)
> without asking.

As I see the same problem appears also with the following Alpha architecture
settings:

Alpha-XL (-> Avanti)
AlphaBook1 (-> Noname)

As it is quite easy to avoid this mis-setting in Configure (make
config/oldconfig) by the following hack:

if [ "$CONFIG_ALPHA_CABRIOLET" = "y" ]; then
	unset CONFIG_ALPHA_EB64P
fi
if [ "$CONFIG_ALPHA_XL" = "y" ]; then
	unset CONFIG_ALPHA_AVANTI
fi
if [ "$CONFIG_ALPHA_BOOK1" = "y" ]; then
	unset CONFIG_ALPHA_NONAME
fi
choice 'Alpha system type' ...

it can't help with xconfig. And (IMHO) it is just a hack, not a proper
solution.
The proper solution is probably to move three of the above "system type"
settings outside the main menu. Does anybody know differences between the
mentioned above three pairs of system types and how to do it?

Same problem appears in the 2.4 series.

Andrzej


-- 
=======================================================================
  Andrzej M. Krzysztofowicz               ankry@mif.pg.gda.pl
  tel.  (0-58) 347 14 61
Wydz.Fizyki Technicznej i Matematyki Stosowanej Politechniki Gdanskiej
