Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319593AbSIMKM1>; Fri, 13 Sep 2002 06:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319594AbSIMKM1>; Fri, 13 Sep 2002 06:12:27 -0400
Received: from pD952AD04.dip.t-dialin.net ([217.82.173.4]:31979 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S319593AbSIMKM1>; Fri, 13 Sep 2002 06:12:27 -0400
Date: Fri, 13 Sep 2002 04:17:15 -0600 (MDT)
From: Thunder from the hill <thunder@lightweight.ods.org>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Giuliano Pochini <pochini@shiny.it>
cc: riel@conectiva.com.br,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Jim Sibley <jlsibley@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Jesse Pollard <pollard@admin.navo.hpc.mil>
Subject: Re: Killing/balancing processes when overcommited
In-Reply-To: <XFMail.20020913095116.pochini@shiny.it>
Message-ID: <Pine.LNX.4.44.0209130412040.10048-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf/Steudnitz; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 13 Sep 2002, Giuliano Pochini wrote:
> > ...the last of the user who has the most processes?
> 
> No, the last one it's likely to be the sysadmin that
> logged in to try to fix the situation.

Not exactly.

if (we run oom) {
	if (we find a malloc() eater) {
		kill it;
	} else if (there's an ->user<- who forked lots of processes) {
		kill some;
	} else {
		kill randomly, based on some table, or whatever...;
	}
}

Means we only kill processes if (task->euid) in the second stage. Malloc 
eaters are likely to be system jobs (such as data servers), so we better 
don't check the UID then.

			Thunder
-- 
--./../...-/. -.--/---/..-/.-./..././.-../..-. .---/..-/.../- .-
--/../-./..-/-/./--..-- ../.----./.-../.-.. --./../...-/. -.--/---/..-
.- -/---/--/---/.-./.-./---/.--/.-.-.-
--./.-/-.../.-./.././.-../.-.-.-

