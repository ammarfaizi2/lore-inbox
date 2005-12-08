Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932694AbVLHW7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932694AbVLHW7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 17:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932698AbVLHW7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 17:59:06 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:16327 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932694AbVLHW7E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 17:59:04 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: 2.6.15-rc5-mm1 (x86_64-hpet-overflow.patch breaks resume from disk)
Date: Fri, 9 Dec 2005 00:00:21 +0100
User-Agent: KMail/1.9
Cc: Jan Beulich <JBeulich@novell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, Discuss x86-64 <discuss@x86-64.org>
References: <20051204232153.258cd554.akpm@osdl.org> <43980058.76F0.0078.0@novell.com> <20051208224735.GV11190@wotan.suse.de>
In-Reply-To: <20051208224735.GV11190@wotan.suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512090000.22103.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thursday, 8 December 2005 23:47, Andi Kleen wrote:
> On Thu, Dec 08, 2005 at 09:43:52AM +0100, Jan Beulich wrote:
> > I don't know how resume normally handles the re-syncing of the wall
> > clock, but the problem here is obvious: do_timer runs a loop to
> > increment jiffies, which may require significant amounts of time
> > (depending how long the system was sleeping).
> 
> It would be good if someone could submit a patch to fix
> this up properly. It indeed sounds wrong.

Well, timer_resume() does adjust jiffies and wall_jiffies.

The problem seems to be that vxtime.last and/or vxtime.last_tsc are not
adjusted by it which makes the timer interrupt handler unhappy (with the
hpet-overflow patch applied, that is).

Greetings,
Rafael


-- 
Beer is proof that God loves us and wants us to be happy - Benjamin Franklin
