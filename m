Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314078AbSEMQKQ>; Mon, 13 May 2002 12:10:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314080AbSEMQKP>; Mon, 13 May 2002 12:10:15 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:10921 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314078AbSEMQKP>; Mon, 13 May 2002 12:10:15 -0400
Date: Mon, 13 May 2002 12:10:08 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Pete Zaitcev <zaitcev@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Strange s390 code in 2.4.19-pre8
Message-ID: <20020513121008.B29935@devserv.devel.redhat.com>
In-Reply-To: <OFFA479633.3A335CB7-ONC1256BB8.002ABB8D@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
> Date: Mon, 13 May 2002 09:54:59 +0200

> > #2 - strange changes to net Makefile
> The intention of this is to have fsm.o built as a module if ctc
> and iucv are built as modules too. I agree that this is broken
> if one of {iucv,ctc} is built as a module and the other is built
> in.

The old Makefile was correct, and the only failing was a namespace
conflict between your fsm.c and fsm.c in ISDN, when CONFIG_MODVERSIONS
are used. The right fix is to rename your fsm.c or to create
fsm_s390_ksyms.c with all EXPORT_SYMBOL's sitting in there.
It is fixed in 2.5 with $(MODPREFIX) in Rules.make.

-- Pete
