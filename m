Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbUJEUL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbUJEUL1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 16:11:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUJEUL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 16:11:27 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:43757 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261375AbUJEUIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 16:08:47 -0400
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: PATCH/RFC: driver model/pmcore wakeup hooks (1/4)
Date: Tue, 5 Oct 2004 13:09:02 -0700
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
References: <200410041400.04385.david-b@pacbell.net> <20041005193737.GD4723@openzaurus.ucw.cz>
In-Reply-To: <20041005193737.GD4723@openzaurus.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410051309.02105.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 05 October 2004 12:37 pm, Pavel Machek wrote:
> Hi!
> 
> > This lets drivers standardize how they present their ability to issue
> > wakeups, and how they manage whether that ability should be used.
> 
> Why do you assign "enabled" to variable instead of using it directly?

So there's exactly one copy of that string in use, agreeing with itself.
Also, so strncmp() can be used.  It won't matter if the sysadmin goes

   echo -n enabled > wakeup
   echo enabled > wakeup

I'd personally rather use "on" and "off", but there seems to be
a convention in /proc/acpi/wakeup in favor of polysyllabicism.


> And perhaps you should print "not supported" instead of empty string...

Except that's two words, not one, which will make shell script
bugs happen more readily.  I thought about "(none)" which
has the same issue, and "-".  But I figured that if it were very
important, a good solution would appear ... ;)

- Dave
