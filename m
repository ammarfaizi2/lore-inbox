Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751548AbWAKN2x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751548AbWAKN2x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 08:28:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751571AbWAKN2x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 08:28:53 -0500
Received: from ns.firmix.at ([62.141.48.66]:46818 "EHLO ns.firmix.at")
	by vger.kernel.org with ESMTP id S1751548AbWAKN2x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 08:28:53 -0500
Subject: Re: OT: fork(): parent or child should run first?
From: Bernd Petrovitsch <bernd@firmix.at>
To: lgb@lgb.hu
Cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20060111130255.GC30219@lgb.hu>
References: <20060111123745.GB30219@lgb.hu>
	 <1136983910.2929.39.camel@laptopd505.fenrus.org>
	 <20060111130255.GC30219@lgb.hu>
Content-Type: text/plain; charset=UTF-8
Organization: Firmix Software GmbH
Date: Wed, 11 Jan 2006 14:25:18 +0100
Message-Id: <1136985918.6547.115.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-01-11 at 14:02 +0100, Gábor Lénárt wrote:
> Hello,
> 
> Ok, you're absolutly right here. My problem is to find some solution and not
> to change the behaviour of fork() of course :) It's quite annoying to
> introduce some kind of IPC between parent and childs just for transferring a
> single pid_t ;-) Using exit status would be great (I would transfer "n")
> because it can be got by eg waitpid() in signal handler, however exit status
> is limited it status & 0377 which is too short range for us ;-( As a
> solution I've created a pid_t array and a counter which is filled by signal
> handler with pid_t got by waitpid() and then I use it in the main loop to do
> the cleanup in parent. Well, this is quite good, the only problem of mine
> that some kind of race condition may occur when altering/using these
> structures between the main loop and signal handler ...

Disabling signals for most of the main loop and activating them just
around the select()/poll/... is one solution to the problem.

Then this leaves the race if an old pid is reused in a newly created
process before the last instances of that pid is cleaned up. But this is
probably only a theoretical problem (unless you fork() very very
often) ....

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

