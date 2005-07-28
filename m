Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbVG1CWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbVG1CWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 22:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVG1CWS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 22:22:18 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:27875 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261252AbVG1CWQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 22:22:16 -0400
X-ORBL: [69.107.32.110]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=qTk6e2DOA28dM5jc+Dhn/oqj8xsGSFZ3ywk9mjowV14ojceAFQpZiDAn3cDpi37ay
	g79jW95sS7BUJEJhGwORw==
Date: Wed, 27 Jul 2005 19:21:51 -0700
From: david-b@pacbell.net
To: ncunningham@cyclades.com, ebiederm@xmission.com
Subject: Re: [linux-pm] Re: [PATCH 1/23] Add missing 
 device_suspsend(PMSG_FREEZE) calls.
Cc: torvalds@osdl.org, linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <m1mzo9eb8q.fsf@ebiederm.dsl.xmission.com>
 <m1iryxeb4t.fsf@ebiederm.dsl.xmission.com>
 <1122400462.4382.13.camel@localhost>
 <m1k6jb7myp.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1k6jb7myp.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050728022151.3B048DAA01@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> And there is of course the puzzle of why there exists simultaneously
> driver shutdown() and suspend(PMSG_FREEZE) methods as I believed they
> are defined to do exactly the same thing.

No puzzle; that's not how they're defined.  Both of them cause the
device to quiesce that device's activity.  But:

 - shutdown() is a "dirty shutdown OK" heads-up for some level
   of restart/reboot; hardware will be completely re-initialized
   later, normally with hardware level resets and OS rebooting.

 - freeze() is a "clean shutdown only" that normally sees hardware
   state preserved, and is followed by suspend() or resume().

Or so I had understood.  That does suggest why having FREEZE in the
reboot path could be trouble:  you could be rebooting because that
hardware won't do a clean shutdown!

- Dave

