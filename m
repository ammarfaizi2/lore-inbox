Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266071AbSKFTcQ>; Wed, 6 Nov 2002 14:32:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266077AbSKFTcQ>; Wed, 6 Nov 2002 14:32:16 -0500
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:36858 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S266071AbSKFTcP>;
	Wed, 6 Nov 2002 14:32:15 -0500
Date: Wed, 6 Nov 2002 14:38:49 -0500
From: Adam Kropelin <akropel1@rochester.rr.com>
To: Clayton Weaver <cgweav@email.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.4.19] read(2) and page aligned buffers
Message-ID: <20021106193849.GA640@www.kroptech.com>
References: <20021106181358.11684.qmail@email.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021106181358.11684.qmail@email.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 01:13:57PM -0500, Clayton Weaver wrote:
> a short count with errno == 0, the wrapper loops
> and tries to read the rest of the file to the
> offset into the buffer past what it already read,
> read() returns 0 with errno still == 0, and of
> course the wrapper decides that it must be at
> EOF (read() == 0 && errno == 0) and returns.

This isn't necessarily the cause of your problem, but your description
here smells an awful lot like classic errno abuse. errno is only valid
when read() returns -1. The check you cite in your last sentence is
illegal.

If read() returns 0, you're done. You're at EOF. If you're not actually
at EOF then *that* is a bug.

--Adam

