Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271005AbRICB3A>; Sun, 2 Sep 2001 21:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271007AbRICB2k>; Sun, 2 Sep 2001 21:28:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:50189 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S271005AbRICB22>; Sun, 2 Sep 2001 21:28:28 -0400
Subject: Re: Editing-in-place of a large file
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Date: Mon, 3 Sep 2001 02:31:58 +0100 (BST)
Cc: linux-kernel@vger.kernel.org,
        mcelrath+linux@draal.physics.wisc.edu (Bob McElrath)
In-Reply-To: <20010903032439.A802@nightmaster.csn.tu-chemnitz.de> from "Ingo Oeser" at Sep 03, 2001 03:24:39 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15diak-0000mq-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Another solution for the original problem is to rewrite the file
> in-place by coping from the end of the gap to the beginning of
> the gap until the gap is shifted to the end of the file and thus
> can be left to ftruncate().

Another approach would be to keep your own index of blocks and use that
for the data reads. Since fdelete and fzero wont actually relayout the files
in order to make the data linear (even if such calls existed) there isnt
much point performancewise doing it in kernel space - its a very specialised
application
