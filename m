Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbUKWScA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbUKWScA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 13:32:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261491AbUKWSaI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 13:30:08 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:58254 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261479AbUKWS2j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:28:39 -0500
In-Reply-To: <20041123104215.GE27064@mail.shareable.org>
To: Jamie Lokier <jamie@shareable.org>
Cc: Jesper Juhl <juhl-lkml@dif.dk>,
       linux-fsdevel <linux-fsdevel@vger.kernel.org>,
       linux-fsdevel-owner@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Matthew Wilcox <matthew@wil.cx>, Linus Torvalds <torvalds@osdl.org>
MIME-Version: 1.0
Subject: Re: [PATCH] Remove pointless <0 comparison for unsigned variable in fs/fcntl.c
X-Mailer: Lotus Notes Release 6.0.2CF1 June 9, 2003
Message-ID: <OF1B36F096.86C07CEE-ON88256F55.00653896-88256F55.00658654@us.ibm.com>
From: Bryan Henderson <hbryan@us.ibm.com>
Date: Tue, 23 Nov 2004 10:28:23 -0800
X-MIMETrack: Serialize by Router on D01ML604/01/M/IBM(Build V70_M3_11102004|November 10, 2004) at
 11/23/2004 13:28:37,
	Serialize complete at 11/23/2004 13:28:37
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The unusual thing about this function is that "arg" is really
>polymorphic, but given type "unsigned long" in the kernel.  It is
>really a way to hold arbitrary values of any type.

As you've described it, what's wrong with this code is not that it tests 
arg < 0, but that it should cast arg to int before doing so:

  int signal_arg = (int) arg;
  if (signal_arg < 0) ...


