Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267538AbUJLSya@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267538AbUJLSya (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Oct 2004 14:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267518AbUJLSxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Oct 2004 14:53:48 -0400
Received: from ylpvm01-ext.prodigy.net ([207.115.57.32]:7653 "EHLO
	ylpvm01.prodigy.net") by vger.kernel.org with ESMTP id S267591AbUJLSwb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Oct 2004 14:52:31 -0400
From: David Brownell <david-b@pacbell.net>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Totally broken PCI PM calls
Date: Tue, 12 Oct 2004 11:52:53 -0700
User-Agent: KMail/1.6.2
Cc: ncunningham@linuxmail.org, Paul Mackerras <paulus@samba.org>,
       Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
References: <1097455528.25489.9.camel@gaston> <200410111437.17898.david-b@pacbell.net> <20041012085349.GA2292@elf.ucw.cz>
In-Reply-To: <20041012085349.GA2292@elf.ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200410121152.53140.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 12 October 2004 1:53 am, Pavel Machek wrote:
> 
> If you are entering S4 or S5 at the end of swsusp basically should not
> matter to anyone. What we tell the drivers is same in both cases.

The problem cases are on resume, where drivers
can see different controller state.  Both S4 and S5
resume can leave it in reset; fine.  But from S4
the other option is the controller being in the state
set up previously by the driver ... yet from S5 the
other option is boot firmware (BIOS etc) mucking
with it, leaving it in any of several states that are
not otherwise documented for resume() paths.

Drivers that don't reset the controller in resume()
will need special handling for those BIOS cases.
That means USB HCDs, and maybe not a lot else
yet in Linux.

- Dave
