Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263292AbTKKAFp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 19:05:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263302AbTKKAFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 19:05:45 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:44804 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S263292AbTKKAFn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 19:05:43 -0500
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Re: [patch] reproducible athlon mce fix
Date: 10 Nov 2003 23:55:10 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bop8gu$7uk$1@gatekeeper.tmr.com>
References: <20031102055748.GA1218@anakin.wychk.org> <20031102072519.GD530@alpha.home.local>
X-Trace: gatekeeper.tmr.com 1068508510 8148 192.168.12.62 (10 Nov 2003 23:55:10 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20031102072519.GD530@alpha.home.local>,
Willy Tarreau  <willy@w.ods.org> wrote:

| I don't know if the patch is correct, but :
| 
| On Sun, Nov 02, 2003 at 01:57:48PM +0800, Geoffrey Lee wrote:
| >  	preempt_disable(); 
| > +#if CONFIG_MK7
| > +	for (i=1; i<nr_mce_banks; i++) {
| > +#else
| >  	for (i=0; i<nr_mce_banks; i++) {
| > +#endif
| 
| Including opening braces within #if often fools editors such as emacs
| which count them and don't know about #if. Then, editing the rest of
| the file can become annoying because it simply thinks that there are
| two embedded for loops.

Wouldn't it be easier to just move the brace out of the ifdef and put it
on a line by itself? Readable, doesn't confuse, etc?

  	preempt_disable(); 
 +#if CONFIG_MK7
 +	for (i=1; i<nr_mce_banks; i++) {
 +#else
 - 	for (i=0; i<nr_mce_banks; i++) {
 + 	for (i=0; i<nr_mce_banks; i++)
 +#endif
        {

or similar. Otherwise I guess the solution defining a starting value
would be "less unreadable."


-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
