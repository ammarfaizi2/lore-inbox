Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263484AbUEKToF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263484AbUEKToF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 15:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263540AbUEKToF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 15:44:05 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:7087 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S263484AbUEKToD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 15:44:03 -0400
Date: Tue, 11 May 2004 21:43:59 +0200 (CEST)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: andre@bluetheta.com
cc: linux-kernel@vger.kernel.org
Subject: Re: Multithreaded select() bug
Message-ID: <Pine.LNX.4.44.0405112136370.1089-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

> As I understand it, if 1 is true (which corresponds to my original
> post), then select should return the moment the socket gets closed

One problem: You do not close the socket. The select() call itself keeps
the socket open ;-)

It was discussed a few months ago with poll(): The standard is wrong,
noone implements it as specified. Just think what should happen if the
selected fd is replaced with dup2(). HP UX kills the process if you do
that with poll - I expect that select causes the same result.

You'll have to change your user space app.

--
	Manfred

