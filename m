Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbTH1NRh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 09:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264074AbTH1NRg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 09:17:36 -0400
Received: from dub.inr.ac.ru ([193.233.7.105]:18623 "HELO dub.inr.ac.ru")
	by vger.kernel.org with SMTP id S264061AbTH1NRf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 09:17:35 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200308281317.RAA20747@dub.inr.ac.ru>
Subject: Re: tasklet_kill will always hang for recursive tasklets on a UP
To: nagendra_tomar@adaptec.com
Date: Thu, 28 Aug 2003 17:17:06 +0400 (MSD)
Cc: wa@almesberger.net, quade@hsnr.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0308262141480.1471-100000@localhost.localdomain> from "Nagendra Singh Tomar" at  =?ISO-8859-1?Q?=20=E1?=
	=?ISO-8859-1?Q?=D7=C7?= 26, 2003 09:47:35 
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Either the tasklet_kill hangs (which will happen on UP)

Never can happen, unless you are trying to call tasklet_kill
from softirq context, which is illegal.


> So I believe that at least one (to be precise, the last one called before 
> tasklet dies) tasklet_schedule is not honoured.

You cannot call tasklet_schedule while kill is called. As I said in previous
mail, preventing new schedules is responsibility of callers. tasklet struct
and control functions do not maintain any information about its state, it is
for client to handle this in his preferred way.

You are right when saying the name is misnomer. tasklet_kill does not kill,
it waits for the moment when tasklet becomes really dead after client
strangled it with his own hands.

Alexey
