Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261701AbVAITGs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVAITGs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jan 2005 14:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbVAITGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jan 2005 14:06:47 -0500
Received: from canuck.infradead.org ([205.233.218.70]:50693 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261701AbVAITGp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jan 2005 14:06:45 -0500
Subject: Re: [PATCH] scheduling priorities with rlimit
From: Arjan van de Ven <arjan@infradead.org>
To: utz lehmann <lkml@s2y4n2c.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@osdl.org>
In-Reply-To: <1105290936.24812.29.camel@segv.aura.of.mankind>
References: <1105290936.24812.29.camel@segv.aura.of.mankind>
Content-Type: text/plain
Date: Sun, 09 Jan 2005 20:06:37 +0100
Message-Id: <1105297598.4173.52.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-01-09 at 18:15 +0100, utz lehmann wrote:
> Hi
> 
> I really like the idea of controlling the maximum settable scheduling
> priorities via rlimit. See the Realtime LSM thread. I want to give users
> the right to raise the priority of previously niced jobs.
> 
> I have modified Chris Wright's patch (against 2.6.10):
> (http://marc.theaimsgroup.com/?l=linux-kernel&m=110513793228776&w=2)
> 
> - allow always to increase nice levels (lower priority).
> - set the default for RLIMIT_PRIO to 0.
> - add the other architectures.
> 
> With this the default is compatible with the old behavior.
> 
> With RLIMIT_PRIO > 0 a user is able to raise the priority up to the
> value. 0-39 for nice levels 19 .. -20, 40-139 for realtime priorities
> (0 .. 99).

this is a bit of an awkward interface don't you think?
I much rather have the rlimit match the exact nice values we communicate
to userspace elsewhere, both to be consistent and to not expose
scheduler internals to userpsace.


Also I like the idea of allowing sysadmins to make certain users/groups
nice levels 5 and higher (think a university machine that makes all
students nice 5 and higher only, while giving staff 0 and higher, and
the sysadmin -5 and higher ;)

