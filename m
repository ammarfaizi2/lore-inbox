Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315928AbSHIVJ0>; Fri, 9 Aug 2002 17:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315942AbSHIVJ0>; Fri, 9 Aug 2002 17:09:26 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:39955 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S315928AbSHIVJZ>;
	Fri, 9 Aug 2002 17:09:25 -0400
Date: Fri, 9 Aug 2002 23:13:06 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Andrew Morton <akpm@zip.com.au>
Cc: Phil Auld <pauld@egenera.com>, linux-kernel@vger.kernel.org
Subject: Re: why is lseek broken (>= 2.4.11) ?
Message-ID: <20020809211306.GA1252@win.tue.nl>
References: <20020809084915.P3542@vienna.EGENERA.COM> <3D542AAE.64B70B55@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D542AAE.64B70B55@zip.com.au>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 09, 2002 at 01:48:47PM -0700, Andrew Morton wrote:

> What should the behaviour be?   The lseek should succeed,

Yes

> but subsequent reads and writes return zero?

Yes. The first read must return 0. Subsequent reads may return 0
or return the ENXIO error.

For read: "No data transfer shall occur past the current end-of-file.
If the starting position is at or after the end-of-file, 0 shall be
returned. If the file refers to a device special file, the result of
subsequent read() requests is implementation-defined."

ENXIO: "the request was outside the capabilities of the device".

For write: "If a write() requests that more bytes be written than
there is room for (for example, ... the physical end of a medium),
only as many bytes as there is room for shall be written.


Andries
